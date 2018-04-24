class NbpSponsor < ActiveRecord::Base
validates_uniqueness_of :nbp_id, :scope => :sponsor_id

belongs_to :nbp
belongs_to :sponsor

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |nbp_sponsors|
				csv << nbp_sponsors.attributes.values_at(*column_names)
			end
		end
	end

	def self.import(file)
		allowed_attributes = [  "nbp_id", "sponsor_id", "featured", "rationale", "note"]
		CSV.foreach(file.path,headers: true) do |row|
			nbp_sponsors = find_by_id(row["id"]) || new
			
			nbp_sponsors.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			nbp_sponsors.save
		end
	end	

end