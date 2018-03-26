class Tag < ActiveRecord::Base
validates :name, :presence => true, :uniqueness => true
has_many :slide_tags, :dependent => :destroy
has_many :slides, :through => :slide_tags

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |tags|
				csv << tags.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name"]
		CSV.foreach(file.path,headers: true) do |row|
			tags = find_by_id(row["id"]) || new
			
			tags.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			tags.save
		end
	end	

end