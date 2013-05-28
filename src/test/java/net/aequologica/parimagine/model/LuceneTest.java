package net.aequologica.parimagine.model;

import java.io.IOException;
import java.util.List;

import org.apache.lucene.queryparser.classic.ParseException;
import org.junit.Test;

public class LuceneTest {

    Photos photos = null;
    
    @Test
    public void searchPhotos() throws IOException, ParseException {
        if (photos == null) photos = Photos.getInstance();

        List<Photo> list = photos.search("Henri IV", new Photos.Slice(0, 12));
        for (Photo p : list) {
            System.out.println(p);
        }
        
    }
}
