package net.aequologica.parimagine.jaxrs;

import java.io.IOException;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import net.aequologica.parimagine.model.Photo;
import net.aequologica.parimagine.model.Photos;

import org.apache.lucene.queryparser.classic.ParseException;

@javax.ws.rs.Path("/")
public class Resource {
	
    @GET
    @javax.ws.rs.Path("/district/{district}/page/{page}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Photo> getSlice(
            @PathParam("district") Integer district,
            @PathParam("page") Integer page,
            @QueryParam("count") Integer count ) throws IOException {
        if (count == null || count == 0 ) {
            count = 12;
        }
        return Photos.getInstance().getDistrictSlice(district, count, page);
    }

    @GET
    @javax.ws.rs.Path("/search")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Photo> search(
            @QueryParam("for")   String  searchString, 
            @QueryParam("count") Integer count ) throws IOException, ParseException {
        if (count == null || count == 0 ) {
            count = 32;
        }
        return Photos.getInstance().search("\""+searchString+"\"");
    }

    @GET
    @javax.ws.rs.Path("/datum/{image}")
    @Produces(MediaType.APPLICATION_JSON)
    public Photo photo(
    		@PathParam("image") String  image) throws IOException {
        return Photos.getInstance().getPhoto(image);
    }

    @GET
    @javax.ws.rs.Path("/data")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Photo> photo() throws IOException {
        return Photos.getInstance().getPhotos();
    }

}
