class QofeSlide < ActiveRecord::Base
belongs_to :qofe
belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |qofe_slides|
				csv << qofe_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "qofe_id", "slide_id"]
		CSV.foreach(file.path,headers: true) do |row|
			qofe_slides = find_by_id(row["id"]) || new
			
			qofe_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			qofe_slides.save
		end
	end	
end