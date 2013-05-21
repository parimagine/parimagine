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
    
    class ComparatorPourri implements Comparator<Photo> {

        @SuppressWarnings({ "unchecked", "rawtypes" })
        @Override
        public int compare(Photo o1, Photo o2) {
            Comparable[] a1 = getComparableArray(o1); 
            Comparable[] a2 = getComparableArray(o2);
            int first = a1[0].compareTo(a2[0]);
            if (first != 0) {
                return first;
            }
            int second = a1[1].compareTo(a2[1]);
            return second;
        }
        @SuppressWarnings("rawtypes")
        Comparable[] getComparableArray(Photo p) {
            String rest = p.getImage();
            String id = p.getImage();
            int lastSlash = id.lastIndexOf('/');
            if (lastSlash != -1) {
                id = id.substring(lastSlash+1);
                rest = p.getImage().substring(0, lastSlash);
                int lastMinus = rest.lastIndexOf('-');
                if (lastMinus != -1) {
                    rest = rest.substring(lastMinus+1);
                }
            }
            if (id.endsWith(".jpg")) {
                id = id.substring(0, id.length()-4); 
            }
            return new Comparable[] {Integer.parseInt(rest), Integer.parseInt(id)};
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

