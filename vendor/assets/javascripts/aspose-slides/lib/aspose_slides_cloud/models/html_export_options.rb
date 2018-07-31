module AsposeSlidesCloud
  # 
  class HtmlExportOptions < BaseObject
    attr_accessor :save_as_zip, :sub_directory_name, :export_format
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'save_as_zip' => :'SaveAsZip',
        
        # 
        :'sub_directory_name' => :'SubDirectoryName',
        
        # 
        :'export_format' => :'ExportFormat'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'save_as_zip' => :'BOOLEAN',
        :'sub_directory_name' => :'String',
        :'export_format' => :'String'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'SaveAsZip']
        self.save_as_zip = attributes[:'SaveAsZip']
      end
      
      if attributes[:'SubDirectoryName']
        self.sub_directory_name = attributes[:'SubDirectoryName']
      end
      
      if attributes[:'ExportFormat']
        self.export_format = attributes[:'ExportFormat']
      end
      
    end

  end
end
