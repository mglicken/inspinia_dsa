class SlideTag < ActiveRecord::Base
belongs_to :tag
belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |slide_tags|
				csv << slide_tags.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "tag_id", "slide_id"]
		CSV.foreach(file.path,headers: true) do |row|
			slide_tags = find_by_id(row["id"]) || new
			
			slide_tags.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			slide_tags.save
		end
	end	
end