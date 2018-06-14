class TeaserSlide < ActiveRecord::Base
belongs_to :teaser
belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |teaser_slides|
				csv << teaser_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "teaser_id", "slide_id", "ppt_address"]
		CSV.foreach(file.path,headers: true) do |row|
			teaser_slides = find_by_id(row["id"]) || new
			
			teaser_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			teaser_slides.save
		end
	end	

end