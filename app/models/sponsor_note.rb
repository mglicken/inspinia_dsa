class SponsorNote < ActiveRecord::Base
validates_uniqueness_of :sponsor_id, scope: :note_id

belongs_to :sponsor
belongs_to :note

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |sponsor_notes|
				csv << sponsor_notes.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "sponsor_id", "note_id"]
		CSV.foreach(file.path,headers: true) do |row|
			sponsor_notes = find_by_id(row["id"]) || new
			
			sponsor_notes.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			sponsor_notes.save
		end
	end	
end