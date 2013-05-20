package net.aequologica.parimagine.model;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Collections;
import java.util.List;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Photos {
    
    private static Photos instance = null;
    
    public static Photos getInstance() throws IOException {
        if (Photos.instance == null) {
            Photos.instance = new Photos();
        }
        return Photos.instance;
    }

    final List<Photo> list;
    
    private Photos() throws IOException {
        list = load();
        Collections.sort(list);
    }
    
    public int getSize() {
        return this.list.size();
    }

    public List<Photo> getSlice(int sizeOfSlice, int offset) {
        return this.list.subList(offset*sizeOfSlice, (offset+1)*sizeOfSlice);
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
