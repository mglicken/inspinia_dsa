class Role < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true
	has_many :people
	has_many :work_histories
	has_many :sponsor_histories

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |roles|
				csv << roles.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name"]
		CSV.foreach(file.path,headers: true) do |row|
			roles = find_by_id(row["id"]) || new
			
			roles.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			roles.save
		end
	end	

end