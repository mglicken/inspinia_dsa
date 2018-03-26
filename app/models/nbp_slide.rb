class NbpSlide < ActiveRecord::Base
belongs_to :nbp
belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |nbp_slides|
				csv << nbp_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "nbp_id", "slide_id"]
		CSV.foreach(file.path,headers: true) do |row|
			nbp_slides = find_by_id(row["id"]) || new
			
			nbp_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			nbp_slides.save
		end
	end	
end