package net.aequologica.parimagine.model;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.file.FileSystems;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.PathMatcher;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.Test;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.Tag;
import com.drew.metadata.iptc.IptcDirectory;
import com.google.common.base.Charsets;

public class JpgMetadataExtractorTest {

	PathMatcher jpegPathMatcher      = FileSystems.getDefault().getPathMatcher("glob:*.{jpg}");
	PathMatcher districtPathMatcher  = FileSystems.getDefault().getPathMatcher("glob:{Arrondissements}");
	PathMatcher thumbnailPathMatcher = FileSystems.getDefault().getPathMatcher("glob:{thumbnail}");

	Path piwi 		   = new File("C:/parimagine/SiteParimagine/Piwi").toPath();
	Path piwiGalleries = new File("C:/parimagine/SiteParimagine/Piwi/galleries").toPath();

    @Test
    public void voidtest() {
    }

	// @Test
	public void test() throws ImageProcessingException, IOException {

		List<Photo> photoList = new ArrayList<>();
		
		ProcessFile processFile = new ProcessFile(photoList);
		
		Files.walkFileTree(piwiGalleries, processFile);
		
		writePhotoList(photoList);
    }

    // @Test
    public void testOneFile() throws ImageProcessingException, IOException {
		System.out.println(getMatadata(Paths.get("C:/parimagine/SiteParimagine/Piwi/galleries/Photos-Presse/Cinema/P375.jpg"), false));
		System.out.println(getMatadata(Paths.get("C:/parimagine/SiteParimagine/Piwi/galleries/Photos-Presse/Cinema/P304.jpg"), false));
	}

	private final class ProcessFile extends SimpleFileVisitor<Path> {

		final List<Photo> photoList;

		private ProcessFile(List<Photo> photoList) {
			super();
			this.photoList = photoList;
		}

		@Override
		public FileVisitResult visitFile(Path aFile, BasicFileAttributes aAttrs) throws IOException {
			if (!jpegPathMatcher.matches(aFile.getFileName())) {
				System.err.println("ignored " + aFile.toString());
				return FileVisitResult.CONTINUE;
			}

			try {
				String caption = getMatadata(aFile, false);
				if (caption != null) {
				    
				    System.out.println(caption);

					String pathAsString = piwiGalleries.relativize(aFile).toString().toLowerCase().replace('\\', '/');
					caption = fixQuotes(caption);
					String[] qwe = extractNumber(caption);
					String number = qwe[1] != null ? qwe[1] : "";   
					String newCaption = qwe[0];
					String[] asd = extractStreets(newCaption);
					String street = asd[1] != null ? asd[1] : "";   
					String oldStreet = asd[2] != null ? asd[2] : "";   
					newCaption = asd[0];
					newCaption = extractParis(newCaption);
					
					Object[] yxc = extractDistrict(newCaption);					
					Integer district = yxc[1] != null ? (Integer)yxc[1] : null;
					newCaption = (String)yxc[0];
					
					if (district == null || district == 0) {
						String[] wer = Photo.getDistrictFromImage(pathAsString);
						if (wer[0] != null) {
							try {
								district = Integer.parseInt(wer[0]);
							} catch (Exception e) {
								System.err.println(e.getMessage());
							}
						}
					}
					
					Address address = new Address(75, "Paris", district, number, street, oldStreet);
					newCaption = newCaption.replace("&", "&amp;");
					newCaption = newCaption.replace("\"", "&quot;");
					newCaption = newCaption.replace("'", "&apos;");
					Didascalie didascalie = new Didascalie(newCaption, "");
					Photo photo = new Photo(pathAsString, "0000-00-00", didascalie, address, null);
					
					photoList.add(photo);
				}
			} catch (ImageProcessingException e) {
				System.err.println("Exception in " + aFile.toString() + ": " + e.getMessage());
				return FileVisitResult.CONTINUE;
			}
			return FileVisitResult.CONTINUE;
		}

		@Override
		public FileVisitResult preVisitDirectory(Path aDir, BasicFileAttributes aAttrs) throws IOException {
			if (thumbnailPathMatcher.matches(aDir.getFileName())) {
				return FileVisitResult.SKIP_SUBTREE;
			}

			return FileVisitResult.CONTINUE;
		}
	}

