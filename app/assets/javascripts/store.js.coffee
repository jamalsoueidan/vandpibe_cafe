# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

(($) ->
	pluginName = "cart"
	defaults = 
		listTagClass: "tbody"
		closeTagClass: "#close"
		plusTagClass: "span.plus"
		minusTagClass: "span.minus"


	#http://jqueryboilerplate.com/
	Plugin = (element, options) ->
		console.log 'done'
		@products = {}
		@element = element
		@options = $.extend({}, defaults, options)
		@_defaults = defaults
		@_name = pluginName
		@init()
		return
	
	Plugin:: =
		init: ->
			console.log 'init cart'
			$('form.product').on 'ajax:success', self: this, this.addProduct

			#this.element.find('#remove')

		addProduct: (evt, data, status, xhr) ->
			self = evt.data.self
			id = data.id
			if self.productExists(id)
				self.products[id].quantity++
			else
				data.quantity = 1
				self.products[id] = data

			self.updateDisplay()
			return

		removeProduct: (evt) ->

			self = evt.data.self

			element = $(evt.target).closest('tr')
			productId = element.attr('product-id')

			delete self.products[productId]
			self.updateDisplay()

		productExists: (id) ->
			( this.products[id] != `undefined` )

		displayElement: ->
			$(this.element).find(this.options['listTagClass'])

		updateDisplay: ->
			this.displayElement().html('')

			self = this
			$.each this.products, ->
				self.displayElement().append(self.template(this))

			this.updateTotalPrice();
			this.showDisplay()

		updateTotalPrice: ->
			self = this
			total = 0
			$.each this.products, ->
				total += this.price * this.quantity

			$(this.element).find('#total-price').html(total + ' kr,-')

		showDisplay: ->
			$(this.element).toggle('show') if $(this.element).is(':hidden')
			$(this.element).find(".close").on('click', self: this, this.close)
			$(this.element).find("span.remove").on('click', self: this, this.removeProduct)
			$(this.element).find("span.plus").on('click', self: this, this.plusProduct)
			$(this.element).find("span.minus").on('click', self: this, this.minusProduct)

		minusProduct: (evt) ->
			self = evt.data.self
			element = $(evt.target).closest('tr')
			productId = element.attr('product-id')
			self.products[productId].quantity-- if self.products[productId].quantity > 1
			element.find('.quantity .value').html(self.products[productId].quantity)
			self.updateTotalPrice()

		plusProduct: (evt) ->
			self = evt.data.self
			element = $(evt.target).closest('tr')
			productId = element.attr('product-id')
			self.products[productId].quantity++
			element.find('.quantity .value').html(self.products[productId].quantity)
			self.updateTotalPrice()

		close: (evt) ->
			self = evt.data.self
			$(self.element).hide()

		template: (data)->
			html = ["<tr id='product_{id}' product-id='{id}'>", 
						"<th class='title'>{title}</th>", 
						"<td class='quantity'>",
							"<span aria-hidden='true' class='icon-plus plus'></span>",
							"<span class='value'>{quantity}</span>",
							"<span aria-hidden='true' class='icon-minus minus'>",
						"</td>", 
						"<td class='price'>{price} kr,-</td>", 
						"<td class='remove'>",
							"<span aria-hidden='true' class='icon-cancel-circle remove'></span>",
						"</td>", 
					"</tr>"].join('\n')

			nano(html, data)


	$.fn[pluginName] = (options) ->
		@each ->
    		$.data this, "plugin_" + pluginName, new Plugin(this, options) unless $.data(this, "plugin_" + pluginName)
    		return

) jQuery


jQuery ->
	$('#cart').cart()