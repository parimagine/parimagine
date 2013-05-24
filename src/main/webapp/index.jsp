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
            <li><a id="random_menu" href="#">au hasard</a>
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
      <div id="lightbox-caption" class="lightbox-caption"><p></p></div>
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

  <!-- handlebars template for photo box -->
  <!-- !!!! content inside script id="didascalie-template" MUST start with "<", otherwise jquery explodes !!!! -->
  <script id="didascalie-template" type="text/x-handlebars-template"><div class="centered box {{random}}">
    <a class="photo" href="<c:url value='/documents/'/>/{{photo.image}}">
      <img class="main_img" src="<c:url value='/documents/'/>{{photo.image}}" style="margin-bottom:5px;" />
    </a>
    <div class="didascalie-base">
      {{didascalie.base}}
    </div>
    <div style="width=110%;">
      <div class="didascalie-ext">
         {{didascalie.ext}}
      </div>
      <span class="didascalie-url">
         [{{district}}] {{number}} {{photo.address.street}} {{photo.address.legacy}}
      </span>

      <span style="position:relative; float: right; right:0;">
        <a  href="https://maps.google.com/maps?q=Paris+{{district}}+{{photo.address.number}}+{{photo.address.street}}" 
            title="search 'Paris+{{district}}+{{photo.address.number}}+{{photo.address.street}}' on google maps" 
            target="google_maps" 
            >
          <i class="icon-globe"></i>
          <!--  
          <img src="<c:url value='/assets/images/40px-Mobile_Contributors_icon1.png'/>" style="width:20px; height: auto; opacity: .5;"> 
          -->
        </a>
      </span>
    <div>
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

    // -------------------------------------------------------------------
    // masonry
    var masonry_initiation_done = false;
    function initialize_masonry() {
      if (!masonry_initiation_done) {
        $photos_container.masonry({
          itemSelector : '.box',
          columnWidth : 90,
          gutterWidth: 40,
          isAnimated: true
          // isFitWidth: true,
        });
        masonry_initiation_done = true;
      }
    }

    function destroy_masonry() {
      if (masonry_initiation_done) {
          $('.box').remove();
          $photos_container.masonry( 'destroy' );
          masonry_initiation_done = false;
      }
    }

    // -------------------------------------------------------------------
    // search tooltip
    $search_tooltip = $("a[data-toggle=tooltip]");
    
    // -------------------------------------------------------------------
    // update navbar display with current random|district|theme|search state
    function setup_navbar(three) {
      $('#districts_menu span').html(three.district);
      $('#themes_menu span').html(three.theme);
      current_search_object.set(three.search);
    }

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

    // add districts to navbar dropdown
    $.each(districts, function() {
      var $menu_item = $('<li><a href="#">'+(this == '' ? '&nbsp;' : this) +'</a></li>');
      $menu_item.click( function(event) 
        {
          event.preventDefault();
          // get district, give visual feedback
          var index = $(this).parent().children().index(this);

          // give visual feedback
          setup_navbar({
            district:index==0?'arrondissements':districts[index],
            theme: 'thèmes',
            search: ''
            }
          );

          // destroy/re-create masonry, load images into boxes
          load_photo_set(index);
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

          // give visual feedback
          setup_navbar({
            district:'arrondissements',
            theme: index==0?'thèmes':themes[index],
            search: ''
            }
          );

          // destroy/re-create masonry, load images into boxes
          load_photo_set(themes[index]);
        }
      );
      $("#themes .dropdown-menu").append($menu_item);
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

    var infscrPageview = 0;

    function get_photo_set_url(district, theme) {
      var ret = "";
      if (!current_search_object.is_valid()) {
        if (theme != "") {
          // themes
          ret = "<c:url value='/parimagine' />"+"/theme/"+theme+"/page/"+infscrPageview+"?count="+10;
        } else {
          // district URL. district == 0 -> all districts
          ret = "<c:url value='/parimagine' />"+"/district/"+district+"/page/"+infscrPageview+"?count="+10;
        }
      } else {
      // search URL
        ret = "<c:url value='/parimagine' />"+"/search?for="+current_search_object.get() 
      }

      console.log(ret);

      return ret;
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

        dida.base = arr[0];
        dida.ext  = arr[1];
      }

      // convert e.g. &apos; to '
      dida.base = $('<span>').html(dida.base).html().trim();
      dida.ext  = $('<span>').html(dida.ext).html().trim();
        
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

      // give visual feedback
      setup_navbar({
        district:'arrondissements',
        theme: 'thèmes',
        search: searchString
        }
      );

      // destroy/re-create masonry, load images into boxes
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
          $('#lightbox-caption p').html($(this).parent().find('div').clone());
          $('#lightbox-img').load(function() {
            $('#demoLightbox').lightbox({maximize: true});
          });
        }
      );
      return;
    }

    function load_photo_set(district_or_theme) {

      // raz 
      destroy_masonry();
      
      console.log("(district || theme) == "+district_or_theme);

      if (0 <= district_or_theme && district_or_theme <= 20) {
        // fetch the inital 10 photos objects in json format from the server
        current_district = district_or_theme; // save in global. I know it is BAD. 
        current_theme = "";
      } else {
        current_district = 0; 
        current_theme = district_or_theme;
      }

      infscrPageview = 0;
      console.log("infscrPageview:" +infscrPageview);

      $.ajax(
        {
            type        : 'GET',
            dataType    : "json",
            url         : get_photo_set_url(current_district, current_theme, current_search_object.get()),
        }).done(function( data, textStatus, jqXHR ) {

          infscrPageview = 1;
          console.log("infscrPageview:" +infscrPageview);

          $.each(data, function() {
            $photos_container.append(create_new_box(this));
          });  

          setup_lightbox();  

          $photos_container.imagesLoaded(function() {
            initialize_masonry();
            $(".box").animate({opacity: 1, visibility: "visible"});
          });

          if (current_search_object.is_valid()) { // no infinites croll on search results
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
                  return get_photo_set_url(current_district, current_theme);
                },
                loading: {
                  speed: 0,
                  img: 'ajax-loader.gif',
                  finishedMsg: '',
                  msgText: '',
                }
              }, function(arrayOfNewElems, data, url) {
                infscrPageview++; 
                console.log("infscrPageview:" +infscrPageview);

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

    load_photo_set(0); // 0 -> district == 0 -> all districts, all themes

  });  

  </script>
  <!-- /le javascript -->

</body>
</html>

