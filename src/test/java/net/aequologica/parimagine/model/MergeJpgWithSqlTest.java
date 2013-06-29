package net.aequologica.parimagine.model;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Charsets;

public class MergeJpgWithSqlTest {

	// @Test
	public void test() throws IOException {
		List<Photo> jpgs;
		List<Photo> sqls;
		Map<String, Photo> map = new HashMap<>();

		File jpgFile = new File("C:\\Users\\i051108\\AppData\\Local\\Temp\\jpegMetadata5356668779488428343.json");
		File sqlFile = new File("C:\\Users\\i051108\\AppData\\Local\\Temp\\sql5735434876030526494.json");

		try (FileReader fr = new FileReader(jpgFile)) {
			jpgs = load(fr);
		}
		try (FileReader fr = new FileReader(sqlFile)) {
			sqls = load(fr);
		}
		for (Photo photo : sqls) {
			map.put(photo.getImage(), photo);
		}

		for (Photo photo : jpgs) {
			Photo photoFromSql = map.get(photo.getImage());
			if (null == photoFromSql) {
				System.out.println(photo.getImage());
				continue;
			}

			photo.setDate(photoFromSql.getDate());
			
			String num = photo.getAddress().getNumber();
			try {
				int num2 = Integer.parseInt(num.trim());
				if (num2>1000) {
					photo.getAddress().setNumber(photoFromSql.getAddress().getNumber());
				}
			} catch (NumberFormatException e) {
			}
			
			Didascalie sqlDidascalie = photoFromSql.getDidascalie();
			if (sqlDidascalie != null) {
				String sqlDidaExt = photoFromSql.getDidascalie().getExt();
				String jpgDidaBase = photo.getDidascalie().getBase();

				if (sqlDidaExt != null && 0 < sqlDidaExt.length()) {
					String regex = 	"^.*("+
									sqlDidaExt.replace(" ", "\\s*")
											  .replace(".", "\\.*")
											  .replace("(", "\\(")
											  .replace(")", "\\)")
											  .replace("?", "\\?")
									+")$";
					Pattern p = Pattern.compile(regex);
					Matcher m = p.matcher(jpgDidaBase);
					if (m.matches()) {
						String g = m.group(1);
						if (g != null) {
							photo.setDidascalie(new Didascalie(jpgDidaBase.substring(0, m.start(1)), sqlDidaExt));
						}
					}
				}
			}
		}
		writePhotoList(jpgs);
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

	private static List<Photo> load(Reader reader) throws IOException {
		ObjectMapper mapper = new ObjectMapper();

		return mapper.readValue(reader, new TypeReference<ArrayList<Photo>>() {
		});
	}

	private void writePhotoList(List<Photo> photoList) throws IOException {
		File tmp = File.createTempFile("merged", ".json");
		try (Writer writer = new OutputStreamWriter(new FileOutputStream(tmp), Charsets.UTF_8)) {
			Photos.writePhotoList(writer, photoList);
		}
		System.out.println(tmp.getAbsolutePath());
	}

}
