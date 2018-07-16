class MarketStudySlide < ActiveRecord::Base
belongs_to :market_study
belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |market_study_slides|
				csv << market_study_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "market_study_id", "slide_id"]
		CSV.foreach(file.path,headers: true) do |row|
			market_study_slides = find_by_id(row["id"]) || new
			
			market_study_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			market_study_slides.save
		end
	end	
end