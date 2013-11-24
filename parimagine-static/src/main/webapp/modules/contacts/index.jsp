<%@page contentType="text/html" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="t" tagdir="/WEB-INF/tags" 
%><t:layout module="parimagine">

<style type="text/css">
.pagination-centered {
  text-align: center;
}
</style>

      <div class="row">
        <div class="col-lg-12 pagination-centered">
          <address>
            <strong>Editions Parimagine</strong><br>
             9, rue de Mulhouse<br>
             75002 Paris<br>
             M° Sentier<br>
            <abbr title="Phone">Tél.:</abbr> 01 45 08 11 97<br>
            <abbr title="Phone">Fax:</abbr> 01 45 08 81 06
          </address>
           
          <address>
            <strong>Mail</strong><br>
            <a href="mailto:info@paris-imagine.fr">info@paris-imagine.fr</a>
          </address>
    
          <address>
            <strong>Heures d'ouverture</strong><br>
            du lundi au vendredi: 10h - 13h / 14h - 18h
          </address>
    
          <img src="<c:url value='/assets/images/logo.jpg'/>" />

        </div>
       </div>

</t:layout>

<script type="text/javascript">
$(document).ready(function(){
});
</script>
