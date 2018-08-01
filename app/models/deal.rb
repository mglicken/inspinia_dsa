class Deal < ActiveRecord::Base

validates :name, :presence => true, :uniqueness => true
validates :company, :presence => true


belongs_to 	:company
belongs_to  :deal_stage
belongs_to 	:deal_type
has_many	:teaser, :dependent => :destroy
has_many 	:teaser_slides, :through => :teaser
has_many 	:slides, :through => :teaser_slides
has_many	:case_studies, :dependent => :destroy
has_many 	:case_study_slides, :through => :case_studies
has_many 	:slides, :through => :case_study_slides
has_many	:nbps, :dependent => :destroy
has_many 	:nbp_slides, :through => :nbps
has_many 	:slides, :through => :nbp_slides
has_many 	:cips, :dependent => :destroy
has_many 	:cip_slides, :through => :cips
has_many 	:slides, :through => :cip_slides
has_many 	:mps, :dependent => :destroy
has_many 	:mp_slides, :through => :mps
has_many 	:slides, :through => :mp_slides
has_many 	:deal_people, :dependent => :destroy
has_many 	:people, :through => :deal_people
has_many 	:diligence_advisors, :dependent => :destroy
has_many 	:people, :through => :diligence_advisors
has_many	:market_studies, :dependent => :destroy
has_many 	:market_study_slides, :through => :market_studies
has_many	:qoves, :dependent => :destroy
has_many 	:qofe_slides, :through => :qoves
has_many 	:engagement_companies, :dependent => :destroy
has_many 	:engagement_sponsors, :dependent => :destroy

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |deals|
				csv << deals.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name", "project_alias", "project_code", "company_id", "deal_stage_id", "deal_type_id"]
		CSV.foreach(file.path,headers: true) do |row|
			deals = find_by_id(row["id"]) || new
			
			deals.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			deals.save
		end
	end	

end