class AdvisorType < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true

	has_many :diligence_advisors, :dependent => :destroy

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |highlights|
				csv << highlights.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = ["name", "deal_include", "mp_include"]
		CSV.foreach(file.path,headers: true) do |row|
			highlights = find_by_id(row["id"]) || new
			
			highlights.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			highlights.save
		end
	end	

end