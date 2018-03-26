class CaseStudySlide < ActiveRecord::Base
belongs_to :case_study
belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |case_study_slides|
				csv << case_study_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "case_study_id", "slide_id"]
		CSV.foreach(file.path,headers: true) do |row|
			case_study_slides = find_by_id(row["id"]) || new
			
			case_study_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			case_study_slides.save
		end
	end	
end