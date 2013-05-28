package net.aequologica.parimagine.model;

public class Address {

	private String town;
	private Integer  district;
    private Integer department;
    private String number;
    private String street;
    private String legacy;
    
    public Address() {
	}

    public Address(String town, Integer district, Integer department, String number, String street, String legacy) {
		super();
		this.town = town;
		this.district = district;
		this.department = department;
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
        return "Address [town=\"" + town + "\", district=" + district + ", department=" + department + ", number=\"" + number + "\", street=\"" + street + "\", legacy=\""+ legacy + "\"]";
    }
}
