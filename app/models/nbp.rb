class Nbp < ActiveRecord::Base
validates :name, :presence => true, :uniqueness => true

belongs_to :deal
has_many :nbp_slides, :dependent => :destroy
has_many :buckets, :dependent => :destroy
has_many :slides, :through => :nbp_slides, :dependent => :destroy
has_many :nbp_sponsors, :dependent => :destroy
has_many :sponsors, :through => :nbp_sponsors
has_many :nbp_companies, :dependent => :destroy
has_many :companies, :through => :nbp_companies
has_many :nbp_tags, :dependent => :destroy
has_many :tags, :through => :nbp_tags

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |nbps|
				csv << nbps.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "deal_id", "nbp_date","image_id","name", "ppt_address"]
		CSV.foreach(file.path,headers: true) do |row|
			nbps = find_by_id(row["id"]) || new
			
			nbps.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			nbps.save
		end
	end

	def self.import_acquirers(file, nbp_id = 1)
		@data = CSV.read(file.path, headers: true)
		nbp = Nbp.find(nbp_id) 
		@data.each do |data|
			nbp_company = NbpCompany.find_by(nbp_id: nbp.id, company_id: data["company_id"])
			nbp_company.tier_id = data["tier_id"]
			nbp_company.include_strip = data["include_strip"]
			nbp_company.strip = data["strip"]
			nbp_company.note = data["note"]
			nbp_company.save
			nbp_company.strip_tags.each do |strip_tag|
				strip_tag.value = data[strip_tag.tag.name]
				strip_tag.save
			end
		end
	end	
end