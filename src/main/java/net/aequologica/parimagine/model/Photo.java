package net.aequologica.parimagine.model;

import java.util.Comparator;

public class Photo implements Comparable<Photo> {
    
    private String image; 
    private String date;
    private Address address;
    private String didascalie;
    
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
    
    public Address getAddress() {
        return address;
    }
    
    public void setAddress(Address address) {
        this.address = address;
    }
    
    public String getDidascalie() {
        return didascalie;
    }
    
    public void setDidascalie(String didascalie) {
        this.didascalie = didascalie;
    }
    
    @Override
    public String toString() {
        return "Photo [image=\"" + image + "\", date=\"" + date + "\", address=\"" + address + "\", didascalie=\"" + didascalie + "\"]";
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

    Comparator<Photo> comparator = new ComparatorPourri();
    Comparator<String> naturalOrderComparator = new NaturalOrderComparator(); 
    
    class ComparatorPourri implements Comparator<Photo> {

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
            String rest = p.getImage();
            String id   = p.getImage();
            int lastSlash = id.lastIndexOf('/');
            if (lastSlash != -1) {
                id = id.substring(lastSlash+1);
                rest = p.getImage().substring(0, lastSlash);
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

}

