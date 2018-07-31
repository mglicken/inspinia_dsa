module AsposeSlidesCloud
  # 
  class Paragraphs < BaseObject
    attr_accessor :alternate_links, :links, :self_uri, :paragraph_links
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
        :'paragraph_links' => :'ParagraphLinks'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'alternate_links' => :'Array<ResourceUri>',
        :'links' => :'Array<ResourceUri>',
        :'self_uri' => :'ResourceUri',
        :'paragraph_links' => :'Array<ResourceUriElement>'
        
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
      
      if attributes[:'ParagraphLinks']
        if (value = attributes[:'ParagraphLinks']).is_a?(Array)
          self.paragraph_links = value
        end
      end
      
    end

  end
end
