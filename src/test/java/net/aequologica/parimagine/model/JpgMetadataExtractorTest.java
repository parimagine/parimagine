package net.aequologica.parimagine.model;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.nio.file.FileSystems;
import java.nio.file.FileVisitResult;
import java.nio.file.FileVisitor;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.PathMatcher;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;

import org.junit.Test;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.Tag;
import com.drew.metadata.iptc.IptcDescriptor;
import com.drew.metadata.iptc.IptcDirectory;

public class JpgMetadataExtractorTest {

	PathMatcher onlyJpegs = FileSystems.getDefault().getPathMatcher("glob:*.{jpg}");
	PathMatcher noDistrict= FileSystems.getDefault().getPathMatcher("glob:{Arrondissements}");
	
    Path root = new File("C:/^/parimagine/SiteParimagine/Piwi/galleries").toPath();
    
	@Test
	public void test() throws ImageProcessingException, IOException {

		// get files
		File file = File.createTempFile("jpegMetadata", ".json");
		try (FileWriter writer = new FileWriter(file)) {
			ProcessFile processFile = new ProcessFile(writer);
			FileVisitor<Path> fileProcessor = processFile;
			Path piwi = new File("C:/^/parimagine/SiteParimagine/Piwi/").toPath();
			Files.walkFileTree(new File(piwi.toFile(), "galleries").toPath(), fileProcessor);
		}

		System.out.println(file.getAbsolutePath());
	}

	// @Test
	public void testOneFile() throws ImageProcessingException, IOException {
		getMatadata(Paths.get("C:/^/parimagine/SiteParimagine/Piwi/galleries/Photos-Presse/Cinema/P375.jpg"), false);
		getMatadata(Paths.get("C:/^/parimagine/SiteParimagine/Piwi/galleries/Photos-Presse/Cinema/P304.jpg"), false);
	}

	private final class ProcessFile extends SimpleFileVisitor<Path> {

		final Writer writer;
		private ProcessFile(Writer writer) {
			super();
			this.writer = writer;
		}

		@Override
		public FileVisitResult visitFile(Path aFile, BasicFileAttributes aAttrs) throws IOException {
			if (!onlyJpegs.matches(aFile.getFileName())) {
				System.err.println("ignored " + aFile.toString());
				return FileVisitResult.CONTINUE;
			}

			try {
				String caption = getMatadata(aFile, false);
				if (caption != null) {
					// writer.write(caption);
					String pathAsString = root.relativize(aFile).toString().toLowerCase().replace('\\', '/');
					caption = caption.replaceAll("\"", "&apos;");
					writer.write("{  \"image\" : \""+pathAsString+"\",  \"date\" : \"0000-00-00\",  \"address\" : { \"town\" : \"Paris\", \"district\" : 0, \"department\" : 75, \"number\" : \"\", \"street\" : \"\", \"legacy\" : \"\" },  \"didascalie\" : \" | "+caption+"\"},");					
					writer.write("\n");
				}
			} catch (ImageProcessingException e) {
				// TODO Auto-generated catch block
				System.err.println("Exception in " + aFile.toString() + ": " + e.getMessage());
				return FileVisitResult.CONTINUE;
			}
			return FileVisitResult.CONTINUE;
		}

		@Override
		public FileVisitResult preVisitDirectory(Path aDir, BasicFileAttributes aAttrs) throws IOException {
			if (noDistrict.matches(aDir.getFileName())) {
				return FileVisitResult.SKIP_SUBTREE;
			}
			
			return FileVisitResult.CONTINUE;
		}
	}

	String getMatadata(Path aFile, Boolean verbose) throws IOException, ImageProcessingException {
		File jpegFile = aFile.toFile();
		Metadata metadata;
		metadata = ImageMetadataReader.readMetadata(jpegFile);

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
			System.err.println("no directory for "+jpegFile.getAbsolutePath() );
			return null;
		}
		
		// create a descriptor
		IptcDescriptor descriptor = new IptcDescriptor(directory);
		
		// query the tag's value
		String caption = descriptor.getCaptionDescription();
		if (caption == null) {
			System.err.println("no caption for "+jpegFile.getAbsolutePath() );
			return null;
		}
		
		// System.out.println(jpegFile.getAbsolutePath() + ": " + new String(caption.getBytes("UTF-8")));
		
		return caption;

	}

}
