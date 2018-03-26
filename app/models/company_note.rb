class CompanyNote < ActiveRecord::Base
validates_uniqueness_of :company_id, scope: :note_id

belongs_to :company
belongs_to :note

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |company_notes|
				csv << company_notes.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "company_id", "note_id"]
		CSV.foreach(file.path,headers: true) do |row|
			company_notes = find_by_id(row["id"]) || new
			
			company_notes.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			company_notes.save
		end
	end	
end