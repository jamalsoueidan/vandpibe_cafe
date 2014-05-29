#= require modernizr
#= require jquery
#= require jquery.offcanvas
#= require jquery.raty.min

$.fn.raty.defaults.path = "http://assets.vandpibecafe.dk/assets/raty"
$.fn.raty.defaults.readOnly = true
$.fn.raty.defaults.halfShow = true
$.fn.raty.defaults.number = 5

String::all_capitalize = ->
  @replace /(^|\s)([a-z])/g, (m, p1, p2) ->
    p1 + p2.toUpperCase()

String::capitalize = ->
  @charAt(0).toUpperCase() + @slice(1)

jQuery(document).ready ($) ->
  $("html").offcanvas hasSidebarRight: true
  return
