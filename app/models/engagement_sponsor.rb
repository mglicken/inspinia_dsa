class EngagementSponsor < ActiveRecord::Base
validates_uniqueness_of :sponsor_id, :scope => :deal_id

belongs_to :deal
belongs_to :sponsor

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |engagement_sponsors|
				csv << engagement_sponsors.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "deal_id", "sponsor_id"]
		CSV.foreach(file.path,headers: true) do |row|
			engagement_sponsors = find_by_id(row["id"]) || new
			
			engagement_sponsors.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			engagement_sponsors.save
		end
	end	
end