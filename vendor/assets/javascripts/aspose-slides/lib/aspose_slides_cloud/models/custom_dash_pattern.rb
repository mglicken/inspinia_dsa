module AsposeSlidesCloud
  # 
  class CustomDashPattern < BaseObject
    attr_accessor :items
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'items' => :'Items'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'items' => :'Array<Float>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Items']
        if (value = attributes[:'Items']).is_a?(Array)
          self.items = value
        end
      end
      
    end

  end
end
