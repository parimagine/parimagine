package net.aequologica.parimagine.model;

import static com.google.common.collect.Collections2.filter;
import static com.google.common.collect.Lists.newArrayList;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Predicate;
import com.google.common.collect.Lists;

public class Photos {
    
    private static Photos instance = null;
    
    public static Photos getInstance() throws IOException {
        if (Photos.instance == null) {
            Photos.instance = new Photos();
        }
        return Photos.instance;
    }

    final List<Photo> list;

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
    
    final Map<Integer, List<Photo>> districtLists = new HashMap<>();
    
    private Photos() throws IOException {
        list = load();
        Collections.sort(list);
        for (int i = 1; i<= 20; i++) {
            List<Photo> districtList = newArrayList(filter(list, new PredicateDistrict(i)));
            districtLists.put(i, districtList );
        }
    }
    
    public int getSize() {
        return this.list.size();
    }

    public List<Photo> getSlice(int sizeOfSlice, int offset) {
        return this.list.subList(offset*sizeOfSlice, (offset+1)*sizeOfSlice);
    }

    public List<Photo> getDistrictSlice(Integer district, Integer sizeOfSlice, Integer offset) {
        if (district == null || district == 0) {
            return getSlice(sizeOfSlice, offset);
        }
        if (20 < district) {
            throw new IllegalArgumentException("Il n'y a que 20 arrondissements à Paris. Tu demandes le N° "+district);
        }
        return districtLists.get(district).subList(offset*sizeOfSlice, (offset+1)*sizeOfSlice);
    }

    private static List<Photo> load() throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        
        URL json = Photos.class.getResource("/photos-test.json");
        if (json == null) {
            json = Photos.class.getResource("/photos.json");
        }
        if (json == null) {
            throw new IOException("Not found! Neither /photos-test.json nor /photos.json on the classpath of the "+Photos.class.getName()+" classloader.");
        }
        
        try (InputStream jsonSource = json.openStream()) {
            return mapper.readValue(jsonSource, new TypeReference<List<Photo>>() { } );
        }
        
    }

}
