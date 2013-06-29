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

  <!-- facebook metadata 
       cf. http://ogp.me/ -->
  <meta property="og:title"       content="Parimagine"/>
  <meta property="og:description" content="Photothèque des Jeunes Parisiens"/>
  <meta property="og:image"       content=""/>
  <meta property="og:image:type"  content="image/jpeg" />
  <meta property="og:url"         content="#"/>
  <meta property="og:type"        content="website"/>
  <meta property="og:site_name"   content="Parimagine"/>
  <meta property="og:locale"      content="fr_FR"/>
  <meta property="fb:app_id"      content="104250825478"/>
  <!-- /facebook metadata -->

  <title>Parimagine | Photothèque des Jeunes Parisiens</title>
      
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
  .fb-like {
    padding-top: 10px;
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
        <a id="prev" class="btn text-left" href='#'>
          <i class="icon-chevron-left"></i>
        </a>
      </div>

      <div id="photo_container" class="span10 pagination-centered">
      </div>

      <div class="span1 text-right" >
        <a id="next" class="btn" href='#'>
          <i class="icon-chevron-right"></i>
        </a>
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

  <!-- handlebars template for photo box -->
<!-- !!!! content inside script id="didascalie-template" MUST start with "<", otherwise jquery explodes !!!! -->
<script id="photo-template" type="text/x-handlebars-template"
><div style="opacity: 0;">
  <img id="photo", class="centered" src="{{baseURL}}{{photo.image}}" style="margin-bottom: 10px;">
  <br/>
  <span id="didascalie" class="centered" style="font-size: larger;">{{{photo.didascalie.base}}}</span>
  <br/>
  <span id="didascalie" class="centered" style="font-size: smaller;">{{{photo.didascalie.ext}}}</span>
  <br/>
  <span class="centered fb-like" data-href="" data-send="true" data-layout="button_count" data-width="200" data-show-faces="false" data-font="tahoma"></span>
<div></script>
<!-- /handlebars template for photo box -->

<script type="text/javascript">
  // -------------------------------------------------------------------
  // compile handlebars template
  var handlebars_source   = $("#photo-template").html();
  var handlebars_template = Handlebars.compile(handlebars_source);

  $(document).ready(function(){

    $.ajax(
        {
            type        : 'GET',
            dataType    : "json",
            url         : "<c:url value='/photo/datum/'/>"+${param.index},
        }).done(function( photo, textStatus, jqXHR ) {
          var documentsBaseURL = "<%= net.aequologica.parimagine.model.Photos.getInstance().toURL(request, null) %>";
          if (documentsBaseURL.substr(-1) != '/') {
            documentsBaseURL += '/';
          }
          
          $("meta[property='og:title']"      ).attr('content', photo.didascalie.base + " | " + photo.didascalie.ext);
          $("meta[property='og:description']").attr('content', "Parimagine | Photothèque des Jeunes Parisiens");
          $("meta[property='og:image']"      ).attr('content', documentsBaseURL+photo.image);
          $("meta[property='og:url']"        ).attr('content', location.origin+"<c:url value='/photo.jsp?index='/>"+photo.index);
          
          $('#photo_container').html(handlebars_template({
            photo: photo,
            baseURL: documentsBaseURL,
          }));

          imagesLoaded( '#photo', function() {
            $('#photo').parent().animate({opacity: 1}, 500);
          });
          
          if (photo.index < <%= net.aequologica.parimagine.model.Photos.getInstance().getSize() %>) {
            $('#next').attr('href', '<c:url value="/photo/"/>'+(photo.index+1));
            $('#next').css({opacity:1});
          } else {
            $('#next').css({opacity:0});
          }

          if (0 < photo.index) {
            $('#prev').attr('href', '<c:url value="/photo/"/>'+(photo.index-1));
            $('#prev').css({opacity:1});
          } else {
            $('#prev').css({opacity:0});
          }

          $('.fb-like').attr('data-href', location);
          $('.fb-like').css({visibility:'visible'});


        }).fail(function(jqXHR, textStatus, errorThrown){
          $('.fb-like').css({visibility:'hidden'});
        }).always(function(){
        }
      );
    
  });  
  </script>

</body>
</html>

