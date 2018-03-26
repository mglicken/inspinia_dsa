class Sponsor < ActiveRecord::Base
has_many :funds, :dependent => :destroy
has_many :nbp_sponsors, :dependent => :destroy
has_many :fund_companies, :through => :funds
has_many :companies, :through => :fund_companies
has_many :sponsor_histories, :dependent => :destroy
has_many :people, :through => :sponsor_histories
has_many :sponsor_notes, :dependent => :destroy
has_many :notes, :through => :sponsor_notes

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |sponsors|
				csv << sponsors.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name", "tier", "rco_id", "co_id", "address", "state", "city", "zip", "phone", "web_address", "sponsor_type"]
		CSV.foreach(file.path,headers: true) do |row|
			sponsors = find_by_id(row["id"]) || new
			
			sponsors.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			sponsors.save
		end
	end	

end