class TeaserCompany < ActiveRecord::Base
validates_uniqueness_of :teaser_id, :scope => :company_id
belongs_to :teaser
belongs_to :company
belongs_to :nda

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |teaser_companies|
				csv << teaser_companies.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "teaser_id", "company_id", "nda_id"]
		CSV.foreach(file.path,headers: true) do |row|
			teaser_companies = find_by_id(row["id"]) || new
			
			teaser_companies.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			teaser_companies.save
		end
	end	

end