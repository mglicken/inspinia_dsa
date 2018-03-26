class Mp < ActiveRecord::Base
belongs_to :deal
has_many :mp_slides, :dependent => :destroy
has_many :slides, :through => :mp_slides, :dependent => :destroy

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |mps|
				csv << mps.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "deal_id", "mp_date","image_id","name"]
		CSV.foreach(file.path,headers: true) do |row|
			mps = find_by_id(row["id"]) || new
			
			mps.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			mps.save
		end
	end	
end