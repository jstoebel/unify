var country,
    state;

var margin = {top: 10, left: 10, bottom: 10, right: 10},
  width = parseInt(d3.select('#map').style('width')) - margin.left - margin.right,
  mapRatio = .5,
  height = width * mapRatio,
  m_width = $("#map").width();

var projection = d3.geo.mercator()
  .scale(150)
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

var validCounties = ['USA']; // TODO this will be replaced with an endpoint

d3.json("/json/countries.topo.json", function(error, us) {
    if (error){
        console.log(error);
    }
    console.log("countries callback!");
// TODO
// hit backend here to find out what countries have projects do all of the following inside callback

g.append("g")
  .attr("id", "countries")
  .selectAll("path")
  .data(topojson.feature(us, us.objects.countries).features)
  .enter()
  .append("path")
  .attr("id", function(d) { return d.id; })
  // style each country conditionally
  .attr('fill', function(d){
    if ( validCounties.indexOf(d.id) !== -1 ){
      return '#2b77f2';
    } else {
      return '#cde'
    }
  })
  .attr("d", path)
  .on("click", country_clicked);

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
    // TODO
    // hit an endpoint to get details on projects in a country. Do all of the following
    // inside the callback

    tooltip.append('h4')
      .text(location.properties.name)

    tooltip.append('span')
      .classed('blurb', true)
      .html('Rem sint tenetur cupiditate aliquam ea ut voluptas voluptatem porro \
        magnam ut corrupti <a href="#"> more </a> ')

    // add the form
    var form = tooltip.append('form')
      .attr('action', '/donate?&authenticity_token=' + AUTH_TOKEN)
      .attr('method', 'post')

    form.append('input')
        .attr('type', 'hidden')
        .attr('name', 'location')
        .attr('value', location.id)

    form.append('input')
        .attr('type', 'submit')
        .attr('value', 'Select')
        .classed('btn btn-primary', true)
        .on("click", trySubmit)

    // add the zoom out button
    form.append('span')
      .text('back')
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
    tooltip.append("span").text("Select a country to begin.")
}

function country_clicked(d) {

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
    d3.json("/json/states_" + d.id.toLowerCase() + ".topo.json", function(error, us) {
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

  // d3.json("cities_" + country_code + ".topo.json", function(error, us) {
  //   g.append("g")
  //     .attr("id", "cities")
  //     .selectAll("path")
  //     .data(topojson.feature(us, us.objects.cities).features.filter(function(d) { return state_name == d.properties.state; }))
  //     .enter()
  //     .append("path")
  //     .attr("id", function(d) { return d.properties.name; })
  //     .attr("class", "city")
  //     .attr("d", path.pointRadius(20 / xyz[2]));
  //
  //   zoom(xyz);
  // });
} else {
  state = null;
  country_clicked(country);
}
}

$(window).resize(function() {
var w = $("#map").width();
svg.attr("width", w);
svg.attr("height", w * height / width);
});

var tooltip = d3.select('#tooltip');
clear_tooltip();
tooltip_reset();
