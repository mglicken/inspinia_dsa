module AsposeSlidesCloud
  # 
  class Portion < BaseObject
    attr_accessor :text, :font_color, :font_height, :self_uri, :alternate_links, :links
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'text' => :'Text',
        
        # 
        :'font_color' => :'FontColor',
        
        # 
        :'font_height' => :'FontHeight',
        
        # 
        :'self_uri' => :'SelfUri',
        
        # 
        :'alternate_links' => :'AlternateLinks',
        
        # 
        :'links' => :'Links'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'text' => :'String',
        :'font_color' => :'String',
        :'font_height' => :'Float',
        :'self_uri' => :'ResourceUri',
        :'alternate_links' => :'Array<ResourceUri>',
        :'links' => :'Array<ResourceUri>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Text']
        self.text = attributes[:'Text']
      end
      
      if attributes[:'FontColor']
        self.font_color = attributes[:'FontColor']
      end
      
      if attributes[:'FontHeight']
        self.font_height = attributes[:'FontHeight']
      end
      
      if attributes[:'SelfUri']
        self.self_uri = attributes[:'SelfUri']
      end
      
      if attributes[:'AlternateLinks']
        if (value = attributes[:'AlternateLinks']).is_a?(Array)
          self.alternate_links = value
        end
      end
      
      if attributes[:'Links']
        if (value = attributes[:'Links']).is_a?(Array)
          self.links = value
        end
      end
      
    end

  end
end
