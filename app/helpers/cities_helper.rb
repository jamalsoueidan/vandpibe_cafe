module CitiesHelper
	def description(location)
		if location.description.nil? || location.description == ""
			return 'Denne Vandpibe Cafe mangler beskrivelse.'
		else
			return truncate(location.description, :length => 80)
		end
	end
end
