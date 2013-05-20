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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@javax.ws.rs.Path("/")
public class Resource {
    private static Logger log = LoggerFactory.getLogger(Resource.class);

    @GET
    @javax.ws.rs.Path("/page/{page}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Photo> getSlice(
            @PathParam("page") Integer page,
            @QueryParam("count") Integer count ) throws IOException {
        if (count == null || count == 0 ) {
            count = 12;
        }
        return Photos.getInstance().getSlice(count, page);
    }

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
}
