class MpSlide < ActiveRecord::Base
belongs_to :mp
belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |mp_slides|
				csv << mp_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "mp_id", "slide_id", "ppt_address"]
		CSV.foreach(file.path,headers: true) do |row|
			mp_slides = find_by_id(row["id"]) || new
			
			mp_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			mp_slides.save
		end
	end	
end