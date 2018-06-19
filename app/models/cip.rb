class Cip < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true
	
	belongs_to :deal
	has_many :cip_slides, :dependent => :destroy
	has_many :slides, :through => :cip_slides, :dependent => :destroy
	has_many :cip_sponsors, :dependent => :destroy
	has_many :sponsors, :through => :cip_sponsors
	has_many :cip_companies, :dependent => :destroy
	has_many :companies, :through => :cip_companies
	has_many :cip_highlights, :dependent => :destroy
	has_many :highlights, :through => :cip_highlights

	def random_gen(number)
		a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
		b=""
		for i in 0..(number-1)
		  b=b+a[rand(35)]
		end
		puts b
	end

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
end