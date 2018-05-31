class CaseStudy < ActiveRecord::Base
validates :name, :presence => true, :uniqueness => true

belongs_to :deal
has_many :case_study_slides, :dependent => :destroy
has_many :slides, :through => :case_study_slides, :dependent => :destroy

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |case_studies|
				csv << case_studies.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "deal_id", "image_id", "ppt_address"]
		CSV.foreach(file.path,headers: true) do |row|
			case_studies = find_by_id(row["id"]) || new
			
			case_studies.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			case_studies.save
		end
	end	
end