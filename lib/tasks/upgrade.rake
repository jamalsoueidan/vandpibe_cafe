namespace :upgrade do
	task :rating => [:environment] do 
		Rating.group([:user_id, :location_id]).select("*, CAST( AVG( CAST(rating_value as decimal(8,1)) ) as decimal(8,1) ) as rate").each do |rate|
			Rating.delete_all(:user_id => rate.user_id, :location_id => rate.location_id)
			rating = rate.rate.to_i.round
			if rating == 6 
				rating = 5
			end
			Rating.create(:user_id => rate.user_id, :location_id => rate.location_id, :rating_value => rating, :rating_key => 'location')
		end
	end

	task :location => [:environment] do
		Location.all.each do |location|
			ratings = [0,0,0,0,0]
			location.ratings.each do |rating|
				rate = rating.rating_value.to_i
				ratings[(rate-1)] += 1
			end
			
			left = 0.0
			right = 0.0
			ratings.each_index do |index|
				multiply = index+1
				left += ratings[index] * multiply
				right += ratings[index]
			end

			if left > 0 && right > 0
				p location.name
				p (left / right)
				scoring = score(ratings)
				p scoring
				location.update_attribute(:rating, scoring)
			end
		end

		#@ranked = @unranked.sort_by {|key, value| value}.reverse.each_with_index.to_a
	end

	# http://masanjin.net/blog/how-to-rank-products-based-on-user-input
	def score(votes, prior=[2, 2, 2, 2, 2])
	  posterior = votes.zip(prior).map { |a, b| a + b }
	  sum = posterior.inject { |a, b| a + b }
	  posterior.
	    map.with_index { |v, i| (i + 1) * v }.
	    inject { |a, b| a + b }.
	    to_f / sum
	end
end