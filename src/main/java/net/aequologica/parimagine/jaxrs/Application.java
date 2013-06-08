package net.aequologica.parimagine.jaxrs;

import java.util.HashSet;
import java.util.Set;
import java.util.logging.Logger;

import org.glassfish.jersey.filter.LoggingFilter;

import com.fasterxml.jackson.jaxrs.json.JacksonJsonProvider;

public class Application extends javax.ws.rs.core.Application {

	@Override
	public Set<Class<?>> getClasses() {
		final Set<Class<?>> classes = new HashSet<>();

		classes.add(Resource.class);

		return classes;
	}

	@Override
	public Set<Object> getSingletons() {
		final HashSet<Object> instances = new HashSet<>();

		instances.add(new LoggingFilter(Logger.getLogger(Application.class.getName()), false));
		instances.add(new JacksonJsonProvider());
		/*
		 * https://jersey.java.net/nonav/documentation/latest/user-guide.html#d0e5895
		 * Jersey web applications that want to use MVC templating support feature should be registered as Servlet filters rather than Servlets in the application's web.xml. 
		 * The web.xml-less deployment style introduced in Servlet 3.0 is not supported at the moment for web applications that require use of Jersey MVC templating support.
		 */
		// instances.add(new JspMvcFeature());
		return instances;
	}

}
