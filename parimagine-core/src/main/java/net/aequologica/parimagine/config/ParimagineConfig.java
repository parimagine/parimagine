package net.aequologica.parimagine.config;

import java.io.IOException;

import org.weakref.jmx.Managed;

import net.aequologica.neo.geppaequo.config.AbstractConfig;
import net.aequologica.neo.geppaequo.config.Config;

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

    @Managed
    public Boolean getVerify() {
        return get("verify").equalsIgnoreCase("true");
    }

    @Managed
    public void setVerify(Boolean verify) {
        set("verify", verify.toString());
    }

}
