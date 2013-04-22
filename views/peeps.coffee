$ ->
	console.log('woah')
	peeps_list()
	home_mountain_typeahead()
	$('#home_mountain_form').live('submit', find_peeps)
	#$('#clear_home_mountain_link').live('click', clear_home_mountain)
	

home_mountain_typeahead = () ->
	options = 
		source: home_mountains
	$('#home_mountain_typeahead').typeahead(options)		
	

peeps_list = () ->
	$.getJSON('/peeps/list', got_peeps)


got_peeps = (response) ->
	$('#main').empty()
	
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

find_peeps = (e) ->
	e.preventDefault()
	
	form = e.currentTarget
	home_mountain = $('#home_mountain_typeahead').val()

	url = form.action + home_mountain

	home_mountain = home_mountain.replace(' ', '_').toLowerCase()
	home_mountain = home_mountain.replace(/[^a-z0-9_]/g, '')
	log home_mountain
	


	#home_mountain = home_mountain.replace / /, ''
		#.replace(/[^a-z0-9_]/, '') 
	$.getJSON(url, got_peeps)

# clear_home_mountain = (e) ->
# 	log 'kkkk'
# 	e.preventDefault()
# 	$('#home_mountain_typeahead').val('')

log = (m) ->
	console.log(m)