class DealPerson < ActiveRecord::Base
belongs_to :deal
belongs_to :person

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |deal_people|
				csv << deal_people.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "deal_id", "person_id", "role_id"]
		CSV.foreach(file.path,headers: true) do |row|
			deal_people = find_by_id(row["id"]) || new
			
			deal_people.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			deal_people.save
		end
	end	
end