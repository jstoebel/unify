var vpWidth = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
var vpHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) ;

var country,
    state;

var placeLookup = {};
d3.json(base_url + "/places/active", function(error, activePlaces){

  // map country code (ie "USA") to country object from db
  activePlaces.forEach(function(place){
      placeLookup[place.code] = place
  })
})

var margin = {top: 10, left: 10, bottom: 10, right: 10},
  width = parseInt(d3.select('#map').style('width')) - margin.left - margin.right,
  mapRatio = .5,
  height = width * mapRatio,
  m_width = $("#map").width();
console.log(width);
var projection = d3.geo.mercator()
  .scale(width * 0.12195) // the proper ratio between width and scale
  .translate([width / 2, height / 1.5]);

var path = d3.geo.path()
  .projection(projection);

var svg = d3.select("#map").append("svg")
  .attr("preserveAspectRatio", "xMidYMid")
  .attr("viewBox", "0 0 " + width + " " + height)
  .attr("width", m_width)
  .attr("height", m_width * height / width);

svg.append("rect")
  .attr("class", "background")
  .attr("width", width)
  .attr("height", height)
  .on("click", country_clicked);

var g = svg.append("g");

d3.json(base_url + "/json/countries.topo.json", function(error, us) {
    if (error){
        console.log(error);
    }

    d3.json(base_url + "/places/active", function(error, activePlaces){

      // map country code (ie "USA") to country object from db
      activePlaces.forEach(function(place){
          placeLookup[place.code] = place
      })

      if (error){
          console.log(error);
      }

      g.append("g")
      .attr("id", "countries")
      .selectAll("path")
      .data(topojson.feature(us, us.objects.countries).features)
      .enter()
      .append("path")
      .attr("id", function(d) {
          return d.id;
      })
      .attr("blurb", function(d) {
          return d.blurb
      })
      // style each country conditionally
      .attr('fill', function(d){
        // console.log(d);
        if ( placeLookup[d.id] ){
          return '#2b77f2';
        } else {
          return '#cde'
        }
      })
      .attr("d", path)
      .each(function(d){
          var country = d3.select(this);
          if ( placeLookup[d.id] ){
            country.on("click", country_clicked)
          }
      })
    //   .on("click", country_clicked);
    }) // GET places

}); // read countries json

function zoom(xyz) {
g.transition()
  .duration(750)
  .attr("transform", "translate(" + projection.translate() + ")scale(" + xyz[2] + ")translate(-" + xyz[0] + ",-" + xyz[1] + ")")
  .selectAll(["#countries", "#states", "#cities"])
  .style("stroke-width", 1.0 / xyz[2] + "px")
  .selectAll(".city")
  .attr("d", path.pointRadius(20.0 / xyz[2]));

}

function get_xyz(d) {
  var bounds = path.bounds(d);
  var w_scale = (bounds[1][0] - bounds[0][0]) / width;
  var h_scale = (bounds[1][1] - bounds[0][1]) / height;
  var z = .96 / Math.max(w_scale, h_scale);
  var x = (bounds[1][0] + bounds[0][0]) / 2;
  var y = (bounds[1][1] + bounds[0][1]) / 2 + (height / z / 6);
  return [x, y, z];
}

function clear_tooltip(){
tooltip.selectAll("*").remove();
}

function pop_tooltip(location){
    // location: the location object
    clear_tooltip();
    console.log(location);
    tooltip.append('h4')
      .text(location.properties.name)

    tooltip.append('span')
      .classed('blurb', true)
      .text(placeLookup[location.id].blurb)

    // add the place
    var btnDiv = tooltip.append('div')

    btnDiv.append('a')
      .attr('href', base_url + "/donations/new?place="+ location.id)
      .classed('btn btn-primary', true)
      .text('Submit')

    btnDiv.append('span')
      .text('Back')
      .classed('btn btn-default', true)
      .on("click", country_clicked) // same as click no country

}

function trySubmit(e){
    var input = document.getElementById("place-input")
    // var input = d3.select("#place-input")
    console.log(input.value);
}

function tooltip_reset(){
    // resets the tool tip to original instructions
    clear_tooltip();
    tooltip.append('h3').text("Select a country or US State to begin.")
}

function country_clicked(d) {
  console.log("country_clicked");
  console.log(placeLookup);
  if ( d !== undefined ){
    pop_tooltip(d)
  }

  g.selectAll(["#states", "#cities"]).remove();
  state = null;

  if (country) {
    g.selectAll("#" + country.id).style('display', null);
  }

  if (d && country !== d) {
    var xyz = get_xyz(d);
    country = d;
    if (d.id  == 'USA') {
    d3.json(base_url + "/json/states_" + d.id.toLowerCase() + ".topo.json", function(error, us) {
      g.append("g")
        .attr("id", "states")
        .selectAll("path")
        .data(topojson.feature(us, us.objects.states).features)
        .enter()
        .append("path")
        .attr("id", function(d) { return d.id; })
        .attr("class", "active")
        .attr("d", path)
        .on("click", state_clicked);

      zoom(xyz);
      g.selectAll("#" + d.id).style('display', 'none');
    });
    } else {
      zoom(xyz);
    }
  } else {
    // reset to world view
    tooltip_reset();
    var xyz = [width / 2, height / 1.5, 1];
    country = null;
    zoom(xyz);
  }
}

function state_clicked(d) {
    if ( d !== undefined ){
      pop_tooltip(d)
      d3.select("#place-input")
          .attr('value', d.id)
    }

    g.selectAll("#cities").remove();

    if (d && state !== d) {
      var xyz = get_xyz(d);
      var state = d;

      var country_code = state.id.substring(0, 3).toLowerCase();
      var state_name = state.properties.name;

      zoom(xyz)

    } else {
      state = null;
      country_clicked(country);
    }
} // end stateClicked
d3.select(window).on('resize', resize);
function resize() {
  var w = $("#map").width();
  svg.attr("width", w);
  svg.attr("height", w * height / width);

  tooltip.style('min-width', vpWidth*.2+ "px")
      .style('min-height', vpHeight*.15+ "px")

}

// $(window).resize(function() {
//   var w = $("#map").width();
//   svg.attr("width", w);
//   svg.attr("height", w * height / width);
//
//   tooltip.style('min-width', vpWidth*.2+ "px")
//       .style('min-height', vpHeight*.15+ "px")
// });

var tooltip = d3.select('#tooltip');
var prompt = d3.select('#prompt');

tooltip.style('min-width', vpWidth*.2+ "px")
    .style('min-height', vpHeight*.15+ "px")
    // .transform("translate(0px, 50px)")
