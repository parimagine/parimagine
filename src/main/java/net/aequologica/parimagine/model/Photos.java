package net.aequologica.parimagine.model;

import static com.google.common.collect.Collections2.filter;
import static com.google.common.collect.Lists.newArrayList;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.fr.FrenchAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.index.IndexWriterConfig.OpenMode;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;
import org.apache.lucene.util.Version;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Predicate;

public class Photos {
    
    private static Photos instance = null;
    
    public static Photos getInstance() throws IOException {
        if (Photos.instance == null) {
            Photos.instance = new Photos();
        }
        return Photos.instance;
    }

    final ArrayList<Photo> list; // toutes les photos, must be array list
    final Map<String, Photo> image2photoMap; 
    final Map<Integer, List<Photo>> districtLists = new HashMap<>();
    final Map<String, List<Photo>> themeLists = new HashMap<>();

    // must be sorted ! (used in binary search)
    String[] themes = new String[] {
    	    "bals",
    	    "cinema",
    	    "enfants",
    	    "enseignes",
    	    "etudiants",
    	    "fetesaintecatherine",
    	    "halles",
    	    "manifestations",
    	    "metiers",
    	    "police",
    	    "pompiers",
    	    "quais",
    	    "saisons",
    	    "vie-montmartre"
    };
    
    class PredicateDistrict implements Predicate<Photo> {
        
        private Integer district;

        private PredicateDistrict(Integer district) {
            super();
            this.district = district;
        }

        @Override
        public boolean apply(Photo photo) {
            return district.equals(photo.getAddress().getDistrict());
        }
    }
    
    class PredicateTheme implements Predicate<Photo> {
        
        private String theme;

        private PredicateTheme(String theme) {
            super();
            this.theme = theme;
        }

        @Override
        public boolean apply(Photo photo) {
            return photo.getImage().startsWith("photos-presse/"+theme);
        }
    }
    
    private Photos() throws IOException {
        list = load();
        image2photoMap = new HashMap<>();
        for (Photo photo : list) {
            image2photoMap.put(photo.getImage(), photo);
        }
        createIndex();
        Collections.sort(list);
        for (int i = 1; i <= 20; i++) {
            List<Photo> districtList = newArrayList(filter(list, new PredicateDistrict(i)));
            districtLists.put(i, districtList );
        }
        for (String theme :themes) {
            List<Photo> themeList = newArrayList(filter(list, new PredicateTheme(theme)));
            themeLists.put(theme, themeList );
        }
    }
    
    public int getSize() {
        return this.list.size();
    }

    private static List<Photo> getSlice(List<Photo> aList, Slice slice) {
    	if (aList == null || aList.size() == 0) {
        	return Collections.emptyList();
    	}
    	int from = slice.getFrom(aList.size());
        int to   = slice.getTo(aList.size());
        
        return aList.subList(from, to);
    }

    public List<Photo> getSlice( Slice slice ) {
    	return getSlice(this.list, slice);
    }

    public List<Photo> getDistrictSlice(Integer district, Slice slice) {
    	
        if (district == null || district == 0) {
            return getSlice(slice);
        }
        
        if (20 < district) {
            throw new IllegalArgumentException("Il n'y a que 20 arrondissements à Paris. Tu demandes le N° "+district);
        }
        
        List<Photo> districtList = districtLists.get(district);
        
        return getSlice(districtList, slice);
    }
    
    public List<Photo> getThemeSlice(String theme, Slice slice) {

    	if (theme == null || theme.length() == 0)  {
            return getSlice(slice);
        }
    	
        int iTheme = Arrays.binarySearch(themes, theme);
        
        if (iTheme == -1) {
            throw new IllegalArgumentException("Je n'ai pas trouvé ce thème dans la liste. Tu demandes le thème '"+theme+"'. Voici la liste : "+themes);
        }
        
        List<Photo> themeList = themeLists.get(theme);
        
        return getSlice(themeList, slice);
    }
    
	public List<Photo> getRandomSlice(Slice slice) {
        List<Photo> randomSlice = new ArrayList<>(slice.size);
        
        Random r = new Random(new Date().getTime());
        int max = list.size();
        for (int i = 0; i < slice.size; i++) {
        	randomSlice.add(list.get(r.nextInt(max)));
		}
		return randomSlice;
	}
	
    public List<Photo> search(String searchString, Slice slice) throws IOException, ParseException {
        List<Photo> list = new ArrayList<>(slice.size); 
        IndexReader reader = DirectoryReader.open(index);
        IndexSearcher searcher = new IndexSearcher(reader);
        QueryParser parser = new MultiFieldQueryParser(Version.LUCENE_43, new String[] { "didascalie", "street", "legacy" }, analyzer);
        Query query = parser.parse(searchString);
        TopDocs results = searcher.search(query, slice.size);
        ScoreDoc[] hits = results.scoreDocs;
        for (ScoreDoc scoreDoc : hits) {
            Document doc = searcher.doc(scoreDoc.doc);
            String image = doc.get("image");
            list.add(image2photoMap.get(image));
            if (list.size()>=slice.size) {
                break;
            }
        }
        reader.close();
        return list;
    }

    private static ArrayList<Photo> load() throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        
        URL json = Photos.class.getResource("/photos-test.json");
        if (json == null) {
            json = Photos.class.getResource("/photos.json");
        }
        if (json == null) {
            throw new IOException("Not found! Neither /photos-test.json nor /photos.json on the classpath of the "+Photos.class.getName()+" classloader.");
        }
        
        try (InputStream jsonSource = json.openStream()) {
            return mapper.readValue(jsonSource, new TypeReference<ArrayList<Photo>>() { } );
        }
        
    }

    Directory index = new RAMDirectory();
    Analyzer analyzer = new FrenchAnalyzer(Version.LUCENE_43);
    
    private void createIndex() throws IOException {
        IndexWriterConfig iwc = new IndexWriterConfig(Version.LUCENE_43, analyzer);
    
        iwc.setOpenMode(OpenMode.CREATE);
    
        IndexWriter writer = new IndexWriter(index, iwc);
        for (Photo photo : list) {
            // make a new, empty document
            Document doc = new Document();
    
            Field image = new StringField("image", photo.getImage(), Field.Store.YES);
            doc.add(image);
            doc.add(new TextField("didascalie", photo.getDidascalie(), Field.Store.NO));
            doc.add(new TextField("street", photo.getAddress().getStreet(), Field.Store.NO));
            doc.add(new TextField("legacy", photo.getAddress().getLegacy(), Field.Store.NO));
    
            writer.addDocument(doc);
        }
        writer.close();
    }

	public Photo getPhoto(String image) {
		return image2photoMap.get(image);
	}

	public List<Photo> getPhotos() {
		return list;
	}

}
