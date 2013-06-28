package net.aequologica.parimagine.jaxrs;

import java.io.IOException;
import java.net.URI;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;

import net.aequologica.parimagine.model.Photo;
import net.aequologica.parimagine.model.Photos;
import net.aequologica.parimagine.utils.RequestUtils;

import org.apache.lucene.queryparser.classic.ParseException;
import org.glassfish.jersey.server.mvc.Viewable;

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
    public Photo getPhoto(@PathParam("image") String image ) throws IOException {
        return Photos.getInstance().getPhoto(image);
    }

    @GET
    @javax.ws.rs.Path("{index: \\d+}")
    @Produces(MediaType.APPLICATION_JSON)
    public Viewable getPhotoJsp(@PathParam("index") int index ) throws IOException {
    	int max = Photos.getInstance().getSize();
    	if (index < 0 || max <= index ) {
        	throw new WebApplicationException(Response.noContent().build());
        }
    	Photo photo = Photos.getInstance().getPhoto(index);
    	if (photo == null) {
        	throw new WebApplicationException(Response.noContent().build());
    	}
    	URI location = UriBuilder
    			.fromUri("../photo.jsp")
    			.queryParam("index", index)
    			.queryParam("prev", 0<index?index-1:-1)
    			.queryParam("next", index<max-1?index+1:-1)
    			.queryParam("image", photo.getImage())
    			.queryParam("didascalie", photo.getDidascalie().toString())
    			.build();
    	
    	throw new WebApplicationException(Response.temporaryRedirect(location).build());
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
    @javax.ws.rs.Path("/random")
    @Produces(MediaType.TEXT_PLAIN)
    public String getRandom(@Context HttpServletRequest request) throws IOException {
        List<Photo> singleton = Photos.getInstance().getRandomSlice(new Photos.Slice(0, 1));
        return Photos.getInstance().toURL(request, singleton.get(0).getImage());
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
