module Importer

	# Extends CSV stlib to add custom converter ensuring any blank strings to nil 
	CSV::Converters[:blank_to_nil] = lambda do |field|
  	field && field.empty? ? nil : field
	end

	class JsonImporter

		def initialize(file)
			@file = file
		end

		def generate_array
	    json_data = File.read(@file.path)
	    parsed_data = JSON.parse(json_data, symbolize_names: true)
    end # end of generate_array

	end # end JSONImporter class

	class CSVImporter

		def initialize(file)
			@file = file
		end

		def generate_array
			schools_array = []
	    CSV.foreach(@file.path, headers: true, header_converters: :symbol, converters: [:all, :blank_to_nil]) do |row|
	  		schools_array << row.to_hash
	  	end
	  	return schools_array
    end # end of generate_array

	end # end CSVImporter class

end # end module