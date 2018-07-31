module AsposeSlidesCloud
  # 
  class ArrowHeadProperties < BaseObject
    attr_accessor :length, :style, :width
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'length' => :'Length',
        
        # 
        :'style' => :'Style',
        
        # 
        :'width' => :'Width'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'length' => :'String',
        :'style' => :'String',
        :'width' => :'String'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Length']
        self.length = attributes[:'Length']
      end
      
      if attributes[:'Style']
        self.style = attributes[:'Style']
      end
      
      if attributes[:'Width']
        self.width = attributes[:'Width']
      end
      
    end

  end
end
