package net.aequologica.parimagine.model;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Comparator;

import com.fasterxml.jackson.core.util.DefaultPrettyPrinter;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Photo implements Comparable<Photo> {
    
	private String image; 
    private String date;
    private Didascalie didascalie;
    private Address address;
    private GeoData geoData;
    
    public Photo() {
	}

	public Photo(String image, String date, Didascalie didascalie, Address address, GeoData geoData) {
		super();
		this.image = image;
		this.date = date;
		this.didascalie = didascalie;
		this.address = address;
		this.geoData = geoData;
	}

	public String getImage() {
        return image;
    }
    
    public void setImage(String image) {
        this.image = image;
    }
    
    public String getDate() {
        return date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    
	public Didascalie getDidascalie() {
        return didascalie;
    }
    
    public void setDidascalie(Didascalie didascalie) {
        this.didascalie = didascalie;
    }
    
    public Address getAddress() {
        return address;
    }
    
    public void setAddress(Address address) {
        this.address = address;
    }
    
    public GeoData getGeoData() {
		return geoData;
	}

	public void setGeoData(GeoData geoData) {
		this.geoData = geoData;
	}

    private static ObjectMapper mapper = new ObjectMapper();
    DefaultPrettyPrinter prettyPrinter = new DefaultPrettyPrinter();
    
    @Override
    public String toString() {
    	StringWriter sw = new StringWriter();
        
        try {
			mapper.writer(prettyPrinter).writeValue(sw, this);
		} catch (IOException e) {
			return e.getMessage();
		}
        return sw.toString();
    }

    @Override
    public int compareTo(Photo o) {
        return comparator.compare(this, o);
    }
    
    @Override
    protected Object clone() throws CloneNotSupportedException {
        Photo clone = new Photo();
        clone.setImage(this.getImage());
        clone.setDate(this.getDate());
        clone.setAddress(this.getAddress());
        clone.setDidascalie(this.getDidascalie());
        return clone;
    }

    static Comparator<Photo> comparator = new ComparatorPourri();
    static Comparator<String> naturalOrderComparator = new NaturalOrderComparator(); 
    
    static class ComparatorPourri implements Comparator<Photo> {

        @Override
        public int compare(Photo o1, Photo o2) {
            String[] a1 = splitImage(o1); 
            String[] a2 = splitImage(o2);
            int first = naturalOrderComparator.compare(a1[0], a2[0]);
            if (first != 0) {
                return first;
            }
            int second = naturalOrderComparator.compare(a1[1], a2[1]);
            return second;
        }
        
        String[] splitImage(Photo p) {
            return getDistrictFromImage(p.getImage());
        }
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((image == null) ? 0 : image.hashCode());
        return result;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Photo other = (Photo) obj;
        if (image == null) {
            if (other.image != null)
                return false;
        } else if (!image.equals(other.image))
            return false;
        return true;
    }

    public static String[] getDistrictFromImage(final String image) {
		String rest = image;
		String id   = image;
		int lastSlash = id.lastIndexOf('/');
		if (lastSlash != -1) {
		    id = id.substring(lastSlash+1);
		    rest = image.substring(0, lastSlash);
		    int lastMinus = rest.lastIndexOf('-');
		    if (lastMinus != -1) {
		        rest = rest.substring(lastMinus+1);
		    }
		}
		String extension = ".jpg";
		if (id.endsWith(extension)) {
		    id = id.substring(0, id.length()-extension.length()); 
		}
		
		return new String[] {rest, id};
	}

}

