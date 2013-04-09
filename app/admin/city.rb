ActiveAdmin.register City do
  index do	
  	column :name
  	column :color do |city|
  		div :style => "background-color:#" + city.color do
  			city.color
  		end
  	end
  	default_actions
  end
end
