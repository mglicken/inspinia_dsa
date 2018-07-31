module AsposeSlidesCloud
  # 
  class ResourceUriElement < BaseObject
    attr_accessor :uri
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'uri' => :'Uri'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'uri' => :'ResourceUri'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Uri']
        self.uri = attributes[:'Uri']
      end
      
    end

  end
end