	String getMatadata(Path aFile, Boolean verbose) throws IOException, ImageProcessingException {
		File jpegFile = aFile.toFile();
		Metadata metadata;
		FileInputStream fis = new FileInputStream(jpegFile);
		// InputStream isr = new InputStream(fis, Charsets.ISO_8859_1);
		BufferedInputStream bis = new BufferedInputStream(fis);
		metadata = ImageMetadataReader.readMetadata(bis, true);

		if (verbose) {
			for (Directory directory : metadata.getDirectories()) {
				for (Tag tag : directory.getTags()) {
					System.out.println(tag);
				}
			}
		}

		// obtain the Iptc directory
		IptcDirectory directory = metadata.getDirectory(IptcDirectory.class);

		if (directory == null) {
			System.err.println("no directory for " + jpegFile.getAbsolutePath());
			return null;
		}

		String caption = directory.getString(IptcDirectory.TAG_CAPTION, Charsets.ISO_8859_1.toString());
		/*
		// create a descriptor
		IptcDescriptor descriptor = new IptcDescriptor(directory);

		// query the tag's value
		String caption = descriptor.getCaptionDescription();
		*/
		if (caption == null) {
			System.err.println("no caption for " + jpegFile.getAbsolutePath());
			return null;
		}
		
		return caption;

	}

	public static int countOccurrences(String haystack, char needle) {
		int count = 0;
		for (int i = 0; i < haystack.length(); i++) {
			if (haystack.charAt(i) == needle) {
				count++;
			}
		}
		return count;
	}

	public String fixQuotes(String caption) {
		int c = countOccurrences(caption, '"');
		if (c%2 != 0) {
			int last = caption.lastIndexOf('"');
			if (last != -1) {
				caption = caption.substring(0, last-1) + caption.substring(last+1);  
			}
		}

		return caption;
	}

	public String[] extractNumber(String caption) {
		{		 
			Pattern p = Pattern.compile("^(\\d+ bis).*$");
			Matcher m = p.matcher(caption);
			if (m.matches()) {
				String group = m.group(1);
				String[] split = group.split(" ");
				String newCaption = caption.substring(0, m.start(1));
				for (String s : split) {
					newCaption += s; 	
				}
				newCaption += caption.substring(m.end(1));
				caption = newCaption;
			}
		}
		 
		String[] ret = new String[] {caption, null};
		Pattern p = Pattern.compile("^(\\d[^\\s]*\\s).*$");
		Matcher m = p.matcher(caption);
		if (m.matches()) {
			ret[0] = caption.substring(0, m.start(1))+caption.substring(m.end(1));
			ret[1] = m.group(1);
		}
		return ret;
	}
	
//	@Test
	public void testExtractNumber() throws ImageProcessingException, IOException {
		{
			String qwe = "53 ABOUKIR (RUE D) Stoppeurs Stoppeurs du n°53 75002 - Paris";
			String[] asd = extractNumber(qwe);
			assertEquals("53 ", asd[1]);
		}
		
		{
			String qwe = "62 bis JEAN PIERRE TIMBAUD (RUE) ANGOULEME (RUE D) Blanchisseurs Pas de légende Façade d'une blanchisserie 75011 Paris";
			String[] asd = extractNumber(qwe);
			assertEquals("62bis ", asd[1]);
		}
		
		{
			String qwe = "LOUVRE (RUE DU) DEUX ECUS (RUE DES)  Société d'approvisionnement général des charcutiers de France Rue des deux écus (1er arrt) 75001 - Paris";
			String[] asd = extractNumber(qwe);
			assertNull(asd[1]);
		}
	}
	
