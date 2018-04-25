<%@page contentType="text/html" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="t" uri="http://net.aequologica.neo/jsp/jstl/layout" 
%><t:layout>

<style type="text/css">
.buy {
  cursor: pointer;
  opacity: .2;
}
.pagination-centered {
  text-align: center;
}
.tab-content {
  padding-top: 1em;
}
</style>

  <div id="theContainer" class="row"></div>

  <script id="piece_of_news" type="text/x-handlebars-template"
 ><ul class="nav nav-tabs">
  {{#each items}}
    <li><a href="#iframe{{this.id}}" data-toggle="tab">{{this.t}}</a></li>
  {{/each}}
</ul>

<div id="myTabContent" class="tab-content">
  {{#each items}}
    <div class="tab-pane fade in" id="iframe{{this.id}}">    
      <div class="row">
        <div class="col-lg-12 pagination-centered iframe_container">
      <div style="float:left; visibility: hidden; width:60px; ">
        &nbsp;
      </div>
      <img class="img-thumbnail" src="images/{{this.i}}" style="height:600px;"/>
      <div style="float: right;">
        <a href="{{this.f}}" target="_fnac_">
          <img class="buy" src="<c:url value='/assets/images/120px-Fnac.svg.png'/>" style="width:60px; height:auto;"/>
        </a>
        <div style="width:60px; height:auto;  margin: 20px  0 20px 0;"/>
        <a href="{{this.a}}" target="_amazon_">
          <img class="buy" src="<c:url value='/assets/images/amazon.jpg'/>" style="width:60px; height:auto; "/>
        </a>
      </div>
        </div>
      </div>
    </div>
  {{/each}}
</div></script>

</t:layout>

  <script type="text/javascript">
    var items = {
      items : [
          {
            id : "1",
            t : "Les Halles",
            i : "les-halles-couverture-from-powerpoint.jpg",
            f : "http://livre.fnac.com/a5715747/Martha-Carroll-Les-Halles",
            a : "http://www.amazon.fr/dp/2916195467"
          },
          {
            id : "2",
            t : "Îlot Chalon",
            i : "ilot-chalon-from-powerpoint.png",
            f : "http://livre.fnac.com/a5715746/Francis-Campiglia-L-ilot-Chalon-chroniques-d-un-quartier-de-Paris",
            a : "http://www.amazon.fr/dp/2916195424"
          },
          {
            id : "3",
            t : "Gérard Bloncourt",
            i : "paris-de-gerard-bloncourt.jpg",
            f : "http://livre.fnac.com/a3334029/Gerald-Bloncourt-Le-Paris-de-Gerald-Bloncourt",
            a : "http://www.amazon.fr/dp/2916195351"
          },
          {
            id : "4",
            t : "Piéton du 11ème",
            i : "le-pieton-du-11eme.jpg",
            f : "http://livre.fnac.com/a2990051/Gerard-Lavalette-Le-pieton-du-11eme",
            a : "http://www.amazon.fr/dp/2916195343"
          },
          {
            id : "5",
            t : "Mémoire de zinc",
            i : "memoire-de-zinc.jpg",
            f : "http://livre.fnac.com/a5085718/Gerard-Lavalette-Memoire-de-zinc",
            a : "http://www.amazon.fr/dp/2916195459"
          },
          {
            id : "6",
            t : "Paris Bohème",
            i : "paris-boheme.jpg",
            f : "http://livre.fnac.com/a3897287/J-Jehan-Paris-boheme-1960",
            a : "http://www.amazon.fr/dp/2916195394"
          },
          {
            id : "7",
            t : "Claude Vénézia",
            i : "paris-de-claude-venezia.jpg",
            f : "http://livre.fnac.com/a4049701/Leon-Claude-Venezia-Le-Paris-de-Leon-Claude-Venezia",
            a : "http://www.amazon.fr/dp/2916195408"
          },
          {
            id : "8",
            t : "Mémoires des rues",
            i : "memoires-des-rues.jpg",
            f : "http://recherche.fnac.com/Search/SearchResult.aspx?SCat=2%211&Search=memoires+des+rues+parimagine&sft=1&submitbtn=OK",
            a : "http://www.amazon.fr/s/ref=nb_sb_noss?__mk_fr_FR=%C3%85M%C3%85Z%C3%95%C3%91&url=search-alias%3Dstripbooks&field-keywords=memoires+des+rues+parimagine&rh=n%3A301061%2Ck%3Amemoires+des+rues+parimagine"
          } ]
    };
    
    $(document).ready(function() {
    
      var source = $("#piece_of_news").html();
      var template = Handlebars.compile(source);
    
      $('#theContainer').html(template(items));
      $('#theContainer ul li:first-child').addClass('active');
      $('#theContainer div div:first-child').addClass('active');
    
      $(".buy").hover(function() {
        $(this).stop().animate({
          opacity : 1
        });
      }, function() {
        $(this).stop().animate({
          opacity : 0.2
        });
      });
    
    });
  </script>