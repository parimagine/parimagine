<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ taglib prefix="c"  uri="http://java.sun.com/jstl/core_rt" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%><!doctype html>
<!--[if IEMobile 7 ]> <html lang="fr"class="no-js iem7"> <![endif]-->
<!--[if lt IE 7 ]> <html lang="fr" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="fr" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="fr" class="no-js ie8"> <![endif]-->
<!--[if (gte IE 9)|(gt IEMobile 7)|!(IEMobile)|!(IE)]><!-->
<html lang="fr" ><!--<![endif]-->
<head>
  <meta charset="UTF-8" />
  <meta name="google" content="notranslate">
  <meta http-equiv="Content-Language" content="fr" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

  <meta property="og:title" content="Photothèque des Jeunes Parisiens"/>
  <c:if test="${not empty param.didascalie}">
    
    <% 
      String    d = new String(request.getParameter("didascalie").getBytes("ISO-8859-1"), "UTF-8");
      String[] ad = net.aequologica.parimagine.model.Didascalie.split(d);
      pageContext.setAttribute("didascalie", d); 
      pageContext.setAttribute("didascalie_base", ad[0]); 
      pageContext.setAttribute("didascalie_ext", ad[1]); 
    %>
    <meta property="og:description" content="${didascalie}"/>
  </c:if>
  <c:if test="${not empty param.image}">
    <meta property="og:image" content="https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/documents/${param.image}"/>
  </c:if>
  <meta property="og:type" content="website"/>

  <title>Photothèque des Jeunes Parisiens</title>
      
  <meta name="HandheldFriendly" content="True"/>
  <meta name="MobileOptimized" content="320"/>

  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  
  <!-- media-queries.js (fallback) -->
  <!--[if lt IE 9]>
    <script src="//css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>     
  <![endif]-->

  <!-- html5.js -->
  <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
  <link rel="stylesheet" href="bootstrap-combined.min.css">
  <link rel="stylesheet" href="bootstrap-lightbox.css">
  
  <link href='//fonts.googleapis.com/css?family=Ubuntu:400' rel='stylesheet' type='text/css'>

  <style type="text/css">
  @font-face {
    font-family: 'Peignot';
    font-style: normal;
    font-weight: 400;
    src: local('Peignot '), url('<c:url value="/assets/fonts/Peignot.woff"/>') format('woff');
  }

  @font-face {
    font-family: 'ParmaPetit';
    font-style: normal;
    font-weight: 400;
    src: local('ParmaPetit '), url('<c:url value="/assets/fonts/ParmaPetit-Normal.woff"/>') format('woff');
  }

  .navbar-search .icon-search {
    opacity: 0.5;
    position: absolute;
    top: 7px;
    left: 11px;
    background-image: url("<c:url value='/img/glyphicons-halflings.png' />");
  }

  .navbar-search .icon-search a {
    opacity: 1;
  }

  .navbar-search .icon-remove {
    opacity: 0.5;
    position: absolute;
    top: 7px;
    right: 11px;
    background-image: url("<c:url value='/img/glyphicons-halflings.png' />");
  }

  </style>
  
  <link rel="stylesheet" href="style.css" />

</head>

<body>

<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=104250825478";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script> 

  <!-- Navbar
  ================================================== -->
  <div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <div class="brand"><a id="index" href="index.jsp">Photothèque des Jeunes Parisiens</a></div>
      </div>
    </div>
  </div>

  <c:set var="baseURL" value="${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, pageContext.request.contextPath)}" />

  <!-- page container
  ================================================== -->
  <div class="container" style="padding-top: 70px;">
    <div class="row-fluid">
      <div class="span1 text-left" >
        <c:if test="${param.prev != -1}">
          <a id="prev" class="btn text-left" href='<c:url value="/photo/${param.prev}"/>'><i class="icon-chevron-left"></i></a>
        </c:if>
      </div>
      <div id="photo_container" class="span10 pagination-centered" style="opacity: 0;">
        <c:if test="${not empty param.image}">
          <img id="photo", class="centered" src='<c:url value="/documents/${param.image}"/>' style="margin-bottom: 10px;">
          <br/>
          <c:if test="${not empty param.didascalie}">
            <span id="didascalie" class="centered" style="font-size: larger;">${didascalie_base}</span>
            <br/>
            <span id="didascalie" class="centered" style="font-size: smaller;">${didascalie_ext}</span>
          </c:if>
        </c:if>
      </div>
      <div class="span1 text-right" >
       <c:if test="${param.next != -1}">
         <a id="next" class="btn" href='<c:url value="/photo/${param.next}"/>'><i class="icon-chevron-right"></i></a>
       </c:if>
      </div>
      <div class="span12 text-right fb-like" data-href="http://photos.parimagine.fr/photo/${param.index}" data-send="true" data-layout="button_count" data-width="200" data-show-faces="false" data-font="tahoma">
      </div>
    </div>
  </div>
  <!-- ==================================================
  /page container -->

  <!-- le javascript -->
  <script type="text/javascript" src="jquery.js"></script>
  <script type="text/javascript" src="bootstrap.js"></script>
  <script type="text/javascript" src="handlebars.js"></script>
  <script type="text/javascript" src="imagesloaded.pkgd.js"></script>

  <script type="text/javascript">
  $(document).ready(function(){

    $('#prev').click(function(event) {
      event.preventDefault();
      window.location = "photo/${param.prev}";
    });
    $('#next').click(function(event) {
      event.preventDefault();
      window.location = "photo/${param.next}";
    });
    imagesLoaded( '#photo', function() {
      $('#photo').parent().animate({opacity: 1}, 500);
    });
  });  
  </script>

</body>
</html>

