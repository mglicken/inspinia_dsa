module AsposeSlidesCloud
  # 
  class TextItem < BaseObject
    attr_accessor :uri, :text
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'uri' => :'Uri',
        
        # 
        :'text' => :'Text'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'uri' => :'ResourceUri',
        :'text' => :'String'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Uri']
        self.uri = attributes[:'Uri']
      end
      
      if attributes[:'Text']
        self.text = attributes[:'Text']
      end
      
    end

  end
end
