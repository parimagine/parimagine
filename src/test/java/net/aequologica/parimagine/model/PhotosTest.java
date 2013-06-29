package net.aequologica.parimagine.model;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.List;

import org.junit.Test;

import com.google.common.base.Charsets;

public class PhotosTest {

	@Test
    public void testGetInstance() throws IOException {
        
        Photos photos = Photos.getInstance();
        
        assertNotNull(photos);
        
        List<Photo> list = photos.getRandomSlice(0, 12);
        for (Photo photo : list) {
			System.out.println(photo);
		}
        // writePhotoList(photos.list);
    }
	
    void writePhotoList(List<Photo> photoList) throws IOException {
		File tmp = File.createTempFile("jsonMetadata", ".json");
        try (Writer writer = new OutputStreamWriter(new FileOutputStream(tmp), Charsets.UTF_8)) {
            Photos.writePhotoList(writer, photoList);
        }
        System.out.println(tmp.getAbsolutePath());
    }
    
}
