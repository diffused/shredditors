map = null
marker = null

$ ->
	console.log  "hi"
	
	$('#save_map_pin').live('click', save_map_pin)
	
	init_maps()

init_maps = () ->	
	options = 
		zoom: 2
		scrollwheel: false
		center: new google.maps.LatLng 0,0
		mapTypeId: google.maps.MapTypeId.ROADMAP	

	map_canvas = document.getElementById "map_canvas"

	map = new google.maps.Map map_canvas, options

	#markers = thing(map)

	#for marker in markers
	#	marker.setMap map

	google.maps.event.addListener(map, 'click', (e) ->
		log('click! ' + e.latLng)
		if marker
			marker.setMap null
			marker = null

		marker = createMarker(e.latLng, "name", "Location" + e.latLng)
	)

	# marker.setMap map

	# info_window = new google.maps.InfoWindow
	# 	content: "why hello there"

	# google.maps.event.addListener marker, 'click', ->
	# 	info_window.open map, marker
 
createMarker = (latLng, name, html) ->
	marker_options =
		position: latLng
		map: map
		zIndex: Math.round(latLng.lat() * - 100000) << 5
	
	marker = new google.maps.Marker(
		marker_options
	)

	google.maps.event.trigger(marker, 'click')
	return marker


save_map_pin = (e) ->
	log e
	pos = marker.getPosition()
	log(pos.lat() + "," + pos.lng())

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