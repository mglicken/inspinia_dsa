class MpSponsor < ActiveRecord::Base
	validates_uniqueness_of :mp_id, :scope => :sponsor_id
	validates :mp_id, :presence => true
	validates :sponsor_id, :presence => true
	belongs_to :mp
	belongs_to :sponsor
	belongs_to :loi

	has_many :diligence_advisors, :dependent => :destroy

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |mp_sponsors|
				csv << mp_sponsors.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "mp_id", "sponsor_id", "mp_date", "loi_id", "declined", "final_buyer"]
		CSV.foreach(file.path,headers: true) do |row|
			mp_sponsors = find_by_id(row["id"]) || new
			
			mp_sponsors.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			mp_sponsors.save
		end
	end	

end