class CipCompany < ActiveRecord::Base
validates_uniqueness_of :cip_id, :scope => :company_id
belongs_to :cip
belongs_to :company
belongs_to :ioi

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |cip_companies|
				csv << cip_companies.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "cip_id", "company_id", "ioi_id", "declined"]
		CSV.foreach(file.path,headers: true) do |row|
			cip_companies = find_by_id(row["id"]) || new
			
			cip_companies.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			cip_companies.save
		end
	end	

end