class PersonNote < ActiveRecord::Base
validates_uniqueness_of :person_id, scope: :note_id

belongs_to :person
belongs_to :note

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |person_notes|
				csv << person_notes.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "person_id", "note_id"]
		CSV.foreach(file.path,headers: true) do |row|
			person_notes = find_by_id(row["id"]) || new
			
			person_notes.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			person_notes.save
		end
	end	
end