<%@page contentType="text/html" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="t" tagdir="/WEB-INF/tags" 
%><t:layout module="parimagine">

<style type="text/css">
html {
  height: 100%
}

body {
  height: 100%;
  margin: 0;
  padding: 0
}

#map-canvas {
  height: 100%
}

</style>

<div id="map-canvas"></div>

</t:layout>

<script
  type="text/javascript"
  src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyDAH1H-jE9iwiP-sr6hsrlYr4DEghUMuWI&sensor=false&region=FR"
></script>

<script type="text/javascript">
  
// Enable the visual refresh
google.maps.visualRefresh = true;

    
function initialize() {
      var geocoder = new google.maps.Geocoder();
      
      var mapOptions = {
        center : new google.maps.LatLng(48.859746, 2.351074),
        zoom : 13,
        mapTypeId : google.maps.MapTypeId.ROADMAP
      };
      
      var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
      
      function codeAddress(tuple) {
          geocoder.geocode( { 'address': tuple.goo }, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
              // map.setCenter(results[0].geometry.location);
              var marker = new google.maps.Marker({
                  map: map,
                  // icon: "https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/documents/arrondissements/paris-11/872.jpg",
                  position: results[0].geometry.location
              });
              console.log(tuple.par + ": "+ tuple.goo + ": "+ results[0].geometry.location);
              google.maps.event.addListener(marker, 'click', function() {
                window.location.href = 'https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/?search='+tuple.par;
              });            
            } else {
              console.log("Geocode was not successful for the following reason: " + status);
            }
          });
      }    

      function markAddress(addr) {
        var marker = new google.maps.Marker({
            map: map,
            // icon: "https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/documents/arrondissements/paris-11/872.jpg",
            position: addr.loc
        });
        google.maps.event.addListener(marker, 'click', function() {
          window.location.href = 'https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/?search='+addr.par;
        });            
      }    

      var list = [ {
         par: 'Rosiers',
         goo: 'Rue+des+Rosiers',
         loc: new google.maps.LatLng(48.857685,2.358413)
        },{
         par: "Épée",
         goo: "Rue+de+l'Abb%C3%A9+de+l'%C3%89p%C3%A9e",
         loc: new google.maps.LatLng(48.843941,2.338962)
        },{
         par: "Groult",
         goo: "Rue+de+l'Abb%C3%A9+Groult",
         loc: new google.maps.LatLng(48.839131,2.297258)
        },{
         par: "Fouquets",
         goo: "99+Avenue+des+Champs+%C3%89lys%C3%A9es",
         loc: new google.maps.LatLng(48.871829,2.301078)
      }];

      for ( i=0; i<list.length; i++) {
          markAddress(list[i]);
      }
  }

  google.maps.event.addDomListener(window, 'load', initialize);
  
  </script>
    
<script type="text/javascript">
$(document).ready(function(){
});
</script>
