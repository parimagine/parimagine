package net.aequologica.parimagine.model;

public class Address {

    private Integer department; // département:75
	private String town; // ville:Paris
    private Integer district; // arrondissment:18 
    private String number; // numéro:101
    private String street; // rue:rue du mont cenis
    private String legacy; // vieux_nom_de_rue:rue de blablabla
    
    public Address() {
	}

    public Address(Integer department, String town, Integer district, String number, String street, String legacy) {
		super();
        this.department = department;
		this.town = town;
		this.district = district;
		this.number = number;
		this.street = street;
		this.legacy = legacy;
	}

    public String getTown() {
        return town;
    }
    public void setTown(String town) {
        this.town = town;
    }
    public Integer getDistrict() {
        return district;
    }
    public void setDistrict(Integer district) {
        this.district = district;
    }
    public Integer getDepartment() {
        return department;
    }
    public void setDepartment(Integer department) {
        this.department = department;
    }
    public String getNumber() {
        return number;
    }
    public void setNumber(String number) {
        this.number = number;
    }
    public String getStreet() {
        return street;
    }
    public void setStreet(String street) {
        this.street = street;
    }
    public String getLegacy() {
        return legacy;
    }
    public void setLegacy(String legacy) {
        this.legacy = legacy;
    }

    @Override
    public String toString() {
        return "Address [department=" + department + ", town=\"" + town + "\", district=" + district + ", number=\"" + number + "\", street=\"" + street + "\", legacy=\""+ legacy + "\"]";
    }
}
