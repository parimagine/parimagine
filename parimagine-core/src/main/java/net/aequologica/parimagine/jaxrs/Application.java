package net.aequologica.parimagine.jaxrs;

import javax.ws.rs.ApplicationPath;

import org.glassfish.jersey.logging.LoggingFeature;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.mvc.jsp.JspMvcFeature;

import com.fasterxml.jackson.jaxrs.json.JacksonJsonProvider;

@ApplicationPath("/api/parimagine/v1")
public class Application extends ResourceConfig {

    public Application() {

		register(LoggingFeature.class);
        register(JacksonJsonProvider.class);
        register(JspMvcFeature.class);
        
        register(Resource.class);
    }
}
