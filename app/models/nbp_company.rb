class NbpCompany < ActiveRecord::Base
validates_uniqueness_of :bucket_id, :scope => :company_id
belongs_to :nbp
belongs_to :company

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |nbp_companies|
				csv << nbp_companies.attributes.values_at(*column_names)
			end
		end
	end

	def self.import(file)
		allowed_attributes = [  "nbp_id", "company_id", "tier_id","bucket_id"]
		CSV.foreach(file.path,headers: true) do |row|
			nbp_companies = find_by_id(row["id"]) || new
			
			nbp_companies.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			nbp_companies.save
		end
	end	

end