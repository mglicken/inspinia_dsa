class Person < ActiveRecord::Base
	has_many :deal_people, :dependent => :destroy
	has_many :deals, :through => :deal_people
	has_many :work_histories, :dependent => :destroy
	has_many :companies, :through => :work_histories
	belongs_to :role
	has_many :sponsor_histories, :dependent => :destroy
	has_many :companies, :through => :sponsor_histories
	has_many :person_notes, :dependent => :destroy
	has_many :notes, :through => :person_notes
	has_many :users

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |people|
				csv << people.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "first_name","last_name","name","backwards_name","address", "city", "state", "zip", "phone", "cell","email_address","image_url", "employee","role_id", "linkedin_url"]
		CSV.foreach(file.path,headers: true) do |row|
			people = find_by_id(row["id"]) || new
			people.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			people.save
		end
	end	

end