package net.aequologica.parimagine;

import static org.junit.Assert.assertNotNull;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.util.List;

import net.aequologica.parimagine.model.Photo;

import org.junit.Test;

import com.google.common.base.Charsets;

public class PhotosTest {

	@Test
    public void testGetInstance() throws IOException {
        
        Photos photos = Photos.getInstance();
        
        assertNotNull(photos);
//        File f = new File("photoURLs.txt");
//        FileWriter fw = new FileWriter(f);
        StringWriter sw = new StringWriter();
        
        List<Photo> list = photos.getPhotos();
        try (BufferedWriter bw = new BufferedWriter(sw)) {
            for (Photo photo : list) {
                bw.write(photo.getImage());
                bw.newLine();
            }
		}
    }
	
    void writePhotoList(List<Photo> photoList) throws IOException {
		File tmp = File.createTempFile("jsonMetadata", ".json");
        try (Writer writer = new OutputStreamWriter(new FileOutputStream(tmp), Charsets.UTF_8)) {
            Photos.writePhotoList(writer, photoList);
        }
        System.out.println(tmp.getAbsolutePath());
    }
    
}
