module Importer

	class JsonImporter
		#attr_accessor :file #looks like not needed 

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
	    CSV.foreach(@file.path, headers: true, header_converters: :symbol) do |row|
	  		schools_array << row.to_hash
	  	end
	  	return schools_array
    end # end of generate_array

	end # end CSVImporter class

end # end module