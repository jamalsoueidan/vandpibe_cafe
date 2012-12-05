# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	if $('.star') 
		$('.star').raty({
			path : '/assets/',
			size      : 24,
			mouseover : (score, evt) ->
				target_id = $(this).attr('data-id')
				update_target = $("#" + target_id)
				hints = $(this).attr('hint').split(',')
				target = $('#hint_' + target_id);
				if (score > 0)
					update_target.val(score)
					target.html(hints[score-1]);
				else
					update_target.val(0)
					target.html('')
		});

	$('#location_new_comment').bind 'ajax:before', (evt, data, status, xhr) ->
		if !$('#comment_body').val()
			alert 'Du mangler indtast noget i beskrivelse feltet'
			$('#comment_body').focus()
			return false
		
		