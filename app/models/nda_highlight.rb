class NdaHighlight < ActiveRecord::Base
validates_uniqueness_of :highlight_id, scope: :nda_id

belongs_to :highlight
belongs_to :nda

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |nda_highlights|
				csv << nda_highlights.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "highlight_id", "nda_id", "detail"]
		CSV.foreach(file.path,headers: true) do |row|
			nda_highlights = find_by_id(row["id"]) || new
			
			nda_highlights.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			nda_highlights.save
		end
	end	
end