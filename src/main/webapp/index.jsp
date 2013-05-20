<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ taglib prefix="c"   uri="http://java.sun.com/jstl/core_rt" 
%><!doctype html>
<!--[if IEMobile 7 ]> <html lang="en-US"class="no-js iem7"> <![endif]-->
<!--[if lt IE 7 ]> <html lang="en-US" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en-US" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en-US" class="no-js ie8"> <![endif]-->
<!--[if (gte IE 9)|(gt IEMobile 7)|!(IEMobile)|!(IE)]><!-->
<html lang="en-US" ><!--<![endif]-->
  <head>
    <meta charset="UTF-8" />
    <meta name="google" content="notranslate">
    <meta http-equiv="Content-Language" content="en" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta property="og:url" content=""/>
    <meta property="og:title" content=""/>
    <meta property="og:description" content=""/>
    <meta property="og:image" content=""/>
    <meta property="og:type" content="website"/>
    <title>parimagine</title>
        
    <meta name="HandheldFriendly" content="True"/>
    <meta name="MobileOptimized" content="320"/>

    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    
    <!-- media-queries.js (fallback) -->
    <!--[if lt IE 9]>
      <script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>     
    <![endif]-->

    <!-- html5.js -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
    <link rel="stylesheet" href="bootstrap-lightbox.css">
    <link rel="stylesheet" href="style.css" />
  </head>
  
  <body>
    <div class="container">

      <section id="content">

        <div class="row-fluid">
          <div id="container" style="visiblity:hidden; margin: 0 auto;" class="span12 clearfix">
          </div>
        </div>

        <footer class="row-fluid">
          <a id="next" href="#" class="btn span12 clearfix" style="margin-top:10px;">
            <span class="centered">…<span>
          </a>
        </footer>

      </section> 
    <div>

    <a id="next0" href="#" style="display:none">what the heck ?!</a>

    <div id="demoLightbox" class="lightbox hide"  tabindex="-1" role="dialog" aria-hidden="true">
      <div class='lightbox-content'>
        <img id='lightbox-img' src="#"/>
        <!-- div class="lightbox-caption"><p>Your caption here</p></div-->
      </div>
    </div>    

  </body>
</html>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
<!-- script src="//cdnjs.cloudflare.com/ajax/libs/jquery-infinitescroll/2.0b2.110713/jquery.infinitescroll.min.js"></script-->
<script src="https://raw.github.com/paulirish/infinite-scroll/master/jquery.infinitescroll.js"></script>
<!--script src="//cdnjs.cloudflare.com/ajax/libs/masonry/2.1.08/jquery.masonry.min.js"></script-->
<script src="http://masonry.desandro.com/jquery.masonry.js"></script>
<script src="handlebars.js"></script>

<script src="scale.fix.js"></script>
<script src="bootstrap-lightbox.js"></script>

<script id="didascalie-template" type="text/x-handlebars-template"><div class="centered box {{random}}">
  <a class="photo" href="{{photoServer}}/{{photo.image}}">
    <img src="{{photoServer}}/{{photo.image}}" >
  </a>
  <div style="margin-top:5px;">{{photo.didascalie}}</div>
  <div>
    <a href="https://maps.google.com/maps?q=Paris+{{district}}+ {{photo.address.number}}+{{photo.address.street}}" target="google_maps" >
      {{district}} {{photo.address.number}} {{photo.address.street}} {{photo.address.legacy}}
    </a>
  </div>
<div></script>

<script type="text/javascript">

$(function(){

  var source   = $("#didascalie-template").html();
  var template = Handlebars.compile(source);

  // var photoServer = "http://localhost:1212/geppaequo-fileupload/documents";
  // var photoServer = "SiteParimagine/Piwi/galleries";
  var photoServer = "<c:url value='/documents' />";
  var jsonServer  = "<c:url value='/parimagine/page' />";
  var $container              = $('#container');
  var masonry_initiation_done = false;
  
  function masonry_initiation() {
    if (!masonry_initiation_done) {
      $container.masonry({
        itemSelector : '.box',
        columnWidth : 90,
        gutterWidth: 40,
        // isFitWidth: true,
        // isAnimated: true
      });
      masonry_initiation_done = true;
    }
  }

  var districts = [
    "",
    "1er",
    "2ème",
    "3ème",
    "4ème",
    "5ème",
    "6ème",
    "7ème",
    "8ème",
    "9ème",
    "10ème",
    "11ème",
    "12ème",
    "13ème",
    "14ème",
    "15ème",
    "16ème",
    "17ème",
    "18ème",
    "19ème",
    "20ème"
  ];

  function random_width_class() {
    return "col"+(2+Math.round(1*Math.random()));
  }

  function new_box(photo) {
    return template({photoServer:photoServer, photo: photo, random: random_width_class(), district: districts[photo.address.district] });
  }

  function il_est_tard() {
    $('.photo').click( function(event) 
      {
        event.preventDefault();
        console.log(this);
        $('#lightbox-img').attr('src', $(this).attr('href'));
        $('#lightbox-img').load(function() {
          $('#demoLightbox').lightbox({});
        });
      }
    );
    return;
  }

  $.ajax(
    {
        type        : 'GET',
        dataType    : "json",
        url         : jsonServer+"/0?count=20",
    }).done(function( data, textStatus, jqXHR ) {
      $.each(data, function() {
        $container.append(new_box(this));
      });  

      il_est_tard();  

      $container.imagesLoaded(function() {
        masonry_initiation();
      });

      $container.infinitescroll(
        {
          navSelector  : "a#next0:last",   // selector for the paged navigation (it will be hidden)
          nextSelector : "a#next:last",   // selector for the NEXT link (to page 2)

          dataType: 'json',
          appendCallback: false,
          // prefill: true,
          path : function(current) {
            return jsonServer+"/"+(current-1)+"?count=20";
          },
          itemSelector : '.box',     // selector for all items you'll retrieve
          loading: {
            speed: 0,
            img: 'ajax-loader.gif',
            finishedMsg: '',
            msgText: '',
          },
        }, function(data, opts) {
          var page = opts.state.currPage;  // no used now, just in case of

          // an array of DOM elements
          var newElements = [];
          $.each(data, function() {
            var newElement = $(new_box(this)).get()[0];
            newElements.push(newElement);
          });

          // wrapp array of DOM elemnts in a jquery object
          var $newElements = $(newElements);

          $newElements.imagesLoaded(function(){
            masonry_initiation(); // in case we arrive here before the 'normal' initiation
            // show elems now they're ready
            $newElements.animate({ opacity: 1 });
            $container.masonry( 'appended', $newElements, true ); 
          });

          $container.append($newElements);

          il_est_tard();  

          return false;
        }
      );

      /*      
      // unbind normal behavior. needs to occur after normal infinite scroll setup.
      $(window).unbind('.infscr');

      // cf. http://stackoverflow.com/questions/10762656/infinite-scroll-manual-trigger
      $("a#next").click(function(){
        $container.infinitescroll('retrieve');
        return false;
      });
      */

    }).fail(function(jqXHR, textStatus, errorThrown){
        console.log(textStatus + ' ' + errorThrown);
    }
  );
});  

</script>
