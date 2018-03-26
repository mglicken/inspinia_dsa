class FavoriteSlide < ActiveRecord::Base
	validates_uniqueness_of :user_id, :scope => :slide_id
	belongs_to :user
	belongs_to :slide

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |favorite_slides|
				csv << favorite_slides.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "slide_id", "user_id"]
		CSV.foreach(file.path,headers: true) do |row|
			favorite_slides = find_by_id(row["id"]) || new
			
			favorite_slides.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			favorite_slides.save
		end
	end	
end