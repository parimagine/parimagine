package net.aequologica.parimagine.model;

public class Didascalie {
	
	private String base;
	private String ext;
	
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

}
