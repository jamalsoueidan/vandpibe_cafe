ActiveAdmin.register Comment do
	index do
		selectable_column
		column :section do |comment|
			div do
				comment.commentable_type
			end
		end
		column :user do |comment|
			div do
				comment.user.nickname
			end
		end
		column :location do |comment|
			div do
				comment.location.name
			end
		end
		column :body
		default_actions
	end
end
