<%@page contentType="text/html" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="t" uri="http://net.aequologica.neo/jsp/jstl/layout" 
%><t:layout>

<style type="text/css">
.iframe_container {
    height: 100%; 
    width: 100%; 
    overflow-x: hidden; 
    overflow-y: hidden;
}
iframe {
    height: 100%; 
    width: 100%; 
    overflow-x: hidden; 
    overflow-y: hidden; 
    display:none;
}
</style>

<ul class="nav nav-tabs">
  <li class="active"><a href="#iframe1" data-toggle="tab">[4ème] Rue des rosiers</a></li>
  <li><a href="#iframe2" data-toggle="tab">[5ème] Rue de l'Abbé-de-l'Épée</a></li>
  <li><a href="#iframe3" data-toggle="tab">[15ème] Rue De l'Abbé Groult</a></li>
  <li><a href="#iframe4" data-toggle="tab">[8ème] Avenue des Champs Elysées</a></li>
</ul>

 <div id="myTabContent" class="tab-content">
  <div class="tab-pane fade in active" id="iframe1">    
    <div class="row">
      <div class="col-lg-12">
        <span style="float:left;">
          <a href="https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/?search=ROSIERS+(RUE+DES)" target="parimagine">
            avant
          </a>
        </span>
        <span style="float:right;">
          <a href="http://goo.gl/maps/gSaFL" target="google_maps">
            après
          </a>
        </span>
      </div>
      <div class="col-lg-12 pagination-centered iframe_container">
        <iframe src="before-after-iframe1.html" seamless ></iframe>
      </div>
    </div>
  </div>

  <div class="tab-pane fade in active" id="iframe2">    
    <div class="row">
      <div class="col-lg-12">
        <span style="float:left;">
          <a href="https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/?search=ABBE%20DE%20L%20EPEE%20(RUE%20DE%20L%20)" target="parimagine">
            avant
          </a>
        </span>
        <span style="float:right;">
          <a href="http://goo.gl/maps/Cy0O0" target="google_maps">
            après
          </a>
        </span>
      </div>
      <div class="col-lg-12 pagination-centered iframe_container">
        <iframe src="before-after-iframe2.html" seamless ></iframe>
      </div>
    </div>
  </div>

  <div class="tab-pane fade in active" id="iframe3">    
    <div class="row">
      <div class="col-lg-12">
        <span style="float:left;">
          <a href="https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/?search=ABBE%20GROULT%20(RUE%20DE%20L%20)" target="parimagine">
            avant
          </a>
        </span>
        <span style="float:right;">
          <a href="http://goo.gl/maps/Zf7Mm" target="google_maps">
            après
          </a>
        </span>
      </div>
      <div class="col-lg-12 pagination-centered iframe_container">
        <iframe src="before-after-iframe3.html" seamless ></iframe>
      </div>
    </div>
  </div>

  <div class="tab-pane fade in active" id="iframe4">    
    <div class="row">
      <div class="col-lg-12">
        <span style="float:left;">
          <a href="https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/?search=Le%20Fouquet" target="parimagine">
            avant
          </a>
        </span>
        <span style="float:right;">
          <a href="http://goo.gl/maps/ruXuL" target="google_maps">
            après
          </a>
        </span>
      </div>
      <div class="col-lg-12 pagination-centered iframe_container">
        <iframe src="before-after-iframe4.html" seamless ></iframe>
      </div>
    </div>
  </div>

</div>

</t:layout>

<script src="jquery.browser.js"></script>
<script src="jquery.iframe-auto-height.js"></script>

<script type="text/javascript">
$(function(){
  $('iframe').iframeAutoHeight().fadeIn();
});
</script>    

