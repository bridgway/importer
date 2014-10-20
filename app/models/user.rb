class User < ActiveRecord::Base
	belongs_to :school

	validates :firstname, :lastname, :user_type, presence: true 

	def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end
