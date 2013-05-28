package net.aequologica.parimagine.model;

public class Slice {
	
    final public static int DEFAULT_SIZE = 12;
    
    final Integer offset;
    final Integer size;
    
	public Slice(final Integer offset, final Integer size) {

	    if (offset == null) {
	    	this.offset = 0;
	    } else {
	    	this.offset = offset;	
	    }
	    
	    if (size == null || size == 0 ) {
	    	this.size = DEFAULT_SIZE;
	    } else {
	    	this.size = size;
	    }
	}
	
    int getFrom(final int max) {
    	return Math.min(this.size*offset, max);
    }
	
    int getTo(final int max) {
    	return Math.min(this.size*(offset+1), max);
    }
	
}
