module AsposeSlidesCloud
  # 
  class PresentationToMerge < BaseObject
    attr_accessor :path, :slides
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'path' => :'Path',
        
        # 
        :'slides' => :'Slides'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'path' => :'String',
        :'slides' => :'Array<Integer>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Path']
        self.path = attributes[:'Path']
      end
      
      if attributes[:'Slides']
        if (value = attributes[:'Slides']).is_a?(Array)
          self.slides = value
        end
      end
      
    end

  end
end
