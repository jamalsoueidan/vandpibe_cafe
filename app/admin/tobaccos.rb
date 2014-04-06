ActiveAdmin.register Tobacco do
	menu :parent => "Countries"
	form do |f|
		f.inputs do
			f.input :name
			f.input :brand
			f.input :locations, :input_html => {:size => 40}
		end
		f.actions
	end
end
