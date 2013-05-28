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
    @javax.ws.rs.Path("/data")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Photo> getPhotos() throws IOException {
        return Photos.getInstance().getPhotos();
    }

    @GET
    @javax.ws.rs.Path("/datum/{image}")
    @Produces(MediaType.APPLICATION_JSON)
    public Photo getPhoto(
    		@PathParam("image") String image ) throws IOException {
        return Photos.getInstance().getPhoto(image);
    }

    @GET
    @javax.ws.rs.Path("/district/{district}/page/{page}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Photo> getSlice(
            @PathParam("district") Integer district,
            @PathParam("page") Integer page,
            @QueryParam("count") Integer count ) throws IOException {
        return Photos.getInstance().getDistrictSlice(district, new Photos.Slice(page, count));
    }

    @GET
    @javax.ws.rs.Path("/theme/{theme}/page/{page}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Photo> getSlice( 
    		@PathParam("theme") String theme,
            @PathParam("page") Integer page,
            @QueryParam("count") Integer count  ) throws IOException {
        return Photos.getInstance().getThemeSlice(theme, new Photos.Slice(page, count));
    }

    @GET
    @javax.ws.rs.Path("/random/page/{page}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Photo> getSlice(
    		@PathParam("page") Integer page,
            @QueryParam("count") Integer count  ) throws IOException {
        return Photos.getInstance().getRandomSlice(new Photos.Slice(page, count));
    }

    @GET
    @javax.ws.rs.Path("/search")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Photo> search(
    		@QueryParam("for") String  searchString) throws IOException, ParseException {
        return Photos.getInstance().search("\""+searchString+"\"", new Photos.Slice(null, 2*Photos.Slice.DEFAULT_SIZE));
    }

}
