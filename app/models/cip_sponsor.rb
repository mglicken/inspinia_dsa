class CipSponsor < ActiveRecord::Base
validates_uniqueness_of :cip_id, :scope => :sponsor_id
belongs_to :cip
belongs_to :sponsor
belongs_to :ioi

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |cip_sponsors|
				csv << cip_sponsors.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "cip_id", "sponsor_id", "ioi_id", "declined"]
		CSV.foreach(file.path,headers: true) do |row|
			cip_sponsors = find_by_id(row["id"]) || new
			
			cip_sponsors.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			cip_sponsors.save
		end
	end	

end