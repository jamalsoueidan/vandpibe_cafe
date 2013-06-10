ActiveAdmin.register User do
	menu :priority => 1

	index do       
	    column :id
	    column :image do |user|
	    	div do
	    		image_tag(user.avatar_url)
	    	end
	    end
	    column :nickname
	    column :fullname
	    column :email
	    column :created_date
  	end
end                                   
