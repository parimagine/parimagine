<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" 
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

  <!-- google maps modal -->
  <div id="map-canvas" style="display:none;"></div>

  <div id="myModal" class="modal hide" tabindex="-1" role="dialog" 
       style="width: auto; height: auto;"> <!-- aria-labelledby="myModalLabel" aria-hidden="true" -->
       <!--
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      <h3 id="myModalLabel" style="display:none;">Modal header</h3>
    </div>
    -->
    <div class="modal-body" style="width: auto; height: auto; max-height: 800px;">
      <div id="pano"></div>
    </div>
    <!--
    <div class="modal-footer">
      <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    </div>
    -->
  </div>
  <!-- /google maps modal -->

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
        <div class="brand">Photothèque des Jeunes Parisiens</div>
        <div class="nav-collapse collapse">
          <ul class="nav"> 
            <li class="active"><a id="random_menu" href="#">au hasard</a>
            </li>
            <li class="dropdown" id="districts">  
                <a id="districts_menu" class="dropdown-toggle" data-toggle="dropdown" href="#"><span>arrondissements</span><b class="caret"></b></a>  
                <ul class="dropdown-menu">  
                </ul>  
            </li> 
            <li class="dropdown" id="themes">  
                <a id="themes_menu" class="dropdown-toggle" data-toggle="dropdown" href="#"><span>thèmes</span><b class="caret"></b></a>  
                <ul class="dropdown-menu">  
                </ul>  
            </li> 
          </ul>  
          <ul class="nav pull-right">
            <form class="navbar-search">
              <input type="text" class="search-query" placeholder="search">
                <i id="icon-search" class="add-on icon-search" >
                  <a href="#"  data-toggle="tooltip" data-placement="left" data-content="" title="search" style="margin-left:-20px;"></a>
                </i>
                <i id="icon-remove" class="icon-remove"></i>
              </input>
            </form>
          </ul>  
        </div>
      </div>
    </div>
  </div>

  <!-- page container
  ================================================== -->
  <div class="container" style="padding-top: 45px;">
    <section id="content">
      <div class="row-fluid">
        <div id="photos_container" class="span12 clearfix">
        </div>
      </div>
    </section> 
  </div>
  <!-- ==================================================
  /page container -->

  <!-- footer -->
  <footer>
    <a id="next" class="btn btn-mini" href="#">
      <span class="centered">…</span>
    </a>
  </footer>
  <!-- /footer -->

  <!-- ?????????????????????????? -->
  <a id="next0" href="#" style="display:none">what the heck ?! why this element ?</a>
  <!-- /?????????????????????????? -->

  <!-- lightbox -->
  <div id="demoLightbox" class="lightbox hide"  tabindex="-1" role="dialog" aria-hidden="true">
    <div class='lightbox-content'>
      <img id='lightbox-img' src="stock-photo-5033318-eiffel-tower-statue.jpg"/>
      <div id="lightbox-caption" class="lightbox-caption"><p/></div>
    </div>
  </div>    
  <!-- /lightbox -->

  <script type="text/javascript" src="jquery.js"></script>
  <script type="text/javascript" src="bootstrap.js"></script>
  <script type="text/javascript" src="bootstrap-lightbox.js"></script>
  <script type="text/javascript" src="jquery.infinitescroll.js"></script>
  <script type="text/javascript" src="jquery.masonry.js"></script>
  <script type="text/javascript" src="handlebars.js"></script>
  <script type="text/javascript" src="loading-clock.js"></script>

  <script
    type="text/javascript"
    src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;key=AIzaSyDAH1H-jE9iwiP-sr6hsrlYr4DEghUMuWI&amp;sensor=false&amp;region=FR">
  </script>

  <!-- handlebars template for photo box -->
  <!-- !!!! content inside script id="didascalie-template" MUST start with "<", otherwise jquery explodes !!!! -->
  <script id="didascalie-template" type="text/x-handlebars-template"><div class="centered box {{random}}">
    <a class="photo" href="<c:url value='/documents/'/>/{{photo.image}}">
      <img class="main_img" src="<c:url value='/documents/'/>{{photo.image}}" style="margin-bottom:5px;" />
    </a>
    <span>
    <div class="didascalie-base">
      {{didascalie.base}}
    </div>
    <div style="width=110%;">
      <div class="didascalie-ext">
         {{didascalie.ext}}
      </div>
      <span class="didascalie-url"
            {{#if nomap}}style="display:none;"{{/if}} >
         [{{district}}] {{number}} {{photo.address.street}} {{photo.address.legacy}}
      </span>

      <span id="link2streetView" style="position:relative; float: right; right:0;">
        <a  href="#" 
            data-address = "Paris+{{district}}+{{photo.address.number}}+{{photo.address.street}}"
            data-toggle="tooltip" 
            data-placement="bottom" 
            title="ça&nbsp;a&nbsp;quelle&nbsp;gueule&nbsp;aujourd'hui&nbsp;?" 
            {{#if nomap}}style="display:none;"{{/if}}
            >
          <i class="icon-globe"></i>
          <!--  
          <img src="<c:url value='/assets/images/40px-Mobile_Contributors_icon1.png'/>" style="width:20px; height: auto; opacity: .5;"> 
          -->
        </a>
      </span>
    <div>
    </span>
  <div></script>
  <!-- /handlebars template for photo box -->

  <div id="dvLoading"></div>

  <!-- le javascript -->
  <script type="text/javascript">

  if (typeof String.prototype.startsWith != 'function') {
    String.prototype.startsWith = function (str){
      return this.slice(0, str.length) == str;
    };
  }

  if (typeof String.prototype.trim != 'function') {
    String.prototype.trim = function (){
      return this.replace(/^\s+|\s+$/g, '');
    };
  }

  $(window).load(function() {
      animateStart();
  });

  $(document).ready(function(){

    var current_state = {
      infscrPageview : 0,

      district  : undefined,
      theme     : undefined, 
      search    : undefined,
      random    : true,

      raz : function() {
        this.district = undefined;
        this.theme    = undefined; 
        this.search   = undefined; 
        this.random   = false; 
      },

      setSearch : function(param) {
        this.raz();
        this.search = param;
        this.setupNavBar();
      },

      setDistrict : function(param) {
        this.raz();
        this.district = param;
        this.setupNavBar();
      },

      setTheme : function(param) {
        this.raz();
        this.theme = param;
        this.setupNavBar();
      },

      setRandom : function() {
        this.raz();
        this.random = true;
        this.setupNavBar();
      },

      // ...................................................................
      // update navbar display with current random|district|theme|search state
      setupNavBar : function() {
        if (this.district) {
          $('#districts_menu span').html(districts[this.district]);
          $('#districts_menu').parent().addClass('active');
        } else {
          $('#districts_menu span').html('arrondissements');
          $('#districts_menu').parent().removeClass('active');
        }
        if (this.theme) {
          $('#themes_menu span').html(themes[this.theme]);
          $('#themes_menu').parent().addClass('active');
        } else {
          $('#themes_menu span').html('thèmes');
          $('#themes_menu').parent().removeClass('active');
        }
        if (this.search) {
          $('.navbar-search input').val( this.search);
        } else {
          $('.navbar-search input').val('');
        }
        if (this.random) {
          $('#random_menu').parent().addClass('active');
        } else {
          $('#random_menu').parent().removeClass('active');
        }
      },

      // ...................................................................
      // construct photo set query URL
      getPhotoSetUrl : function() {
        var ret = "<c:url value='/parimagine' />";

        if (this.search) {
          // search URL
          ret = ret+"/search?for="+encodeURIComponent(this.search);
        } else {
          if (this.theme) {
            // themes URL 
            ret = ret+"/theme/"+themes[this.theme]+"/page/"+this.infscrPageview;
          } else {
            if (this.district) {
              // district URL. district == 0 -> all districts
              ret = ret+"/district/"+this.district+"/page/"+this.infscrPageview;
            } else {
              // random URL
              ret = ret+"/random/page/"+this.infscrPageview;
            }
          }
        }

        console.log(ret);

        return ret;
      },

      loadPhotoSet : function() {

        // raz 
        destroy_masonry();
        
        this.infscrPageview = 0;
        console.log("infscrPageview:" +this.infscrPageview);

        var that = this;

        $.ajax(
          {
              type        : 'GET',
              dataType    : "json",
              url         : this.getPhotoSetUrl(),
          }).done(function( data, textStatus, jqXHR ) {

            that.infscrPageview = 1;
            console.log("infscrPageview:" + that.infscrPageview);

            $.each(data, function() {
              $photos_container.append(create_new_box(this));
            });  

            setup_lightbox();  

            $photos_container.imagesLoaded(function() {
              initialize_masonry();
              $(".box")
                .animate({ 
                  opacity: 1, 
                  visibility: "visible"})
                .tooltip({
                  selector: "div span a[data-toggle=tooltip]"
              });

              // google maps
              $(".box div span a").click(function(event) {
                  event.preventDefault();
                  geoLocate($(this).attr('data-address'), $('#myModal'));
              });

            });

            if (that.search) { // no infinites croll on search results
              $photos_container.infinitescroll('pause');
            } else {
              $photos_container.infinitescroll(
                {
                  navSelector  : "a#next0:last",   // selector for the paged navigation (it will be hidden)
                  nextSelector : "a#next:last",   // selector for the NEXT link (to page 2)
                  itemSelector : '.box',     // selector for all items you'll retrieve

                  dataType: 'json',
                  appendCallback: false,
                  // prefill: true,
                  path : function(current) {
                    return that.getPhotoSetUrl();
                  },
                  loading: {
                    speed: 0,
                    img: 'ajax-loader.gif',
                    finishedMsg: '',
                    msgText: '',
                  }
                }, function(arrayOfNewElems, data, url) {
                  that.infscrPageview++;
                  console.log("infscrPageview:" +that.infscrPageview);

                  // an array of DOM elements
                  var newElements = [];
                  $.each(arrayOfNewElems, function() {
                    var newElement = $(create_new_box(this)).get()[0];
                    newElements.push(newElement);
                  });

                  // wrapp array of DOM elemnts in a jquery object
                  var $newElements = $(newElements);

                  $newElements.imagesLoaded(function(){
                    initialize_masonry(); // in case we arrive here before the 'normal' initiation
                    
                    // show elems now they're ready
                    $photos_container.masonry( 'appended', $newElements, true ); 
                    $newElements
                      .animate({ 
                        opacity: 1, 
                        visibility: "visible"})
                      .tooltip({
                        selector: "div span a[data-toggle=tooltip]"
                    });
                    // google maps
                    $newElements.find("div span a").click(function(event) {
                        event.preventDefault();
                        geoLocate($(this).attr('data-address'), $('#myModal'));
                    });

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

    };

    // -------------------------------------------------------------------
    // masonry
    var masonry_initiation_done = false;
    function initialize_masonry() {
      if (!masonry_initiation_done) {
        $photos_container.masonry({
          itemSelector : '.box',
          columnWidth : 90,
          gutterWidth: 40,
          isAnimated: true,
        });
        masonry_initiation_done = true;
      }
    }

    function destroy_masonry() {
      $('.box').remove();
      if (masonry_initiation_done) {
          $photos_container.masonry( 'destroy' );
          masonry_initiation_done = false;
      }
    }

    // -------------------------------------------------------------------
    // search tooltip
    $search_tooltip = $("a[data-toggle=tooltip]");

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

    // add districts to navbar dropdown
    $.each(districts, function() {
      var $menu_item = $('<li><a href="#">'+(this == '' ? '&nbsp;' : this) +'</a></li>');
      $menu_item.click( function(event) 
        {
          event.preventDefault();
          // get district, give visual feedback
          var index = $(this).parent().children().index(this);

          // give visual feedback
          current_state.setDistrict(index);

          // destroy/re-create masonry, load images into boxes
          current_state.loadPhotoSet();
        }
      );
      $("#districts .dropdown-menu").append($menu_item);
    });

    // -------------------------------------------------------------------
    // themes
    var themes = [
      "",
      "bals",
      "cinema",
      "enfants",
      "enseignes",
      "etudiants",
      "fetesaintecatherine",
      "halles",
      "manifestations",
      "metiers",
      "police",
      "pompiers",
      "quais",
      "saisons",
      "vie-montmartre"
    ];
    var current_theme = "";

    // add themes to navbar dropdwon
    $.each(themes, function() {
      var $menu_item = $('<li><a href="#">'+(this == '' ? '&nbsp;' : this) +'</a></li>');
      $menu_item.click( function(event) 
        {
          event.preventDefault();
          // get theme
          var index = $(this).parent().children().index(this);

          // change state, & give visual feedback
          current_state.setTheme(index);

          // destroy/re-create masonry, load images into boxes
          current_state.loadPhotoSet();
        }
      );
      $("#themes .dropdown-menu").append($menu_item);
    });

    $('#random_menu').click(function(event) {
      event.preventDefault();

      // change state, & give visual feedback
      current_state.setRandom();

      // destroy/re-create masonry, load images into boxes
      current_state.loadPhotoSet();
    });

    // -------------------------------------------------------------------
    // compile handlebars template
    var handlebars_source   = $("#didascalie-template").html();
    var handlebars_template = Handlebars.compile(handlebars_source);

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

        dida.base = arr[0];
        dida.ext  = arr[1];
      }

      // convert e.g. &apos; to '
      dida.base = $('<span>').html(dida.base).html().trim();
      dida.ext  = $('<span>').html(dida.ext).html().trim();

      var nomap = true;
      // is there enough address to show link to google map ?
      if (districts[photo.address.district] && photo.address.street) {
        nomap = false;
      }
        
      // ask handlebars to render the template
      return handlebars_template(
        {
          photo      : photo,
          didascalie : dida,
          number     : (photo.address.number=='0'?'':photo.address.number), 
          random     : get_random_width_class(), 
          district   : districts[photo.address.district],
          nomap      : nomap,
        }
      );
    }

    function search(searchString) {

      if (searchString) {
        // change state, & give visual feedback
        current_state.setSearch(searchString);

        // destroy/re-create masonry, load images into boxes
        current_state.loadPhotoSet();
      }
    }

    $('.navbar-search .icon-search').click(function(event) {
        search($('.navbar-search input').val().trim());
      }
    );

    $('.navbar-search .icon-remove').click(function(event) {
        $('.navbar-search input').val('');
        // search(undefined);
      }
    );

    $('.navbar-search input').bind('keypress', function(event) {
      var code = (event.keyCode ? event.keyCode : event.which);
      if (code == 13) { //Enter keycode
        event.preventDefault();
        search($(this).val().trim());
      }
    });

    // borrowed from http://stackoverflow.com/questions/7380190/select-whole-word-with-getselection
    function snapSelectionToWord() {
        var sel;

        // Check for existence of window.getSelection() and that it has a
        // modify() method. IE 9 has both selection APIs but no modify() method.
        if (window.getSelection && (sel = window.getSelection()).modify) {
            sel = window.getSelection();
            if (!sel.isCollapsed) {

                // Detect if selection is backwards
                var range = document.createRange();
                range.setStart(sel.anchorNode, sel.anchorOffset);
                range.setEnd(sel.focusNode, sel.focusOffset);
                var backwards = range.collapsed;
                range.detach();

                // modify() works on the focus of the selection
                var endNode = sel.focusNode, endOffset = sel.focusOffset;
                sel.collapse(sel.anchorNode, sel.anchorOffset);

                var direction = [];
                if (backwards) {
                    direction = ['backward', 'forward'];
                } else {
                    direction = ['forward', 'backward'];
                }

                sel.modify("move", direction[0], "character");
                sel.modify("move", direction[1], "word");
                sel.extend(endNode, endOffset);
                sel.modify("extend", direction[1], "character");
                sel.modify("extend", direction[0], "word");
            }
        } else if ( (sel = document.selection) && sel.type != "Control") {
            var textRange = sel.createRange();
            if (textRange.text) {
                textRange.expand("word");
                // Move the end back to not include the word's trailing space(s),
                // if necessary
                while (/\s$/.test(textRange.text)) {
                    textRange.moveEnd("character", -1);
                }
                textRange.select();
            }
        }
    }

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

    // borrowed from http://stackoverflow.com/questions/1067464/need-to-cancel-click-mouseup-events-when-double-click-event-detected
    function doubleClick(e) {
      var selected_text = get_selected_text();
      if (selected_text != '') {
        $('.navbar-search input').val(selected_text);
        $search_tooltip.tooltip('show');
        setTimeout(function(){
          $search_tooltip.tooltip('hide');
          }, 2000
        );
      }
    }
    function singleClick(e) {
      snapSelectionToWord();
      doubleClick(e);
    }

    $photos_container.click(function(e) {
      var that = this;
      setTimeout(function() {
        var dblclick = parseInt($(that).data('double'), 10);
        if (dblclick > 0) {
            $(that).data('double', dblclick-1);
        } else {
            singleClick.call(that, e);
        }
      }, 333);
    }).dblclick(function(e) {
      $(this).data('double', 2);
      doubleClick.call(this, e);
    });    

    // lightbox will be shown when any element with class 'photo' is clicked
    function setup_lightbox() {
      $('.photo').click( function(event) 
        {
          event.preventDefault();
          $('#lightbox-img').attr('src', $(this).attr('href'));
          var $didascalieBase = $(this).parent().children("span:first").clone();
          $didascalieBase.remove('#link2streetView');
          $('#lightbox-caption p').html($didascalieBase);
          $('#lightbox-img').load(function() {
            $('#demoLightbox').lightbox({maximize: true});
          });
        }
      );
      return;
    }

    <c:if test="${not empty param.search}" >
      current_state.setSearch('<%= new String(request.getParameter("search").getBytes("ISO-8859-1"), "UTF-8") %>');
    </c:if>

    current_state.loadPhotoSet();

    // cf . http://stackoverflow.com/questions/387942/google-street-view-url-question
    function buildGoogleMapsStreeViewURL(address, location) {
      var ret = "http://maps.google.com/maps?q=";
      ret += address;
      ret += "&layer=c";
      ret += "&cbll=";
      ret += location.jb;
      ret += ",";
      ret += location.kb;
      ret += "&cbp=12,0,0,0,0";
      return ret;
    }

    var geocoder = new google.maps.Geocoder();

    function geoLocate(address, $myModal) {
      geocoder.geocode( { 'address': address }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {

          /*
          var remote = buildGoogleMapsStreeViewURL(address, results[0].geometry.location);
          console.log(remote);
          */

          var fenway = new google.maps.LatLng(results[0].geometry.location.jb, results[0].geometry.location.kb);

          var $mapCanvas = $('#map-canvas');
          var $pano      = $myModal.find('.modal-body');

          var mapOptions = {
            center : fenway,
            zoom : 13,
            mapTypeId : google.maps.MapTypeId.ROADMAP,
          };
          var map = new google.maps.Map($mapCanvas.get(0), mapOptions);

          var panoramaOptions = {
              position: fenway,
              pov: {
                heading: 34,
                pitch: 10,
                zoom: 1
              },
              visible: true,
          };
          var panorama = new google.maps.StreetViewPanorama($pano.get(0), panoramaOptions);
          panorama.setPov(panorama.getPhotographerPov());

          map.setStreetView(panorama);

          var windowHeight = $(window).height();
          var windowWidth  = $(window).width();
          $pano.css({width: Math.round(0.9*windowWidth)+'px', height: Math.round(0.9*windowHeight)+'px'});
          panorama.setVisible(true);

          $myModal.modal().css({
            'margin-left': function () {
              return -($(this).width() / 2);
            }
          }).show();

        } else {
          alert('Street View data not found for this location.');
        }
      });
    }
  });  

  </script>
  <!-- /le javascript -->

</body>
</html>

