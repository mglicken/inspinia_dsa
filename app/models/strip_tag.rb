class StripTag < ActiveRecord::Base
belongs_to :tag
belongs_to :nbp_company

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |strip_tags|
				csv << strip_tags.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "tag_id", "nbp_company_id", "value"]
		CSV.foreach(file.path,headers: true) do |row|
			strip_tags = find_by_id(row["id"]) || new
			
			strip_tags.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			strip_tags.save
		end
	end	
end