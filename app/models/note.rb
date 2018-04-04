class Note < ActiveRecord::Base

has_many :person_notes, :dependent => :destroy
has_many :people, :through => :person_notes
has_many :sponsor_notes, :dependent => :destroy
has_many :sponsors, :through => :sponsor_notes
has_many :company_notes, :dependent => :destroy
has_many :companies, :through => :company_notes

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |notes|
				csv << notes.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "title", "detail", "date", "link"]
		CSV.foreach(file.path,headers: true) do |row|
			notes = find_by_id(row["id"]) || new
			
			notes.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			notes.save
		end
	end	
end