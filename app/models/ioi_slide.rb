class IoiSlide < ActiveRecord::Base

belongs_to :ioi
belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |ioi_slides|
				csv << ioi_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "ioi_id", "slide_id", "ppt_address"]
		CSV.foreach(file.path,headers: true) do |row|
			ioi_slides = find_by_id(row["id"]) || new
			
			ioi_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			ioi_slides.save
		end
	end	
end