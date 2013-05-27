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

  <meta property="og:title" content="Photothèque des Jeunes Parisiens"/>
  <meta property="og:description" content="Photothèque des Jeunes Parisiens"/>
  <meta property="og:image" content="https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/documents/photos-presse/cinema/P318.jpg"/>
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

  <!-- google maps modal -->

  <div id="myModal" class="modal hide" tabindex="-1" role="dialog" aria-hidden="true" 
       style="width: auto; height: auto;"> <!-- aria-labelledby="myModalLabel" -->
    <!--
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      <h3 id="myModalLabel" style="display:none;">Modal header</h3>
    </div>
    -->
    <div class="modal-body">
      <div id="legacy" class="permanentBox" style="position:absolute; bottom:0; left:0; z-index:1000;">
        <img/>
      </div>
      <table style="width:100%; height: 100%; max-width:100%; max-height: 100%; ">
        <tr>
          <td>
            <div id="map-canvas"></div>
          </td>
          <td>
            <div id="pano"></div>
          </td>
        </tr>
      </table>
    </div>
    <!--
    <div class="modal-footer">
      <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    </div>
    -->
  </div>
  <!-- /google maps modal -->

  <!-- lightbox -->
  <div id="demoLightbox" class="lightbox hide"  tabindex="-1" role="dialog" aria-hidden="true">
    <div class='lightbox-content'>
      <img id='lightbox-img' src="stock-photo-5033318-eiffel-tower-statue.jpg"/>
      <div id="lightbox-caption" class="lightbox-caption"><p/></div>
    </div>
  </div>    
  <!-- /lightbox -->


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
                <i class="add-on icon-search" >
                  <a href="#" id="a-search" data-toggle="tooltip" data-placement="left" data-content="" title="search" style="margin-left:-20px;">
                  </a>
                </i>
                <i id="icon-remove" class="icon-remove"></i>
              </input>
            </form>
            <!-- i id="icon-info-sign" class="icon-info-sign"></i -->
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
        <div id="phototheque" class="span12 clearfix">
        </div>
        <div id="photos_container" class="span12 clearfix">
        </div>
      </div>
    </section> 
  </div>
  <!-- ==================================================
  /page container -->

  <div id="loadingWrapper" style="position: fixed; bottom: 0; left:0; width:100%; margin: 0; padding:0; display:none; opacity:.3333; background: #4682b4;">
    <div id="loading" style="width:32px; height:32px; margin: 0 auto; padding:0;">
      <img src="ajax-loader4.gif"/>
    </div>
  </div>

  <!-- footer -->
  <footer class="row" style="width:100%; display:none;">
    <a id="start" class="span12" href="#">
      <span class="centered">start infinite scroll</span>
    </a>
    <a id="next" class="span12" href="#">
      <span class="centered">next infinite scroll</span>
    </a>
  </footer>
  <!-- /footer -->

  <!-- ?????????????????????????? -->
  <!-- /?????????????????????????? -->

  <script type="text/javascript" src="jquery.js"></script>
  <script type="text/javascript" src="bootstrap.js"></script>
  <script type="text/javascript" src="bootstrap-lightbox.js"></script>
  <script type="text/javascript" src="jquery.infinitescroll.js"></script>
  <script type="text/javascript" src="jquery.masonry.js"></script>
  <script type="text/javascript" src="handlebars.js"></script>
  <script type="text/javascript" src="loading-clock.js"></script>
  <!--script type="text/javascript" src="phototheque.js"></script-->
  <script type="text/javascript" src="jquery.phototheque.js"></script>


  <script
    type="text/javascript"
    src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;key=AIzaSyDAH1H-jE9iwiP-sr6hsrlYr4DEghUMuWI&amp;sensor=false&amp;region=FR&amp;language=fr">
  </script>

  <!-- handlebars template for photo box -->
  <!-- !!!! content inside script id="didascalie-template" MUST start with "<", otherwise jquery explodes !!!! -->
  <script id="didascalie-template" type="text/x-handlebars-template"
  ><div class="centered box {{random_width_class}}">
    <a class="photo" href="<c:url value='/documents/'/>/{{photo.image}}">
      <img class="box_img" src="<c:url value='/documents/'/>{{photo.image}}" />
    </a>
    <span>
    <div class="didascalie-base">
      {{didascalie.base}}
    </div>
    <div>
      <div class="didascalie-ext">
         {{didascalie.ext}}
      </div>
      <span class="didascalie-url"
            {{#if noaddress}}style="display:none;"{{/if}} >
         [{{district}}] {{number}} {{photo.address.street}} {{photo.address.legacy}}
      </span>

      <span class="iconLinks">
        <a  id="favourite"
            data-toggle="tooltip" 
            data-placement="bottom" 
            title="j'adore&nbsp;cette&nbsp;photo!&nbsp;(coming&nbsp;soon...)"
          <i class="icon-star-empty"></i>
        </a>
        <a  id="streetView"
            href="#" 
            data-address="Paris+{{district}}+{{photo.address.number}}+{{photo.address.street}}"
            data-toggle="tooltip" 
            data-placement="bottom" 
            title="ça&nbsp;a&nbsp;quelle&nbsp;gueule&nbsp;aujourd'hui&nbsp;?" 
            {{#if noaddress}}style="display:none;"{{/if}}
            >
          <i class="icon-globe"></i>
        </a>
      </span>
    <div>
    </span>
  <div></script>
  <!-- /handlebars template for photo box -->

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

  $(document).ready(function(){

    var $phototheque = new $.Phototheque($('#phototheque')); 
    // console.log($phototheque.settings.propertyName);


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

        $('#loadingWrapper').show();

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
              $('.box div span a[data-toggle=tooltip]').tooltip().hover(function() {changeTooltipColorTo('#4682b4')}); /* steel blue http://en.wikipedia.org/wiki/Steel_blue */
              $(".box").animate(
                { 
                  opacity: 1, 
                  visibility: "visible"
                }
              );

              // google maps
              $(".box div span a#streetView").click(function(event) {
                  event.preventDefault();
                  geoLocate($(this), $('#myModal'));
              });

              $(".box div span a#favourite").click(function(event) {
                  event.preventDefault();
              });

              $('#loadingWrapper').hide();

            });

            if (that.search) { // no infinites croll on search results
              $photos_container.infinitescroll('pause');
            } else {
              $photos_container.infinitescroll(
                {
                  navSelector     : "a#start:last",   // selector for the paged navigation (it will be hidden)
                  nextSelector    : "a#next:last",   // selector for the NEXT link (to page 2)
                  itemSelector    : '.box',     // selector for all items you'll retrieve
                  dataType        : 'json',
                  appendCallback  : false,
                  // prefill: true,
                  // animate         : true,
                  // extraScrollPx   : 300,
                  path            : function(current) { return that.getPhotoSetUrl(); },
                  loading         : {
                    start: function(opts) {
                      console.log('start.this: '+this);
                      console.log('start.opts: '+opts);
                      //$(opts.navSelector).hide();
                      $('#loadingWrapper').show();
                      /* 
                        { 
                          easing: 'linear',
                          complete: function() {
                          }
                        }                        
                      );
                      */
                      $photos_container.infinitescroll('beginAjax', opts);
                      
                      /*
                      opts.loading.msg
                        .appendTo(opts.loading.selector)
                        .show(opts.loading.speed, $.proxy(function() {
                          this.beginAjax(opts);
                        }, this));                      
                      */
                    },
                    finished: function() {},
                    img: 'ajax-loader.gif',
                    msg: null,
                    msgText: '',
                    selector: '#loading',
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
                    $newElements.find('div span a[data-toggle=tooltip]').tooltip().hover(function() {changeTooltipColorTo('#4682b4')}); /* steel blue http://en.wikipedia.org/wiki/Steel_blue */
                    $newElements.animate(
                      { 
                        opacity: 1, 
                        visibility: "visible"
                      }
                    );
                    // google maps
                    $newElements.find("div span a#streetView").click(function(event) {
                        event.preventDefault();
                        geoLocate($(this), $('#myModal'));
                    });
                    $newElements.find("div span a#favourite").click(function(event) {
                        event.preventDefault();
                    });

                    $('#loadingWrapper').hide();
                  });

                  $photos_container.append($newElements);

                  setup_lightbox();  

                  return false;
                }
              );

              // unbind normal behavior. needs to occur after normal infinite scroll setup.
              // $(window).unbind('.infscr');

              // cf. http://stackoverflow.com/questions/10762656/infinite-scroll-manual-trigger
              $("a#start, a#next").click(function(){
                $photos_container.infinitescroll('retrieve');
                return false;
              });

              $photos_container.infinitescroll('resume');
            }

          }).fail(function(jqXHR, textStatus, errorThrown){
              console.log(textStatus + ' ' + errorThrown);
          }).always(function(){
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

    function changeTooltipColorTo(color) {
        $('.tooltip-inner').css('background-color', color)
        $('.tooltip.top .tooltip-arrow').css('border-top-color', color);
        $('.tooltip.right .tooltip-arrow').css('border-right-color', color);
        $('.tooltip.left .tooltip-arrow').css('border-left-color', color);
        $('.tooltip.bottom .tooltip-arrow').css('border-bottom-color', color);
    }

    $search_tooltip = $("a[data-toggle=tooltip]");
    $search_tooltip.tooltip().hover(function() {changeTooltipColorTo('#4682b4')}); /* steel blue http://en.wikipedia.org/wiki/Steel_blue */

    // -------------------------------------------------------------------
    // districts
    var districts = [
      /* "", */
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
      /* "", */
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

      var has_address = false;
      // is there enough address to show link to google map ?
      if (districts[photo.address.district] && photo.address.street) {
        has_address = true;
      }
        
      // ask handlebars to render the template
      return handlebars_template(
        {
          photo               : photo,
          didascalie          : dida,
          number              : photo.address.number?photo.address.number:'', 
          random_width_class  : get_random_width_class(), 
          district            : districts[photo.address.district],
          noaddress           : !has_address,
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
          $didascalieBase.remove('.iconLinks');
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

    /*
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
    */

    function geoLocate($theBox, $myModal) {
      if (typeof google.maps.Geocoder == undefined) {
        return;
      }
      var geocoder = new google.maps.Geocoder();
      geocoder.geocode( { 'address': $theBox.attr('data-address') }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {

          /*
          var remote = buildGoogleMapsStreeViewURL(address, results[0].geometry.location);
          console.log(remote);
          */
          
          var lat = $theBox.attr('data-position-lat');
          var lng = $theBox.attr('data-position-lng');
          var lat_lng;
          if (!lat || !lng) {
            lat_lng = new google.maps.LatLng(results[0].geometry.location.jb, results[0].geometry.location.kb); 
            $theBox.attr('data-position-lat', lat_lng.lat()); 
            $theBox.attr('data-position-lng', lat_lng.lng()); 
          } else {
            lat_lng = new google.maps.LatLng(parseFloat(lat), parseFloat(lng)); 
          }

          var $modalBody = $myModal.find('.modal-body');
          var $mapCanvas = $myModal.find('#map-canvas');
          var $pano      = $myModal.find('#pano');
          var $legacy    = $myModal.find('.permanentBox');

          var windowWidth  = $(window).width();
          var windowHeight = $(window).height();
          var width = Math.round(0.9*windowWidth);
          var height = Math.round(0.8*windowHeight);
          var halfWidth = Math.round(width/2);

          $legacy.hide();
          var legacyImagePath = $theBox.parent().parent().parent().parent().children('a').attr('href');
          $legacy.children('img').attr('src', legacyImagePath);
          var preloader = new Image();
          preloader.onload = function(){
            var imgWidth  = preloader.width/2;
            var imgHeight = preloader.height/2;
            $legacy.children('img').css(
              {
                width  : imgWidth+'px',
                height : imgHeight+'px', 
              }
            );
            $legacy.css(
              {
                left   : halfWidth - (imgWidth/2) + 5 + 5, /* margin 5, padding 5 */
                bottom : 0,
              }
            );
            $legacy.show();
          }
          preloader.src = legacyImagePath;

          $modalBody.css(
            {
              'max-height' : '100%',
              width      : width+'px', 
              height     : height+'px'
            }
          );
          $mapCanvas.css(
            {
              width     : (halfWidth)+'px', 
              height    : (height-15)+'px'
            }
          );
          $pano.css(
            {
              width     : (halfWidth)+'px', 
              height    : (height-15)+'px'
            }
          );

          $myModal.modal().css({
            'margin-left': function () {
              return -($(this).width() / 2);
            }
          }).show();

          var map = new google.maps.Map(
            $mapCanvas.get(0), 
            {
              center : lat_lng,
              zoom : 18,
              mapTypeId : google.maps.MapTypeId.ROADMAP,
              streetViewControl: true,
            }
          );
          var marker = new google.maps.Marker(
            {
              position: lat_lng,
              map: map,
            }
          ); 

          var povHeading = $theBox.attr('data-pov-heading');
          if (povHeading) {
            povHeading = parseFloat(povHeading); 
          } else {
            povHeading = 0;
          }
          var povPitch   = parseFloat($theBox.attr('data-pov-pitch'));
          if (povPitch) {
            povPitch = parseFloat(povPitch); 
          } else {
            povPitch = 0;
          }
          var zoom       = parseFloat($theBox.attr('data-zoom'));
          if (zoom) {
            zoom = parseFloat(zoom); 
          } else {
            zoom = 0;
          }

          var panorama = new google.maps.StreetViewPanorama(
            $pano.get(0), 
            {
              position: lat_lng,
              pov: {
                heading: povHeading,
                pitch: povPitch,
              },
              zoom: zoom,
              visible: true,
            }
          );

          panorama.setVisible(true);
          map.setStreetView(panorama);

          google.maps.event.addListener(panorama, 'position_changed', function() {
            var position = panorama.getPosition();
            console.log(position);
            marker.setPosition(position);
            $theBox.attr('data-position-lat', position.lat()); 
            $theBox.attr('data-position-lng', position.lng()); 
          });          

          google.maps.event.addListener(panorama, 'pov_changed', function() {
            var pov = panorama.getPov();
            console.log(pov);
            $theBox.attr('data-pov-heading', pov.heading); 
            $theBox.attr('data-pov-pitch', pov.pitch); 
          });          

          google.maps.event.addListener(panorama, 'zoom_changed', function() {
            var zoom = panorama.getZoom();
            console.log(zoom);
            $theBox.attr('data-zoom', zoom); 
          });          

          $myModal.on('hidden', function () {
            $mapCanvas.parent().empty().html('<div id="map-canvas"></div>');
            $pano.parent().empty().html('<div id="pano"></div>');
          });

        } else {
          alert('Street View data not found for this location.');
        }
      });
    }
  });  

  </script>
  <!-- /le javascript -->

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-41203938-1', 'ondemand.com');
  ga('send', 'pageview');
</script>
</body>
</html>

