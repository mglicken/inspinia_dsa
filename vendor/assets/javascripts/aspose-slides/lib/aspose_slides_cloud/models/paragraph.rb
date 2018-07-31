module AsposeSlidesCloud
  # 
  class Paragraph < BaseObject
    attr_accessor :alternate_links, :links, :self_uri, :portion_list
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'alternate_links' => :'AlternateLinks',
        
        # 
        :'links' => :'Links',
        
        # 
        :'self_uri' => :'SelfUri',
        
        # 
        :'portion_list' => :'PortionList'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'alternate_links' => :'Array<ResourceUri>',
        :'links' => :'Array<ResourceUri>',
        :'self_uri' => :'ResourceUri',
        :'portion_list' => :'Array<ResourceUriElement>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
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
      
      if attributes[:'SelfUri']
        self.self_uri = attributes[:'SelfUri']
      end
      
      if attributes[:'PortionList']
        if (value = attributes[:'PortionList']).is_a?(Array)
          self.portion_list = value
        end
      end
      
    end

  end
end
