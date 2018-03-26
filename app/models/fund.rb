class Fund < ActiveRecord::Base
belongs_to :sponsor
has_many :fund_companies, :dependent => :destroy
has_many :companies, :through => :fund_companies

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |funds|
				csv << funds.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name", "sponsor_id", "size", "open", "open_year", "close_year", "link"]
		CSV.foreach(file.path,headers: true) do |row|
			funds = find_by_id(row["id"]) || new
			
			funds.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			funds.save
		end
	end	
end