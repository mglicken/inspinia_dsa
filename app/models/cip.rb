class Cip < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true
	
	belongs_to :deal
	has_many :cip_slides, :dependent => :destroy
	has_many :slides, :through => :cip_slides, :dependent => :destroy
	has_many :cip_sponsors, :dependent => :destroy
	has_many :sponsors, :through => :cip_sponsors
	has_many :cip_companies, :dependent => :destroy
	has_many :companies, :through => :cip_companies

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
	def self.import_acquirers(file, cip_id = 1)
		@data = CSV.read(file.path, headers: true)
		cip = Cip.find(cip_id) 
		@data.each do |data|
			if data["Acquirer"].present?
				cip.cip_sponsors.each do |cip_sponsor|
					if	cip_sponsor.sponsor.name.downcase.include? data["Acquirer"].downcase
						if cip_sponsor.ioi.present?
							ioi = cip_sponsor.ioi
							ioi.ioi_date = data["ioi_date"]
							ioi.low_purchase_price = data["low_purchase_price"]
							ioi.high_purchase_price = data["high_purchase_price"]
							ioi.save
							cip_sponsor.ioi.ioi_highlights.each do |ioi_highlight|
								ioi_highlight.detail = data[ioi_highlight.highlight.name]
								if ioi_highlight.detail.present? && ioi_highlight.detail.length > 1 
									ioi_highlight.detail = ioi_highlight.detail[0].capitalize + ioi_highlight.detail[1..-1]
								else
									ioi_highlight.detail = "N/A"
								end
								ioi_highlight.save
							end
						end
					end
				end
				cip.cip_companies.each do |cip_company|
					if	cip_company.company.name.downcase.include? data["Acquirer"].downcase
						if cip_company.ioi.present?
							ioi = cip_company.ioi
							ioi.ioi_date = data["ioi_date"]
							ioi.low_purchase_price = data["low_purchase_price"]
							ioi.high_purchase_price = data["high_purchase_price"]
							ioi.save
							cip_company.ioi.ioi_highlights.each do |ioi_highlight|
								ioi_highlight.detail = data[ioi_highlight.highlight.name]
								if ioi_highlight.detail.present? && ioi_highlight.detail.length > 1 
									ioi_highlight.detail = ioi_highlight.detail[0].capitalize + ioi_highlight.detail[1..-1]
								else
									ioi_highlight.detail = "N/A"
								end
								ioi_highlight.save
							end
						end
					end
				end
			end
		end
	end	
end