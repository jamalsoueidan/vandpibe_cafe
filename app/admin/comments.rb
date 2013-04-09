ActiveAdmin.register Comment do
  index do      
	selectable_column
	column :location do |comment|
		div do
			comment.location.name
		end
	end
    column :body
    default_actions
  end
end
