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
  
  <style type="text/css">
  @font-face {
    font-family: 'Peignot';
    font-style: normal;
    font-weight: 400;
    src: local('Peignot '), url('<c:url value="/assets/fonts/Peignot.woff"/>') format('woff');
  }
  @font-face {
    font-family: 'ParmaPetitOutline';
    font-style: normal;
    font-weight: 400;
    src: local('ParmaPetitOutline '), url('<c:url value="/assets/fonts/ParmaPetitOutline.woff"/>') format('woff');
  }
  @font-face {
    font-family: 'ParmaPetit';
    font-style: normal;
    font-weight: 400;
    src: local('ParmaPetit '), url('<c:url value="/assets/fonts/ParmaPetit-Normal.woff"/>') format('woff');
  }
  @font-face {
    font-family: 'Inconsolata';
    font-size: larger;
    font-style: normal;
    font-weight: 400;
    src: local('Inconsolata'), url(<c:url value='/assets/fonts/BjAYBlHtW3CJxDcjzrnZCIbN6UDyHWBl620a-IRfuBk.woff'/>) format('woff');
  }

  .navbar-search .icon-search {
    opacity: 0.5;
    position: absolute;
    top: 7px;
    left: 11px;
    background-image: url("<c:url value='/img/glyphicons-halflings.png' />");
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
        <div class="brand">photothèque des jeunes parisiens</div>
        <div class="nav-collapse collapse">
          <ul class="nav"> 
            <li class="dropdown" id="districts">  
                <a id="districts_menu" class="dropdown-toggle" data-toggle="dropdown" href="#">arrondissements [<span></span>]&nbsp;<b class="caret"></b></a>  
                <ul class="dropdown-menu">  
                </ul>  
            </li> 
            <form class="navbar-search pull-left">
              <input type="text" class="search-query" placeholder="Search" data-toggle="popover" data-placement="bottom" data-content="">
                <i id="icon-search" class="icon-search"></i>
                <li><a href="#" data-toggle="popover" data-placement="bottom" data-content="" title="Search"></a></li>              
                <i id="icon-remove" class="icon-remove"></i>
              </input>
            </form>
          </ul>  
        </div>
      </div>
    </div>
  </div>

  <div class="container" style="padding-top: 45px;">

    <div class="popover bottom">
      <div class="arrow"></div>
      <h3 class="popover-title">Search</h3>
    </div>

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
  <a class="photo" href="<c:url value='/documents/'/>/{{photo.image}}">
    <img src="<c:url value='/documents/'/>{{photo.image}}" style="margin-bottom:5px;" />
  </a>
  <div class="didascalie-base">
    {{didascalie.base}}
  </div>
  <div class="didascalie-ext">
     {{didascalie.ext}}
  </div>
  <div class="didascalie-url">
    <a href="https://maps.google.com/maps?q=Paris+{{district}}+{{photo.address.number}}+{{photo.address.street}}" target="google_maps" >
      [{{district}}] {{number}} {{photo.address.street}} {{photo.address.legacy}}
    </a>
  </div>
<div></script>

<script type="text/javascript">

if (typeof String.prototype.startsWith != 'function') {
  String.prototype.startsWith = function (str){
    return this.slice(0, str.length) == str;
  };
}

String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g, '');};

