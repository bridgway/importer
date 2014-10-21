class School < ActiveRecord::Base
	
	include Importer

  has_many :users, dependent: :destroy
  accepts_nested_attributes_for :users, allow_destroy: true

  validates :name, presence: true, uniqueness: true

	def self.import(file, content_type)

	  case content_type
		when "application/json", "application/octet-stream"
			importer = JsonImporter.new(file)
			schools_array = importer.generate_array
			update_schools_json(schools_array)
		when "text/csv", "application/vnd.ms-excel"
			importer = CSVImporter.new(file)
			schools_array = importer.generate_array
			update_schools_csv(schools_array)
		else
			raise "Unable to import file. File: #{file.inspect}"
		end

  end # end of import function

  def self.update_schools_json(schools_array)
  	schools_array.each do |record|
  		school = find_or_create_by!(name: record[:name])

    	teachers = record[:teachers]
    	teachers.each do |teacher|
    		school.users.new(teacher.merge!(user_type: "Teacher"))
    	end

    	students = record[:students]
    	students.each do |student|
    		school.users.new(student.merge!(user_type: "Student"))
    	end
    	school.save!
  	end
  end

  def self.update_schools_csv(schools_array)
  	schools_array.each do |record|

  		school = find_or_create_by!(name: record[:school])

			user_attributes = record.slice(:lastname, :firstname)
			new_hash = {:user_type => record[:type]}
			user_attributes.merge!(new_hash)

			school.users.new(user_attributes)
			school.save!
  	end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |school|
        csv << school.attributes.values_at(*column_names)
      end
    end
  end

end # end of class
