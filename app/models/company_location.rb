class CompanyLocation < ActiveRecord::Base

belongs_to :company
belongs_to :location

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |company_locations|
				csv << company_locations.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "company_id", "location_id"]
		CSV.foreach(file.path,headers: true) do |row|
			company_locations = find_by_id(row["id"]) || new
			
			company_locations.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			company_locations.save
		end
	end	
end