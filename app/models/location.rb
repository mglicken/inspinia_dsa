class Location < ActiveRecord::Base
	validates :name, :presence => true

	geocoded_by :address
	after_validation :geocode

	has_one :company_location, :dependent => :destroy
	has_one :company, :through => :company_location


	def address
	  [street, city, state, country].compact.join(', ')
	end


	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |locations|
				csv << locations.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name", "street", "city", "state", "zip", "country", "phone", "web_address", "owned", "leased"]
		CSV.foreach(file.path,headers: true) do |row|
			locations = find_by_id(row["id"]) || new
			
			locations.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			locations.save
		end
	end	

end