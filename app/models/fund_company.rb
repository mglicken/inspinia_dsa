class FundCompany < ActiveRecord::Base
belongs_to :fund
belongs_to :company

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |fund_companies|
				csv << fund_companies.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "company_id", "fund_id"]
		CSV.foreach(file.path,headers: true) do |row|
			fund_companies = find_by_id(row["id"]) || new
			
			fund_companies.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			fund_companies.save
		end
	end	
end