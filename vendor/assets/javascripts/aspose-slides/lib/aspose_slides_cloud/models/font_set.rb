module AsposeSlidesCloud
  # 
  class FontSet < BaseObject
    attr_accessor :complex_script, :east_asian, :latin
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'complex_script' => :'ComplexScript',
        
        # 
        :'east_asian' => :'EastAsian',
        
        # 
        :'latin' => :'Latin'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'complex_script' => :'String',
        :'east_asian' => :'String',
        :'latin' => :'String'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'ComplexScript']
        self.complex_script = attributes[:'ComplexScript']
      end
      
      if attributes[:'EastAsian']
        self.east_asian = attributes[:'EastAsian']
      end
      
      if attributes[:'Latin']
        self.latin = attributes[:'Latin']
      end
      
    end

  end
end
