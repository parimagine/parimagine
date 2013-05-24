package net.aequologica.parimagine.config;

import java.io.IOException;

import org.weakref.jmx.Managed;

import com.sap.prd.geppaequo.config.AbstractConfig;
import com.sap.prd.geppaequo.config.Config;

@Config(name = "parimagine")
public final class ParimagineConfig extends AbstractConfig {
    
    public ParimagineConfig() throws IOException {
        super();
    }

    @Managed
    public String getTitle() {
        return get("title");
    }

    @Managed
    public void setTitle(String title) {
        set("title", title);
    }

}
