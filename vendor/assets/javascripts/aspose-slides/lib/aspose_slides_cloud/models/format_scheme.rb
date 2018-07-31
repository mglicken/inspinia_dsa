module AsposeSlidesCloud
  # 
  class FormatScheme < BaseObject
    attr_accessor :background_styles, :effect_styles, :fill_styles, :line_styles, :self_uri, :alternate_links, :links
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'background_styles' => :'BackgroundStyles',
        
        # 
        :'effect_styles' => :'EffectStyles',
        
        # 
        :'fill_styles' => :'FillStyles',
        
        # 
        :'line_styles' => :'LineStyles',
        
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
        :'background_styles' => :'Array<ResourceUri>',
        :'effect_styles' => :'Array<ResourceUri>',
        :'fill_styles' => :'Array<ResourceUri>',
        :'line_styles' => :'Array<ResourceUri>',
        :'self_uri' => :'ResourceUri',
        :'alternate_links' => :'Array<ResourceUri>',
        :'links' => :'Array<ResourceUri>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'BackgroundStyles']
        if (value = attributes[:'BackgroundStyles']).is_a?(Array)
          self.background_styles = value
        end
      end
      
      if attributes[:'EffectStyles']
        if (value = attributes[:'EffectStyles']).is_a?(Array)
          self.effect_styles = value
        end
      end
      
      if attributes[:'FillStyles']
        if (value = attributes[:'FillStyles']).is_a?(Array)
          self.fill_styles = value
        end
      end
      
      if attributes[:'LineStyles']
        if (value = attributes[:'LineStyles']).is_a?(Array)
          self.line_styles = value
        end
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
