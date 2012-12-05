# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('#question_new_comment').live 'ajax:before', (evt, data, status, xhr) ->
		if !$('#comment_body').val()
			alert 'Du mangler indtast noget i beskrivelse feltet'
			$('#comment_body').focus()
			return false
	$('#remove_comment').live 'ajax:success', (evt, data, status, xhr) ->
		current = $(this).closest('li')
		if current.next().attr('class') == 'spacer_template'
			current.next().remove()
		current.fadeOut 'fast', ->
			$(this).remove();
	@