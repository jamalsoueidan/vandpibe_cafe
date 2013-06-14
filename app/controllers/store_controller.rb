class StoreController < ApplicationController
	def index
		@products = Product.all
	end

	def add_to_cart
		product = Product.find(params[:product][:id])
		render :json => product.to_json
	end
end
