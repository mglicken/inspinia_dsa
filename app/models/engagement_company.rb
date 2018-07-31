class EngagementCompany < ActiveRecord::Base
validates_uniqueness_of :company_id, :scope => :deal_id

belongs_to :deal
belongs_to :company

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |engagement_companies|
				csv << engagement_companies.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "deal_id", "company_id"]
		CSV.foreach(file.path,headers: true) do |row|
			engagement_companies = find_by_id(row["id"]) || new
			
			engagement_companies.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			engagement_companies.save
		end
	end	
end