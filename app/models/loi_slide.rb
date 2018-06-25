class LoiSlide < ActiveRecord::Base

belongs_to :loi
belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |loi_slides|
				csv << loi_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "loi_id", "slide_id", "ppt_address"]
		CSV.foreach(file.path,headers: true) do |row|
			loi_slides = find_by_id(row["id"]) || new
			
			loi_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			loi_slides.save
		end
	end	
end