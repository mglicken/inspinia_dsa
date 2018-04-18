class NbpTag < ActiveRecord::Base
belongs_to :tag
belongs_to :nbp

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |nbp_tags|
				csv << nbp_tags.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "tag_id", "nbp_id"]
		CSV.foreach(file.path,headers: true) do |row|
			nbp_tags = find_by_id(row["id"]) || new
			
			nbp_tags.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			nbp_tags.save
		end
	end	
end