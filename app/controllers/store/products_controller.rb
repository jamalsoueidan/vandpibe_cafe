class Store::ProductsController < ApplicationController
	def show
		@product = Product.find(params[:id])
	end
end
