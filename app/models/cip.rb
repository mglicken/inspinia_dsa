class Cip < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true
	
	belongs_to :deal
	has_many :cip_slides, :dependent => :destroy
	has_many :slides, :through => :cip_slides, :dependent => :destroy
	has_many :cip_sponsors, :dependent => :destroy
	has_many :sponsors, :through => :cip_sponsors
	has_many :cip_companies, :dependent => :destroy
	has_many :companies, :through => :cip_companies

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |cips|
				csv << cips.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "deal_id", "cip_date","image_id","name", "ppt_address"]
		CSV.foreach(file.path,headers: true) do |row|
			cips = find_by_id(row["id"]) || new
			
			cips.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			cips.save
		end
	end	
	def self.import_acquirers(file)
		@data = CSV.read(file.path, headers: true)
		@rows = []
		cip = Cip.find(@data["cip_id"][0])

		return Sponsor.where(id: cip.cip_sponsors.pluck(:sponsor_id)).pluck(:name)[0..50]
	end	
end