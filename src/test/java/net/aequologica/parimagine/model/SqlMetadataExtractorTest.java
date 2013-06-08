package net.aequologica.parimagine.model;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import com.google.common.base.Charsets;

public class SqlMetadataExtractorTest {

/* 
THE MAGIC REGEXPs
TO TRANSFORM parimagiglobal.sql
INTO photos.json    

------------> remove all line starting with INSERT 
^INSERT.*\n
-nothing-

------------> all & into &amp; 
&
&amp;

------------> all ' after a non-space into &apos; 
([^\s])''
$1&apos;

------------> all " into &quot; 
"
&quot;

------------> extract image, date, address and didascalie
\((\d*?), '(\d\d\d\d-\d\d-\d\d)', '(.*?)', (\d*?), (\d*?), '(.*?)', '(.*?)', '(.*?)', '.*?', '.*?', '.*?', '.*?', \d+, \d+, '(.*?)', '(.*?)'.*\)[,;]
{"image":"$1", "date":"$2", "address":"$3 | $4 | $5 | $6 | $7 | $8", "didascalie":"$9 | $10"},

------------> extract town, district, department, number, street and legacy from address
"address":"(.*?) \| (\d*?) \| (\d*?) \| (.*?) \| (.*?) \| (.*?)"
"address": { "town": "$1", "district": $2, "department": $3, "number": "$4", "street": "$5", "legacy": "$6" }

------------> extract base and ext from didascalie
"didascalie":"(.*?) \| (.*?)"
"didascalie": { "base": "$1", "ext": "$2" }

ouf!
*/

	Path piwi 		   			= new File("C:/_parimagine/SiteParimagine/Piwi").toPath();
	Path piwiGalleries 			= new File("C:/_parimagine/SiteParimagine/Piwi/galleries").toPath();
	Path piwiGalleriesdistricts = new File("C:/_parimagine/SiteParimagine/Piwi/galleries/Arrondissements").toPath();

    private String makeKey(String district, String id) {
        return district+"."+id;
    }

    // @Test
    // match image + address.district from photos.json with location of file on the drive. store back into image field 
    // e.g. 
    public void test() throws IOException, CloneNotSupportedException {
        // get photos
        Photos photos = Photos.getInstance();
        
        Map<String, Photo> photoDistrictIdMap = new HashMap<>();
        Map<String, Photo> photoIdMap = new HashMap<>();
        
        for (Photo photo : photos.list) {
            photoDistrictIdMap.put(makeKey(photo.getAddress().getDistrict().toString(), photo.getImage()), photo);
            photoIdMap.put(photo.getImage(), photo);
        }

        // get files
        List<Path> paths = new LinkedList<>();
        ProcessFile processFile = new ProcessFile(paths);
        Files.walkFileTree(piwiGalleriesdistricts, processFile);
        
        Map<String, String> filesDistrictIdMap = new HashMap<>();
        Map<String, String> filesIdMap = new HashMap<>();

        for (Path path : processFile.list) {
            String pathAsString = piwiGalleries.relativize(path).toString().toLowerCase().replace('\\', '/');

            // get id
            String filename = path .getFileName().toString();
            String id = filename.substring(0, filename.length()-4);
            
            // get district
            String district = "";
            int lastSlash = pathAsString.lastIndexOf('/');
            if (lastSlash != -1) {
                int lastMinus= pathAsString.lastIndexOf('-');
                if (lastMinus != -1) {
                    district = pathAsString.substring(lastMinus+1, lastSlash); 
                }
            }
            
            String key = makeKey(district, id);
            
            if (filesDistrictIdMap.get(key) != null) {
                // System.out.println("###################### "+key+" -> "+filesDistrictIdMap.get(key)+ " | "+pathAsString + " !? ######################");
            }
            filesDistrictIdMap.put(key, pathAsString);
            if (filesIdMap.get(id) != null) {
                // System.out.println("bbbbbbbbbbbbbbbbbbbbbb "+id+" -> "+filesIdMap.get(id)+ " | "+pathAsString + " !? bbbbbbbbbbbbbbbbbbbbbb");
            }
            filesIdMap.put(id, pathAsString);
        }
        
        {
            List<Photo> results = new LinkedList<>();
            for (Map.Entry<String, String> entry : filesDistrictIdMap.entrySet()) {
                String key = entry.getKey();
                Photo p = photoDistrictIdMap.get(key);
                if (p != null) {
                    Photo clone = (Photo)(p.clone()); 
                    clone.setImage(entry.getValue());
                    results.add(clone);
                } else {
                    System.out.print(""+key+" not found in photoDistrictIdMap");
                    int dot = key.indexOf('.');
                    if (dot != -1) {
                        key = key.substring(dot+1, key.length());
                        p = photoIdMap.get(key);
                        if (p != null) {
                            Photo clone = (Photo)(p.clone()); 
                            clone.setImage(entry.getValue());
                            results.add(clone);
                            System.out.print(" --- Found! "+clone);
                        } else {
                            Photo neuve = new Photo(); 
                            neuve.setImage(entry.getValue());
                            results.add(neuve);
                            System.out.print(" "+key+" not found in photoIdMap");
                        }
                    }
                    System.out.println();
                }
            }
            
            writePhotoList(results);
        }
    }

    private void writePhotoList(List<Photo> photoList) throws IOException {
        File tmp = File.createTempFile("sql", ".json");
        try (Writer writer = new OutputStreamWriter(new FileOutputStream(tmp), Charsets.UTF_8)) {
            Photos.writePhotoList(writer, photoList);
        }
        System.out.println(tmp.getAbsolutePath());
    }

    private static final class ProcessFile extends SimpleFileVisitor<Path> {
        final List<Path> list;

        private ProcessFile(List<Path> list) {
            super();
            this.list = list;
        }

        @Override
        public FileVisitResult visitFile(Path aFile, BasicFileAttributes aAttrs) throws IOException {
            String filename = aFile.getFileName().toString(); 
            if (filename.matches("\\d+\\.jpg")) {
                list.add(aFile);
            }
            return FileVisitResult.CONTINUE;
        }

        @Override
        public FileVisitResult preVisitDirectory(Path aDir, BasicFileAttributes aAttrs) throws IOException {
            return FileVisitResult.CONTINUE;
        }
    }

}
