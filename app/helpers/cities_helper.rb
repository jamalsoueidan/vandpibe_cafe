module CitiesHelper
	def description(location)
		if location.description.nil? || location.description == ""
			return 'Denne Vandpibe Cafe mangler beskrivelse.'
		else
			return truncate(location.description, :length => 70)
		end
	end

	def style_city(city, countries)
		countries.each do |c| 
			if c.id == city.country_id
				@country = c 
			end
		end
		return "background: ##{@country.color}"
	end
end
