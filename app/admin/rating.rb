ActiveAdmin.register Rating do
	menu :parent => 'Countries'

	index do
    	column :id
    	column :user do |rating|
			div do
				rating.user.nickname
			end
		end
    	column :rating_key
    	column :rating_value
    	column :created_at
    	default_actions
  	end
end
