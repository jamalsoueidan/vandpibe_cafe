// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

Google = {};

$.fn.raty.defaults.path = '/assets/';

function init_map(city_id, location_id) {
	$.getJSON("/get_json.json?city_id=" + city_id + "&location_id=" + location_id, function(data) {

		if ( $('#map').length == 0 ) return

		latitude = 56.34
		longitude = 11.3
		zoom = 7
		
		if (data.length == 1) {
			latitude = data[0]['latitude']
			longitude = data[0]['longitude']
			zoom = 17
		}
		
		var mapOptions = {
			center: new google.maps.LatLng(latitude, longitude),
			zoom: zoom,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};

		Google.map = new google.maps.Map(document.getElementById("map"), mapOptions);
		
		$.each(data, function(key, location) {
			marker = new google.maps.Marker({
				position: new google.maps.LatLng(location['latitude'], location['longitude']),
				map: Google.map,
				title: location['name'],
				icon: new google.maps.MarkerImage('http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=' + location['id'] + '|' + location['city']['color'], new google.maps.Size(28, 48))
			});
	  	});
	});
}