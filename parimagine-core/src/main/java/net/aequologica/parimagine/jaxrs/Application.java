package net.aequologica.parimagine.jaxrs;

import org.glassfish.jersey.filter.LoggingFilter;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.mvc.jsp.JspMvcFeature;

import com.fasterxml.jackson.jaxrs.json.JacksonJsonProvider;

public class Application extends ResourceConfig {

    public Application() {

        register(LoggingFilter.class);
        register(JacksonJsonProvider.class);
        register(JspMvcFeature.class);
        register(Resource.class);

    }
}
