class School < ActiveRecord::Base
	
	include Importer

  has_many :users, dependent: :destroy
  accepts_nested_attributes_for :users, allow_destroy: true

  validates :name, presence: true, uniqueness: true

  def self.check_filetype(file)
    File.extname(file)
  end

  def self.import(file)

    file_type = check_filetype(file.original_filename)

    case file_type
    when ".json"
      importer = JsonImporter.new(file)
      update_schools_json(importer.generate_array)
    when ".csv"
      importer = CSVImporter.new(file)
      update_schools_csv(importer.generate_array)
    else
      raise Error.new "Unable to import file. File: #{file.inspect}"
    end

  end # end of import function

  def self.find_school(name)
    find_or_create_by!(name: name)
  end

  def self.populate_users(input_array, school, user_type)
    input_array.each do |user|

      # checks to see if user with given last name exists or not
      new_user = school.users.find_or_initialize_by(lastname: user[:lastname]) 
      new_user.attributes = { firstname: user[:firstname], user_type: user_type } 
      new_user.save!
      
      #school.users.new(user.merge!(user_type: user_type))
    
    end
  end

  def self.update_schools_json(schools_array)

  	schools_array.each do |record|

  		school = find_school(record[:name])

    	populate_users(record[:teachers], school, type = "Teacher")
      populate_users(record[:students], school, type = "Student")

    	school.save!
  	end
  end

  def self.update_schools_csv(schools_array)

  	schools_array.each do |record|

  		school = find_school(record[:school])

			user_attributes = record.slice(:lastname, :firstname)
			user_type = {:user_type => record[:type]} # accounts for differnece in labelling of user type in csv import
			user_attributes.merge!(user_type) # adds user_type hash to attributes 

      user = school.users.find_or_initialize_by(record.slice(:lastname)) 
      user.attributes = user_attributes
      user.save!
			school.save!
  	end
  end

  # CSV download to match test csv import file 
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["lastname", "firstname", "type", "school"] 
      all.each do |school|
        school.users.each do |user|
          csv << [user.lastname, user.firstname, user.user_type, user.school.name]       
        end
      end  
    end
  end

end # end of class
