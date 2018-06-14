class CipSlide < ActiveRecord::Base

belongs_to :cip
belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |cip_slides|
				csv << cip_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "cip_id", "slide_id", "ppt_address"]
		CSV.foreach(file.path,headers: true) do |row|
			cip_slides = find_by_id(row["id"]) || new
			
			cip_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			cip_slides.save
		end
	end	
end