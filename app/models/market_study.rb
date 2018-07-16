class MarketStudy < ActiveRecord::Base
validates :name, :presence => true, :uniqueness => true

belongs_to :deal
has_many :market_study_slides, :dependent => :destroy
has_many :slides, :through => :market_study_slides, :dependent => :destroy

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |market_studies|
				csv << market_studies.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name","deal_id", "market_study_date", "image_id"]
		CSV.foreach(file.path,headers: true) do |row|
			market_studies = find_by_id(row["id"]) || new
			
			market_studies.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			market_studies.save
		end
	end	
end