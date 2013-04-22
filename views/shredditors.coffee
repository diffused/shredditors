$ ->
	console.log('woah')
	blah()


blah = () ->
	console.log('blah!')

	$.getJSON('/peeps/list', got_peeps)


got_peeps = (response) ->
	log(response)
	$('#tiles').empty()

	
	peeps = 
		peeps: response
	
	$('#main').append(ich.peeps_list_template(peeps))


	options = 
		autoResize: true,
		container: $('#main'),
		offset: 10,
		itemWidth: 200

	dfd = $('#tiles li img').imagesLoaded()

	dfd.always(()->
		$('#tiles li').wookmark(options)
	)

log = (m) ->
	console.log(m)