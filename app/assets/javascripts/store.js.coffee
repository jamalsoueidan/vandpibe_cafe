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
		@show_container = false
		@element = element
		@options = $.extend({}, defaults, options)
		@_defaults = defaults
		@_name = pluginName
		@init()
		return
	
	Plugin:: =
		init: ->
			console.log 'init cart'
			$('form.product').on 'ajax:success', self: this, this.productComingIn
			
			self = this
			$.post this.options['getDataURL'], (data) ->
				$.each data, ->
					self.addProduct(this)

				self.show_container = true

		productComingIn: (evt, data, status, xhr) ->
			self = evt.data.self
			self.addProduct(data)
			
		addProduct: (product, ignoreUpdateDisplay) ->
			id = product.id
			if this.productExists(id)
				this.products[id].quantity++
			else
				product.quantity = 1 if product.quantity is `undefined`
				this.products[id] = product

			this.updateDisplay()

		removeProduct: (evt) ->

			self = evt.data.self

			element = $(evt.target).closest('tr')
			productId = element.attr('product-id')
			$.post(self.options['removeFromCartURL'], product: id: productId, quantity: 0)

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
				self.displayElement().prepend(self.template(this))

			this.updateTotalPrice();

			this.showDisplay() if this.show_container

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

			if self.products[productId].quantity > 1
				self.products[productId].quantity-- 
				$.post(self.options['removeFromCartURL'], product: id: productId, quantity: self.products[productId].quantity)
				element.find('.quantity .value').html(self.products[productId].quantity)
				self.updateTotalPrice()

		plusProduct: (evt) ->
			self = evt.data.self
			element = $(evt.target).closest('tr')
			productId = element.attr('product-id')

			self.products[productId].quantity++
			element.find('.quantity .value').html(self.products[productId].quantity)
			$.post(self.options['addToCartURL'], product: id: productId, quantity: self.products[productId].quantity)

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