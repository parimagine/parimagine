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

  <meta property="og:title" content="parimagine"/>
  <meta property="og:description" content="photothèque des jeunes parisiens"/>
  <meta property="og:image" content="https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/documents/photos-presse/cinema/P318.jpg"/>
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
  <link rel="stylesheet" href="bootstrap-combined.min.css">
  <link rel="stylesheet" href="bootstrap-lightbox.css">
  <link rel="stylesheet" href="style.css" />
  <style type="text/css">

  html {
    overflow-y: scroll; /* force display of vertical scrollbar */
    height: 101%;  /* enable vertical scrollbar (even when content fits in window) */
  }

  body {
    background-color: rgb(240, 240, 240);
  }

  header  {
    position:absolute;
    top:0;
    left:0;
    width: 100%;
    height: 20px;
    background: #eee;
  }

  section#content {
    padding-bottom: 120px;
  }
  
  footer  {
    position:fixed;
    bottom:0;
    left:0;
    width: 100%;
    background: rgb(212, 212, 212);
  }

  footer #next {
    width: 100%;
    border-style: none;
  }

  </style>
</head>

<body>
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
        <a class="brand" href="http://dev.parimagine.fr/">parimagine</a>
        <div class="nav-collapse collapse">
          <ul class="nav"> 
            <li class="dropdown" id="districts">  
                <a id="districts_menu" class="dropdown-toggle" data-toggle="dropdown" href="#">arrondissements [<span></span>]&nbsp;<b class="caret"></b></a>  
                <ul class="dropdown-menu">  
                </ul>  
            </li>  
          </ul>  
        </div>
      </div>
    </div>
  </div>

  <div class="container" style="padding-top: 45px;">

    <section id="content">

      <div class="row-fluid">
        <div id="photos_container" class="span12 clearfix">
        </div>
      </div>

    </section> 
  </div>

  <footer>
    <a id="next" class="btn btn-mini" href="#">
      <span class="centered">…</span>
    </a>
  </footer>

  <a id="next0" href="#" style="display:none">

    what the heck ?!
  </a>

  <div id="demoLightbox" class="lightbox hide"  tabindex="-1" role="dialog" aria-hidden="true">
    <div class='lightbox-content'>
      <img id='lightbox-img' src="stock-photo-5033318-eiffel-tower-statue.jpg"/>
      <div id="lightbox-caption" class="lightbox-caption"><p></p></div>
    </div>
  </div>    

<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="bootstrap.js"></script>
<script type="text/javascript" src="bootstrap-lightbox.js"></script>
<script type="text/javascript" src="jquery.infinitescroll.js"></script>
<script type="text/javascript" src="jquery.masonry.js"></script>
<script type="text/javascript" src="handlebars.js"></script>

<!-- !!!! content inside script id="didascalie-template" MUST start with "<", otherwise jquery explodes !!!! -->
<script id="didascalie-template" type="text/x-handlebars-template"><div class="centered box {{random}}">
  <a class="photo" href="{{photoServer}}/{{photo.image}}">
    <img src="{{photoServer}}/{{photo.image}}" >
  </a>
  <div style="margin-top:5px;">{{didascalie.base}}</div>
  <div>
    <small>{{didascalie.ext}}</small>
  </div>
  <div>
    <small>
      <a href="https://maps.google.com/maps?q=Paris+{{district}}+{{photo.address.number}}+{{photo.address.street}}" target="google_maps" >
        [{{district}}] {{number}} {{photo.address.street}} {{photo.address.legacy}}
      </a>
    </small>
  </div>
<div></script>

<script type="text/javascript">

if (typeof String.prototype.startsWith != 'function') {
  String.prototype.startsWith = function (str){
    return this.slice(0, str.length) == str;
  };
}

