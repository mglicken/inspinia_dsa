module AsposeSlidesCloud
  # 
  class TiffExportOptions < BaseObject
    attr_accessor :width, :height, :dpi_x, :dpi_y, :compression, :export_format
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'width' => :'Width',
        
        # 
        :'height' => :'Height',
        
        # 
        :'dpi_x' => :'DpiX',
        
        # 
        :'dpi_y' => :'DpiY',
        
        # 
        :'compression' => :'Compression',
        
        # 
        :'export_format' => :'ExportFormat'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'width' => :'Integer',
        :'height' => :'Integer',
        :'dpi_x' => :'Integer',
        :'dpi_y' => :'Integer',
        :'compression' => :'String',
        :'export_format' => :'String'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Width']
        self.width = attributes[:'Width']
      end
      
      if attributes[:'Height']
        self.height = attributes[:'Height']
      end
      
      if attributes[:'DpiX']
        self.dpi_x = attributes[:'DpiX']
      end
      
      if attributes[:'DpiY']
        self.dpi_y = attributes[:'DpiY']
      end
      
      if attributes[:'Compression']
        self.compression = attributes[:'Compression']
      end
      
      if attributes[:'ExportFormat']
        self.export_format = attributes[:'ExportFormat']
      end
      
    end

  end
end
