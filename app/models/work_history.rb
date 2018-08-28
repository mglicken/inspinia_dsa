class WorkHistory < ActiveRecord::Base
	belongs_to :person
	belongs_to :company
	belongs_to :role

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |work_histories|
				csv << work_histories.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "company_id", "location_id", "person_id","role_id","current","start_year","end_year"]
		CSV.foreach(file.path,headers: true) do |row|
			work_histories = find_by_id(row["id"]) || new
			
			work_histories.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			work_histories.save
		end
	end	
end