$(function(){

  var masonry_initiation_done = false;
  function masonry_initiation() {
    if (!masonry_initiation_done) {
      $photos_container.masonry({
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

  var current_district = 0;

  $.each(districts, function() {
    var $menu_item = $('<li><a href="#">'+(this == '' ? '&nbsp;' : this) +'</a></li>');
    $menu_item.click( function(event) 
      {
        event.preventDefault();
        $('.box').remove();
        var index = $(this).parent().children().index(this);
        $('#districts_menu span').html(districts[index]);
        $photos_container.masonry( 'destroy' );
        masonry_initiation_done = false;
        go(index);
      }
    );
    $(".dropdown-menu").append($menu_item);
  });

  // handlebars
  var handlebars_source   = $("#didascalie-template").html();
  var handlebars_template = Handlebars.compile(handlebars_source);

  var photoServer = "<c:url value='/documents' />";
  var jsonServer  = "<c:url value='/parimagine/page' />";
  var $photos_container  = $('#photos_container');

  function getAjaxURL(district, page, range) {
    return "<c:url value='/parimagine' />"+"/district/"+district+"/page/"+page+"?count="+range;
  }

  function random_width_class() {
    return "col"+(2+Math.round(1*Math.random()));
  }

  function new_box(photo) {
    // ask handlebars to render the template
    // parse didascalie
    var d = photo.didascalie.split(" | ");
    if (d[1].startsWith(d[0])) {
      d[1] = d[1].substring(d[0].length);
    }
    d[0] = $('<span>').html(d[0]).html();
    d[1] = $('<span>').html(d[1]).html();
    var dida = { base : d[0], ext : d[1]};

    return handlebars_template(
      {
        photoServer: photoServer, 
        photo      : photo, 
        number     : (photo.address.number=='0'?'':photo.address.number), 
        random     : random_width_class(), 
        district   : districts[photo.address.district],
        didascalie : dida
      }
    );
  }

  // lightbox will be shown when any element with class 'photo' is clicked
  function setup_lightbox() {
    $('.photo').click( function(event) 
      {
        event.preventDefault();
        $('#lightbox-img').attr('src', $(this).attr('href'));
        $('#lightbox-caption p').html($(this).parent().find('div').clone());
        $('#lightbox-img').load(function() {
          $('#demoLightbox').lightbox({});
        });
      }
    );
    return;
  }

  function go(district) {
    // fetch the inital 10 photos objects in json format from the server
    current_district = district; // save in global. I know it is BAD. 

    $.ajax(
      {
          type        : 'GET',
          dataType    : "json",
          url         : getAjaxURL(district, 0, 10),
      }).done(function( data, textStatus, jqXHR ) {

        $.each(data, function() {
          $photos_container.append(new_box(this));
        });  

        setup_lightbox();  

        $photos_container.imagesLoaded(function() {
          masonry_initiation();
          $(".box").animate({opacity: 1, visibility: "visible"});
        });

        $photos_container.infinitescroll(
          {
            navSelector  : "a#next0:last",   // selector for the paged navigation (it will be hidden)
            nextSelector : "a#next:last",   // selector for the NEXT link (to page 2)

            dataType: 'json',
            appendCallback: false,
            // prefill: true,
            path : function(current) {
              return getAjaxURL(current_district, current-1, 10);
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
              $photos_container.masonry( 'appended', $newElements, true ); 
              $newElements.animate({ opacity: 1, visibility: "visible"});
            });

            $photos_container.append($newElements);

            setup_lightbox();  

            return false;
          }
        );

        // unbind normal behavior. needs to occur after normal infinite scroll setup.
        // $(window).unbind('.infscr');

        // cf. http://stackoverflow.com/questions/10762656/infinite-scroll-manual-trigger
        $("a#next").click(function(){
          $photos_container.infinitescroll('retrieve');
          return false;
        });

      }).fail(function(jqXHR, textStatus, errorThrown){
          console.log(textStatus + ' ' + errorThrown);
      }
    );
  }

  go(0); // 0 -> district == 0 -> all districts

});  

</script>
</body>
</html>

