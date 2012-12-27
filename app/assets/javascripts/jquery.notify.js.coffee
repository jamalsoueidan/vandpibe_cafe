# http://msdn.microsoft.com/en-us/magazine/ff608209.aspx
$.notify = (element, options) ->
  this.options = {};
  $this = this

  this.init = (element, options) ->
    this.options = $.extend({}, $.notify.defaultOptions, options);
    this.setPosition()
    this.playAnimate();
    this.bindEvents();
    return

  this.setPosition = ->
    # position element at the bottom of the page
    $(element).css('top', this.elementPositionHeight())

    position = -$(element).width() - this.options.padding

    if this.isPositionRight()
      $(element).css('right', position);

    if this.isPositionLeft()
      $(element).css('left', position);

  this.playAnimate = ->
    $(element).delay(this.options.animateTimer)

    if this.isPositionRight()
      $(element).animate( right:10, this.options.sliderTimer );

    if this.isPositionLeft()
      $(element).animate( left:10, this.options.sliderTimer );

  this.scrollPositionHeight = ->
    $(window).scrollTop() + $(window).height()

  this.elementPositionHeight = ->
    this.scrollPositionHeight() - $(element).outerHeight() - (this.options.padding/2)

  this.isPositionLeft = ->
    this.options.position == 'bottomLeft'

  this.isPositionRight = ->
    this.options.position == 'bottomRight'

  this.scroll = ->
    if $(window).scrollTop() > 0
      if $this.scrollPositionHeight() < $(document).height()
        $(element).css('top', $this.elementPositionHeight())

  this.bindEvents = ->
    $(window).bind('scroll', this.scroll);

  this.init(element, options)
  return

$.notify.defaultOptions =
  animateTimer: 1000,
  sliderTimer: 1000,
  position: 'bottomRight',
  padding: 20

$.fn.notify = (options)->
  this.each ->
    new $.notify($(this), options)
    return
