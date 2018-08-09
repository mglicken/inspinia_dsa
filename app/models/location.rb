class Location < ActiveRecord::Base
	validates :name, :presence => true

	has_one :company_location, :dependent => :destroy
	has_one :company, :through => :company_location





	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |locations|
				csv << locations.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name", "address", "city", "state", "zip", "phone", "web_address"]
		CSV.foreach(file.path,headers: true) do |row|
			locations = find_by_id(row["id"]) || new
			
			locations.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			locations.save
		end
	end	

end