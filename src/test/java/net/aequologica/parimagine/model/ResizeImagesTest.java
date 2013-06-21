package net.aequologica.parimagine.model;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageTypeSpecifier;
import javax.imageio.ImageWriter;
import javax.imageio.metadata.IIOMetadata;
import javax.imageio.plugins.jpeg.JPEGImageWriteParam;
import javax.imageio.stream.ImageOutputStream;

import org.imgscalr.Scalr;
import org.junit.Test;
import org.w3c.dom.Element;

public class ResizeImagesTest {

	Path alImages = new File("C:/_parimagine/Site Web").toPath();

	// @Test
	public void test() throws IOException {
		ProcessFile processFile = new ProcessFile();
		Files.walkFileTree(alImages, processFile);
	}

	private final class ProcessFile extends SimpleFileVisitor<Path> {
		private ProcessFile() {
			super();
		}

		@Override
		public FileVisitResult visitFile(Path aFile, BasicFileAttributes aAttrs) throws IOException {
			String filename = aFile.getFileName().toString();
			if (filename.matches("\\d+\\.jpg")) {
				resizeImage(aFile);
			}
			return FileVisitResult.CONTINUE;
		}

		@Override
		public FileVisitResult preVisitDirectory(Path aDir, BasicFileAttributes aAttrs) throws IOException {
			return FileVisitResult.CONTINUE;
		}
	}
	
	public void resizeImage(Path p) throws IOException {
		BufferedImage image = ImageIO.read(p.toFile());
		BufferedImage big;

		int originalWidth = image.getWidth();
		int originalHeight = image.getHeight();
		int containerWidth = 1170;
		int containerHeight = 800;
		double originalRatio = (double) originalWidth / (double) originalHeight;
		double containerRatio = (double) containerWidth / (double) containerHeight;
		if (originalRatio >= containerRatio) {
			big = Scalr.resize(image, Scalr.Method.ULTRA_QUALITY, Scalr.Mode.FIT_TO_WIDTH, containerWidth, null, Scalr.OP_ANTIALIAS);
		} else {
			big = Scalr.resize(image, Scalr.Method.ULTRA_QUALITY, Scalr.Mode.FIT_TO_HEIGHT, containerHeight, null, Scalr.OP_ANTIALIAS);
		}
		
		BufferedImage small = Scalr.resize(image, Scalr.Method.ULTRA_QUALITY, Scalr.Mode.FIT_TO_WIDTH, 274, null, Scalr.OP_ANTIALIAS);

		writeImage(p, big, .9f);
		writeImage(p, small, .8f);
	}

	private static void writeImage(Path p, BufferedImage bufferedImage, float compression) throws IOException {
		String filename = p.getFileName().toString();
		filename = filename.substring(0, filename.length()-4); // remove ".jpg"
		
		File file = new File(p.getParent().toFile(), filename + "-" + bufferedImage.getWidth() + "x" + bufferedImage.getHeight() + ".jpg");
		try (FileOutputStream outputStream = new FileOutputStream(file)) {
			saveAsJPEG(96, bufferedImage, compression, outputStream);
		}
		System.out.println(file.getAbsolutePath());
	}

	public static void saveAsJPEG(int dpi, BufferedImage image_to_save, float compression, FileOutputStream fos) throws IOException {

		// Image writer
		ImageWriter imageWriter = ImageIO.getImageWritersBySuffix("jpeg").next();
		ImageOutputStream ios = ImageIO.createImageOutputStream(fos);
		imageWriter.setOutput(ios);

		// and metadata
		IIOMetadata imageMetaData = imageWriter.getDefaultImageMetadata(new ImageTypeSpecifier(image_to_save), null);

		// new metadata
		Element tree = (Element) imageMetaData.getAsTree("javax_imageio_jpeg_image_1.0");
		Element jfif = (Element) tree.getElementsByTagName("app0JFIF").item(0);
		jfif.setAttribute("Xdensity", Integer.toString(dpi));
		jfif.setAttribute("Ydensity", Integer.toString(dpi));
		imageMetaData.setFromTree("javax_imageio_jpeg_image_1.0", tree);

		JPEGImageWriteParam jpegParams = null;
		if (0 <= compression && compression <= 1f) {
			// new Compression
			jpegParams = (JPEGImageWriteParam) imageWriter.getDefaultWriteParam();
			jpegParams.setCompressionMode(JPEGImageWriteParam.MODE_EXPLICIT);
			jpegParams.setCompressionQuality(compression);
		}

		// new Write and clean up
		// imageWriter.write(imageMetaData, new IIOImage(image_to_save, null,
		// null), null);
		imageWriter.write(null, new IIOImage(image_to_save, null, imageMetaData), jpegParams);
		ios.close();
		imageWriter.dispose();

	}

}