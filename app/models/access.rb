class Access < ActiveRecord::Base
validates :name, :presence => true, :uniqueness => true
has_many :users

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |accesses|
				csv << accesses.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name"]
		CSV.foreach(file.path,headers: true) do |row|
			accesses = find_by_id(row["id"]) || new
			
			accesses.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			accesses.save
		end
	end	
end