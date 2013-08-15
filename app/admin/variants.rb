ActiveAdmin.register Variant do
	menu :parent => "Products"

	controller do
		def permitted_params
			params.permit(:variant => [:name])
		end
	end
end
