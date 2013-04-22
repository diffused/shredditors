$ ->
	console.log  "hi"
	init_maps()

init_maps = () ->
	log "init"
	log "o"
	
	options = 
		zoom: 10
		center: new google.maps.LatLng -32.387, 150.644
		mapTypeId: google.maps.MapTypeId.ROADMAP

	

	map_canvas = document.getElementById "map_canvas"

	map = new google.maps.Map map_canvas, options

	markers = thing(map)

	for marker in markers
		marker.setMap map

	# marker.setMap map

	# info_window = new google.maps.InfoWindow
	# 	content: "why hello there"

	# google.maps.event.addListener marker, 'click', ->
	# 	info_window.open map, marker
 

log = (m) ->
	console.log m 

thing = (map) ->
	markers = []

	markers.push new google.maps.Marker 
		position: new google.maps.LatLng -34.396, 150.644
		map: map
		title: "thingeee"

	markers.push new google.maps.Marker 
		position: new google.maps.LatLng -32.396, 150.644
		map: map
		title: "thingeee"

	return markers