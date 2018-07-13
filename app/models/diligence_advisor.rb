class DiligenceAdvisor < ActiveRecord::Base
validates :advisor_type, :presence => true
validates :company, :presence => true
validates :person, :presence => true

belongs_to :advisor_type
belongs_to :company
belongs_to :person
belongs_to :deal
belongs_to :nda
belongs_to :mp_company
belongs_to :mp_sponsor

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |diligence_advisors|
				csv << diligence_advisors.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "advisor_type_id", "person_id","company_id","deal_id","nda_id","mp_company_id","mp_sponsor_id"]
		CSV.foreach(file.path,headers: true) do |row|
			diligence_advisors = find_by_id(row["id"]) || new
			
			diligence_advisors.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			diligence_advisors.save
		end
	end	
end