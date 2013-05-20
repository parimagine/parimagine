package net.aequologica.parimagine.jaxrs;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;

import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.servlet.ServletContainer;

@WebServlet(
        urlPatterns = "/parimagine/*", 
        initParams = { 
                @WebInitParam(
                        name = "javax.ws.rs.Application", 
                        value = "net.aequologica.parimagine.jaxrs.Application"
                ) 
        }
)
public class Servlet extends ServletContainer {

    private static final long serialVersionUID = -6153263456493101310L;

    public Servlet() {
    }

    public Servlet(ResourceConfig resourceConfig) {
        super(resourceConfig);
    }
}
