var BREWERIES = {};

BREWERIES.show = function(){
    $("#brewerytable tr:gt(0)").remove();

    var table = $("#brewerytable");

    $.each(BREWERIES.list, function (index, beer) {
        var active = beer['active'] ? 'yes' : 'no';
        table.append('<tr>'
            +'<td>'+beer['name']+'</td>'
            +'<td>'+beer['year']+'</td>'
            +'<td>'+beer['beers']+'</td>'
            +'<td>'+active+'</td>'
            +'</tr>');
    });
};

BREWERIES.sort_by_name = function(){
    BREWERIES.list.sort( function(a,b){
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BREWERIES.sort_by_year = function(){
    BREWERIES.list.sort( function(a,b){
        return a.year - b.year;
    });
};

BREWERIES.sort_by_beers = function(){
    BREWERIES.list.sort( function(a,b){
        return b.beers - a.beers;
    });
};

$(document).ready(function () {
  if ( $("#brewerytable").length>0 ) {    
    $("#name").click(function (e) {
        BREWERIES.sort_by_name();
        BREWERIES.show();
        e.preventDefault();
    });

    $("#year").click(function (e) {
        BREWERIES.sort_by_year(); 
        BREWERIES.show()
        e.preventDefault();
    });

    $("#number").click(function (e) {
        BREWERIES.sort_by_beers(); 
        BREWERIES.show()
        e.preventDefault();
    });

    $.getJSON('breweries.json', function (breweries) {
      BREWERIES.list = breweries
      BREWERIES.show()
    });
  }
});