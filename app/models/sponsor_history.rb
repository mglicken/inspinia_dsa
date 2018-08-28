class SponsorHistory < ActiveRecord::Base
	belongs_to :person
	belongs_to :sponsor
	belongs_to :role

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |sponsor_histories|
				csv << sponsor_histories.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "sponsor_id", "location_id", "person_id", "role_id","current","start_year","end_year"]
		CSV.foreach(file.path,headers: true) do |row|
			sponsor_histories = find_by_id(row["id"]) || new
			
			sponsor_histories.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			sponsor_histories.save
		end
	end	
end