class MpCompany < ActiveRecord::Base
validates_uniqueness_of :mp_id, :scope => :company_id
validates :mp_id, :presence => true
validates :company_id, :presence => true
belongs_to :mp
belongs_to :company
belongs_to :loi

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |mp_companies|
				csv << mp_companies.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "mp_id", "company_id", "loi_id", "declined"]
		CSV.foreach(file.path,headers: true) do |row|
			mp_companies = find_by_id(row["id"]) || new
			
			mp_companies.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			mp_companies.save
		end
	end	

end