package net.aequologica.parimagine.model;

import static org.junit.Assert.assertNotNull;

import java.io.File;
import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.FileVisitor;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.util.DefaultPrettyPrinter;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class PhotosTest {

/* 

THE MAGIC REGEXPs    

([^\s])''
$1&apos;

"
&quot;

^INSERT.*\n
######### nothing #############

\((\d*?), '(\d\d\d\d-\d\d-\d\d)', '(.*?)', (\d*?), (\d*?), '(.*?)', '(.*?)', '.*?', '.*?', '.*?', '.*?', '.*?', \d+, \d+, '(.*?)', '(.*?)'.*\)[,;]
{"image":"$1", "date":"$2", "address":"$3 | $4 | $5 | $6 | $7", "didascalie":"$8 | $9"},

\((\d*?), '(\d\d\d\d-\d\d-\d\d)', '(.*?)', (\d*?), (\d*?), '(.*?)', '(.*?)', '(.*?)', '.*?', '.*?', '.*?', '.*?', \d+, \d+, '(.*?)', '(.*?)'.*\)[,;]
{"image":"$1", "date":"$2", "address":"$3 | $4 | $5 | $6 | $7 | $8", "didascalie":"$9 | $10"},

"address":"(.*?) \| (\d*?) \| (\d*?) \| (.*?) \| (.*?) \| (.*?)"
"address": { "town": "$1", "district": $2, "department": $3, "number": "$4", "street": "$5", "legacy": "$6" }

*/
    @Test
    public void testGetInstance() throws IOException {
        
        Photos photos = Photos.getInstance();
        
        assertNotNull(photos);
        for (Photo photo : photos.list) {
            System.out.println(photo);
        }
    }
    
    private String makeKey(String district, String id) {
        return district+"."+id;
    }

    // @Test
    public void test() throws IOException, CloneNotSupportedException {
        // get photos
        Photos photos = Photos.getInstance();
        
        Map<String, Photo> photoDistrictIdMap= new HashMap<>();
        Map<String, Photo> photoIdMap= new HashMap<>();
        for (Photo photo : photos.list) {
            photoDistrictIdMap.put(makeKey(photo.getAddress().getDistrict().toString(), photo.getImage()), photo);
            photoIdMap.put(photo.getImage(), photo);
            if (photo.getAddress().getDistrict() == 0) {
                // System.out.println(photo);
            }
        }

        // get files
        List<Path> paths = new LinkedList<>();
        ProcessFile processFile = new ProcessFile(paths);
        FileVisitor<Path> fileProcessor = processFile;
        Path root = new File("C:/^/parimagine/SiteParimagine/Piwi/galleries").toPath();
        Files.walkFileTree(new File(root.toFile(), "Arrondissements").toPath(), fileProcessor);
        
        Map<String, String> filesDistrictIdMap = new HashMap<>();
        Map<String, String> filesIdMap = new HashMap<>();

        for (Path path : processFile.list) {
            String pathAsString = root.relativize(path).toString().toLowerCase().replace('\\', '/');

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

        /*
        {
            List<Photo> results = new LinkedList<>();
            for (Map.Entry<String, Photo> entry : photoDistrictIdMap.entrySet()) {
                String key = entry.getKey();
                String path = filesDistrictIdMap.get(key);
                if (path != null) {
                    Photo clone = (Photo)entry.getValue().clone(); 
                    clone.setImage(path);
                    results.add(clone);
                } else {
                    System.out.print(""+entry.getKey()+" not found in filesDistrictIdMap");
                    int dot = key.indexOf('.');
                    if (dot != -1) {
                        key = key.substring(dot+1, key.length());
                        path = filesIdMap.get(key);
                        if (path != null) {
                            Photo clone = (Photo)(entry.getValue().clone()); 
                            clone.setImage(path);
                            results.add(clone);
                            System.out.print(" --- Found! "+clone);
                        } else {
                            System.out.print(" "+key+" not found in filesIdMap");
                        }
                    }
                    System.out.println();
                }
            }
            writePhotoList(results);
        }
        */
        
        /*
        System.out.println(photos.list.size());
        System.out.println(processFile.list.size());
        */

    }

    private void writePhotoList(List<Photo> photoList) throws IOException, JsonGenerationException, JsonMappingException {
        ObjectMapper mapper = new ObjectMapper();
        DefaultPrettyPrinter prettyPrinter = new DefaultPrettyPrinter();
        File tmp = File.createTempFile("photos", ".json");
        System.out.println(tmp.getAbsolutePath());
        
        Collections.sort(photoList, new Comparator<Photo>() {

            @SuppressWarnings({ "unchecked", "rawtypes" })
            @Override
            public int compare(Photo o1, Photo o2) {
                Comparable[] a1 = getComparableArray(o1); 
                Comparable[] a2 = getComparableArray(o2);
                int first = a1[0].compareTo(a2[0]);
                if (first != 0) {
                    return first;
                }
                int second = a1[1].compareTo(a2[1]);
                return second;
            }
            @SuppressWarnings("rawtypes")
            Comparable[] getComparableArray(Photo p) {
                String rest = p.getImage();
                String id = p.getImage();
                int lastSlash = id.lastIndexOf('/');
                if (lastSlash != -1) {
                    id = id.substring(lastSlash+1);
                    rest = p.getImage().substring(0, lastSlash);
                    int lastMinus = rest.lastIndexOf('-');
                    if (lastMinus != -1) {
                        rest = rest.substring(lastMinus+1);
                    }
                }
                if (id.endsWith(".jpg")) {
                    id = id.substring(0, id.length()-4); 
                }
                return new Comparable[] {Integer.parseInt(rest), Integer.parseInt(id)};
            }
        });
        mapper.writer(prettyPrinter).writeValue(tmp, photoList);
    }

    private static final class ProcessFile extends SimpleFileVisitor<Path> {
        final List<Path> list;

        private ProcessFile(List<Path> list) {
            super();
            this.list = list;
        }

        @Override
        public FileVisitResult visitFile(Path aFile, BasicFileAttributes aAttrs) throws IOException {
            // System.out.println(aFile.getFileName() + " " + aFile.getFileName().getClass());
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
