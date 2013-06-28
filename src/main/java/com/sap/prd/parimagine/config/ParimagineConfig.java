package com.sap.prd.parimagine.config;

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

    @Managed
    public String getDocuments() {
        return get("documents");
    }

    @Managed
    public void setDocuments(String documents) {
        set("documents", documents);
    }

}
