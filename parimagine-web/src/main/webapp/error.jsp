<%@page contentType="text/html" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="t" tagdir="/WEB-INF/tags" 
%><t:layout module="parimagine">

<h1>HTML error <a target="404" href="http://fr.wikipedia.org/wiki/Peugeot_404">404</a> page not found</h1>
<h2>La page que vous cherchez n'existe pas, ou plus.</h2>
<h3>Ils sont en train de ré-écrire le site.</h3>
<h4> Vous pouvez les <a href="mailto:christophe.thiebaud[at]sap.com">contacter.</a></h4>
<h5>N'oubliez pas de remplacer le '[at]' par @.</h5>
<h6>Voilà, voilà.</h6>

<img src= "<c:url value='/404.jpg'/>"/>

</t:layout>


<script type="text/javascript">
$(document).ready(function(){
});
</script>




