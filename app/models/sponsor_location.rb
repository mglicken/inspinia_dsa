class SponsorLocation < ActiveRecord::Base

belongs_to :sponsor
belongs_to :location

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |sponsor_locations|
				csv << sponsor_locations.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "sponsor_id", "location_id"]
		CSV.foreach(file.path,headers: true) do |row|
			sponsor_locations = find_by_id(row["id"]) || new
			
			sponsor_locations.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			sponsor_locations.save
		end
	end	
end