$(document).ready(function(){

  // -------------------------------------------------------------------
  // masonry
  var masonry_initiation_done = false;
  function initialize_masonry() {
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

  // -------------------------------------------------------------------
  // popover 
  $("a[data-toggle=popover]").popover().click(function(e) {
    e.preventDefault();
  })

  // -------------------------------------------------------------------
  // districts
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

  // add districts to navbar dropdwon
  $.each(districts, function() {
    var $menu_item = $('<li><a href="#">'+(this == '' ? '&nbsp;' : this) +'</a></li>');
    $menu_item.click( function(event) 
      {
        event.preventDefault();
        // get district, give visual feedback
        var index = $(this).parent().children().index(this);
        $('#districts_menu span').html(districts[index]);
        // raz 
        $('.box').remove();
        $photos_container.masonry( 'destroy' );
        masonry_initiation_done = false;
        // load images into boxes
        load_photo_set(index);
      }
    );
    $(".dropdown-menu").append($menu_item);
  });

  // -------------------------------------------------------------------
  // compile handlebars template
  var handlebars_source   = $("#didascalie-template").html();
  var handlebars_template = Handlebars.compile(handlebars_source);

  // -------------------------------------------------------------------
  // construct photo set query URL
  var current_search_object = {
    text : undefined,
    set : function(text) {
      this.text = text;
      $('.navbar-search input').val(this.text);
    },
    get : function() {
      return encodeURIComponent(this.text);
    },
    is_valid : function() {
      if (typeof this.text === "undefined") {
        return false;
      }
      if (typeof this.text == "undefined") {
        return false;
      }
      if (typeof this.text == undefined) {
        return false;
      }
      if (this.text.length == 0) {
        return false;
      }
      if (this.text == "") {
        return false;
      }
      if (this.text == '') {
        return false;
      }
      return true;
    },
  }

  function get_photo_set_url(district, page, range) {
    // district URL. district == 0 -> all districts
    if (!current_search_object.is_valid()) {
      return "<c:url value='/parimagine' />"+"/district/"+district+"/page/"+page+"?count="+range;
    }

    // search URL
    return "<c:url value='/parimagine' />"+"/search?for="+current_search_object.get();
  }
  
  var $photos_container  = $('#photos_container');

  function get_random_width_class() {
    return "col"+(2+Math.round(1*Math.random()));
  }

  function create_new_box(photo) {
    var dida = { 
      base: photo.didascalie, 
      ext: '' 
    };

    // parse didascalie
    var arr = photo.didascalie.split(" | ");
    if (arr.length > 1) {
      if (arr[1].startsWith(arr[0])) {
        arr[1] = arr[1].substring(arr[0].length);
      }

      dida.base = arr[0]
      dida.ext  = arr[1];
    }

    // convert e.g. &apos; to '
    dida.base = $('<span>').html(dida.base).html();
    dida.ext  = $('<span>').html(dida.ext).html();
      
    // ask handlebars to render the template
    return handlebars_template(
      {
        photo      : photo,
        didascalie : dida,
        number     : (photo.address.number=='0'?'':photo.address.number), 
        random     : get_random_width_class(), 
        district   : districts[photo.address.district]
      }
    );
  }

  function search(searchString) {
    current_search_object.set(searchString);
    $("a[data-toggle=popover]").popover('hide');
    $('#districts_menu span').html(districts[0]);
    // raz
    $('.box').remove();
    $photos_container.masonry( 'destroy' );
    masonry_initiation_done = false;
    load_photo_set(0);
  }

  $('.navbar-search .icon-search').click(function(event) {
      search($('.navbar-search input').val().trim());
    }
  );

  $('.navbar-search .icon-remove').click(function(event) {
      $('.navbar-search input').val('');
      search(undefined);
    }
  );

  $('.navbar-search input').bind('keypress', function(event) {
    var code = (event.keyCode ? event.keyCode : event.which);
    if (code == 13) { //Enter keycode
      event.preventDefault();
      search($(this).val().trim());
    }
  });

  // borrowed from http://www.codetoad.com/javascript_get_selected_text.asp
  get_selected_text = function() {
    var text = '';
    if (window.getSelection){
      text = window.getSelection();
    } else if (document.getSelection){
      text = document.getSelection();
    } else if (document.selection){
      text = document.selection.createRange().text;
    }
    return text;
  }

  // use jQuery to bind a mouseup event handler to the document
  $photos_container.bind("mouseup", function() {
    var selected_text = get_selected_text();
    if (selected_text != '') {
      $('.navbar-search input').val(selected_text);
      $("a[data-toggle=popover]").popover('show');
    } else {
      $("a[data-toggle=popover]").popover('hide');
    }
  });

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

  function load_photo_set(district) {
    // fetch the inital 10 photos objects in json format from the server
    current_district = district; // save in global. I know it is BAD. 

    $.ajax(
      {
          type        : 'GET',
          dataType    : "json",
          url         : get_photo_set_url(district, 0, 10, current_search_object.get()),
      }).done(function( data, textStatus, jqXHR ) {

        $.each(data, function() {
          $photos_container.append(create_new_box(this));
        });  

        setup_lightbox();  

        $photos_container.imagesLoaded(function() {
          initialize_masonry();
          $(".box").animate({opacity: 1, visibility: "visible"});
        });

        if (current_search_object.is_valid()) { // infinites croll disabled on search results
          $photos_container.infinitescroll('pause');
        } else {
          $photos_container.infinitescroll(
            {
              navSelector  : "a#next0:last",   // selector for the paged navigation (it will be hidden)
              nextSelector : "a#next:last",   // selector for the NEXT link (to page 2)

              dataType: 'json',
              appendCallback: false,
              // prefill: true,
              path : function(current) {
                return get_photo_set_url(current_district, current-1, 10);
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
                var newElement = $(create_new_box(this)).get()[0];
                newElements.push(newElement);
              });

              // wrapp array of DOM elemnts in a jquery object
              var $newElements = $(newElements);

              $newElements.imagesLoaded(function(){
                initialize_masonry(); // in case we arrive here before the 'normal' initiation
                
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
          $photos_container.infinitescroll('resume');
        }

      }).fail(function(jqXHR, textStatus, errorThrown){
          console.log(textStatus + ' ' + errorThrown);
      }
    );
  }



  <c:if test="${not empty param.search}" >


    current_search_object.set('<%= new String(request.getParameter("search").getBytes("ISO-8859-1"), "UTF-8") %>');
  </c:if>
  load_photo_set(0); // 0 -> district == 0 -> all districts

});  

</script>
</body>
</html>

