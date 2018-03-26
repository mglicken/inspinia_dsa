class SlideLayoutSlide < ActiveRecord::Base
	belongs_to :slide
	belongs_to :slide_layout

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |slide_layout_slides|
				csv << slide_layout_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "slide_layout_id", "slide_id"]
		CSV.foreach(file.path,headers: true) do |row|
			slide_layout_slides = find_by_id(row["id"]) || new
			
			slide_layout_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			slide_layout_slides.save
		end
	end	
end