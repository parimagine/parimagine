package net.aequologica.parimagine.model;

import com.google.common.base.Joiner;
import com.google.common.base.Splitter;

public class Didascalie {
	
	private String base;
	private String ext;
	
	private static Joiner joiner = Joiner.on(" | ").skipNulls();
	
	public Didascalie() {
	}

	public Didascalie(String base, String ext) {
		super();
		this.base = base;
		this.ext = ext;
	}
	
	public String getBase() {
		return base;
	}
	
	public void setBase(String base) {
		this.base = base.replace("\r\n", "");
	}
	
	public String getExt() {
		return ext;
	}
	
	public void setExt(String ext) {
		this.ext = ext.replace("\r\n", "");;
	}

	public static String[] split(String joined) {
		String[] ret = new String[] {"", ""};
		Iterable<String> i = Splitter.on('|').trimResults().split(joined);
		int c = 0;
		for (String s: i) {
			ret[c++] = s ;
			if (2<=c) {
				break;
			}
		}
		return ret;
	}
	
	@Override
	public String toString() {
		return joiner.join(base, ext);	
	}

}
