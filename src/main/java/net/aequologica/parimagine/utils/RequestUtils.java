package net.aequologica.parimagine.utils;

import javax.servlet.http.HttpServletRequest;

public class RequestUtils {

    public static String getBaseURL(HttpServletRequest req) {
    
        String scheme = req.getScheme();             // http
        String serverName = req.getServerName();     // hostname.com
        int serverPort = req.getServerPort();        // 80
        String contextPath = req.getContextPath();   // /mywebapp
        String servletPath = req.getServletPath();   // /servlet/MyServlet
        /*
        String pathInfo = req.getPathInfo();         // /a/b;c=123
        String queryString = req.getQueryString();   // d=789
        */
    
        // Reconstruct original requesting URL
        StringBuffer url =  new StringBuffer();
        url.append(scheme).append("://").append(serverName);
    
        if ((serverPort != 80) && (serverPort != 443)) {
            url.append(":").append(serverPort);
        }
    
        url.append(contextPath).append(servletPath);
    
        return url.toString();
    }

}
