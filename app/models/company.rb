class Company < ActiveRecord::Base
	validates :name, :presence => true

	has_many :deals, :dependent => :destroy
	has_many :work_histories, :dependent => :destroy
	has_many :people, :through => :work_histories
	has_one :fund_company
	has_one :fund, :through => :fund_company
	has_many :company_notes, :dependent => :destroy
	has_many :notes, :through => :company_notes
	has_many :nbp_companies, :dependent => :destroy
	has_many :nbps, :through => :nbp_companies
	has_many :teaser_companies, :dependent => :destroy
	has_many :teasers, :through => :teaser_companies
	has_many :cip_companies, :dependent => :destroy
	has_many :cips, :through => :cip_companies
	has_many :mp_companies, :dependent => :destroy
	has_many :mps, :through => :mp_companies
	has_many :company_follows, :dependent => :destroy
	has_many :company_locations, :dependent => :destroy
	has_many :locations, :through => :company_locations

	has_many :subsidiary_parents, class_name: "Subsidiary", foreign_key: "child_id", dependent: :destroy
	has_many :subsidiary_children, class_name: "Subsidiary", foreign_key: "parent_id", dependent: :destroy

	has_many :children, through: :subsidiary_children, foreign_key: "child_id"
	has_many :parents, through: :subsidiary_parents, foreign_key: "parent_id"



	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |companies|
				csv << companies.attributes.values_at(*column_names)
			end
		end
	end
	def self.top_parent
		self.parents.each do |parent|
			top_parent = self
		end
		return top_parent
	end
	def self.import(file)
		allowed_attributes = [ "name", "revenue", "ebitda", "address", "city", "state", "zip", "phone", "web_address","linkedin_url"]
		CSV.foreach(file.path,headers: true) do |row|
			companies = find_by_id(row["id"]) || new
			
			companies.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			companies.save
		end
	end	

end