class NdaSlide < ActiveRecord::Base

belongs_to :nda
belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |nda_slides|
				csv << nda_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "nda_id", "slide_id", "ppt_address"]
		CSV.foreach(file.path,headers: true) do |row|
			nda_slides = find_by_id(row["id"]) || new
			
			nda_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			nda_slides.save
		end
	end	
end