class IoiHighlight < ActiveRecord::Base
validates_uniqueness_of :highlight_id, scope: :ioi_id

belongs_to :highlight
belongs_to :ioi

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |ioi_highlights|
				csv << ioi_highlights.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "highlight_id", "ioi_id", "detail"]
		CSV.foreach(file.path,headers: true) do |row|
			ioi_highlights = find_by_id(row["id"]) || new
			
			ioi_highlights.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			ioi_highlights.save
		end
	end	
end