	public String[] extractStreets(String caption) {
		String[] ret = new String[] {caption, null, null};

		{
			Pattern p = Pattern.compile("^((?:[^a-z])*\\)\\s*).*$");
			Matcher m = p.matcher(caption);
			if (m.matches()) {
				ret[0] = caption.substring(0, m.start(1))+caption.substring(m.end(1));
				ret[0] = removeTrailingChars(ret[0], " -");
				ret[1] = m.group(1);
				ret[1] = removeTrailingChars(ret[1], " -");
			}
		}
		
		{
			if (ret[1] != null) {
				Pattern p2 = Pattern.compile("^([^\\(]*\\([^\\)]*\\)\\s)?.*$");
				Matcher m2 = p2.matcher(ret[1]);
				if (m2.matches()) {
					String g = m2.group(1);
					if (g != null) {
						ret[2] = ret[1].substring(m2.end(1));
						ret[1] = removeTrailingChars(g, " -");
					}
				}
			}
		}
		return ret;

	}

//	@Test
	public void testExtractStreet() throws ImageProcessingException, IOException {
		{
			String qwe = "ABOUKIR (RUE D) Stoppeurs Stoppeurs du n°53 75002 - Paris";
			String[] asd = extractStreets(qwe);
			assertEquals("Stoppeurs Stoppeurs du n°53 75002 - Paris", asd[0]);
			assertEquals("ABOUKIR (RUE D)", asd[1]);
			assertNull(asd[2]);
		}
		
		{
			String qwe = "JEAN PIERRE TIMBAUD (RUE) ANGOULEME (RUE D) Blanchisseurs Pas de légende Façade d'une blanchisserie 75011 Paris";
			String[] asd = extractStreets(qwe);
			assertEquals("Blanchisseurs Pas de légende Façade d'une blanchisserie 75011 Paris", asd[0]);
			assertEquals("JEAN PIERRE TIMBAUD (RUE)", asd[1]);
			assertEquals("ANGOULEME (RUE D)", asd[2]);
		}

		{
			String qwe = "LOUVRE (RUE DU) DEUX ECUS (RUE DES)  Société d'approvisionnement général des charcutiers de France Rue des deux écus (1er arrt) 75001 - Paris";
			String[] asd = extractStreets(qwe);
			assertEquals("Société d'approvisionnement général des charcutiers de France Rue des deux écus (1er arrt) 75001 - Paris", asd[0]);
			assertEquals("LOUVRE (RUE DU)", asd[1]);
			assertEquals("DEUX ECUS (RUE DES)", asd[2]);
		}

		{
			String qwe = "37 BERGER (RUE)   75001 - Paris";
			String[] asd = extractStreets(qwe);
			assertEquals("75001 - Paris", asd[0]);
			assertEquals("37 BERGER (RUE)", asd[1]);
			assertNull(asd[2]);
		}
	}

	public String extractParis(String caption) {
		String ret = caption;
		if (caption.endsWith("Paris")) {
			ret = caption.substring(0, caption.length()-5);
		}
		ret = removeTrailingChars(ret, " -");
		return ret;
	}

	private String removeTrailingChars(String ret, String chars) {
		if (ret.length() > 0) {
			char last = (char)ret.charAt(ret.length()-1);
			while (chars.indexOf(last) != -1) {
				ret = ret.substring(0, ret.length()-1);
				if (ret.length() == 0) {
					break;
				}
				last = ret.charAt(ret.length()-1);
			}
		}
		return ret;
	}

//	@Test
	public void testExtractParis() throws ImageProcessingException, IOException {
		{
			String qwe = "Stoppeurs Stoppeurs du n°53 75002 - Paris";
			String asd = extractParis(qwe);
			assertEquals("Stoppeurs Stoppeurs du n°53 75002", asd);
		}
		
		{
			String qwe = "Blanchisseurs Pas de légende Façade d'une blanchisserie 75011 Paris";
			String asd = extractParis(qwe);
			assertEquals("Blanchisseurs Pas de légende Façade d'une blanchisserie 75011", asd);
		}

		{
			String qwe = "75001 - Paris";
			String asd = extractParis(qwe);
			assertEquals("75001", asd);
		}

	}

	public Object[] extractDistrict(String caption) {
		Object[] ret = new Object[] {caption, 0};

		Pattern p = Pattern.compile("^.*(750\\d\\d)$");
		Matcher m = p.matcher(caption);
		if (m.matches()) {
			ret[0] = caption.substring(0, m.start(1));
			ret[1] = Integer.parseInt(m.group(1).substring(3));
		}
		ret[0] = removeTrailingChars((String)ret[0], " -");
		return ret;
	}

//	@Test
	public void testExtractDistrict() throws ImageProcessingException, IOException {
		{
			String qwe = "Stoppeurs Stoppeurs du n°53    75002";
			Object[] asd = extractDistrict(qwe);
			assertEquals("Stoppeurs Stoppeurs du n°53", asd[0]);
			assertEquals(2, asd[1]);
		}
		
		{
			String qwe = "Blanchisseurs Pas de légende Façade d'une blanchisserie 75011";
			Object[] asd = extractDistrict(qwe);
			assertEquals("Blanchisseurs Pas de légende Façade d'une blanchisserie", asd[0]);
			assertEquals(11, asd[1]);
		}

		{
			String qwe = "75001";
			Object[] asd = extractDistrict(qwe);
			assertEquals("", asd[0]);
			assertEquals(1, asd[1]);
		}
}


    private void writePhotoList(List<Photo> photoList) throws IOException {
		File tmp = File.createTempFile("jpegMetadata", ".json");
        try (Writer writer = new OutputStreamWriter(new FileOutputStream(tmp), Charsets.UTF_8)) {
            Photos.writePhotoList(writer, photoList);
        }
        System.out.println(tmp.getAbsolutePath());
    }

}

