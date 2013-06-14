class StoreController < ApplicationController
	before_filter :set_cart_session

	def index
		@products = Product.all
	end

	def add_to_cart
		product = Product.find(params[:product][:id])
		json = product.to_json(:only => [:id, :title, :price])
		Cart.add(product)
		render :json => json
	end

	def remove_from_cart
		product = Product.find(params[:product][:id])
		Cart.remove(product, params[:product][:quantity].to_i)
		render :nothing => true
	end

	def get_cart
		render :json => Cart.products
	end

	def set_cart_session
		session[:cart] ||= {}
		Cart.products = session[:cart]
	end

	def checkout
		
	end
end


class Cart
	def self.products=(session_cart)
		@session_cart = session_cart
	end

	def self.products
		@session_cart
	end

	def self.add(product)
		if Cart.exists?(product)
			Cart.products[product.id][:quantity] += 1
		else
			new_product = {product.id => {:id => product.id, :title => product.title, :price => product.price, :quantity => 1}}
			Cart.products.merge!(new_product)
		end
	end

	def self.remove(product, quantity)
		if quantity > 0
			Cart.products[product.id][:quantity] = quantity
		else
			Cart.products.delete(product.id)
		end
	end

	def self.exists?(product)
		!Cart.products[product.id].nil?
	end
end