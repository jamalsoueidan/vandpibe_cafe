namespace :upgrade do
	task :update_rating => [:environment] do 
		Rating.group([:user_id, :location_id]).select("*, CAST( AVG( CAST(rating_value as decimal(8,1)) ) as decimal(8,1) ) as rate").each do |rate|
			Rating.delete_all(:user_id => rate.user_id, :location_id => rate.location_id)
			Rating.create(:user_id => rate.user_id, :location_id => rate.location_id, :rating_value => rate.rate, :rating_key => 'location')
		end
	end
end