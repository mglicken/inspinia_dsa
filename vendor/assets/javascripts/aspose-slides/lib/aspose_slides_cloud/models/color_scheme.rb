module AsposeSlidesCloud
  # 
  class ColorScheme < BaseObject
    attr_accessor :accent1, :accent2, :accent3, :accent4, :accent5, :accent6, :dark1, :dark2, :followed_hyperlink, :hyperlink, :light1, :light2, :self_uri, :alternate_links, :links
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'accent1' => :'Accent1',
        
        # 
        :'accent2' => :'Accent2',
        
        # 
        :'accent3' => :'Accent3',
        
        # 
        :'accent4' => :'Accent4',
        
        # 
        :'accent5' => :'Accent5',
        
        # 
        :'accent6' => :'Accent6',
        
        # 
        :'dark1' => :'Dark1',
        
        # 
        :'dark2' => :'Dark2',
        
        # 
        :'followed_hyperlink' => :'FollowedHyperlink',
        
        # 
        :'hyperlink' => :'Hyperlink',
        
        # 
        :'light1' => :'Light1',
        
        # 
        :'light2' => :'Light2',
        
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
        :'accent1' => :'String',
        :'accent2' => :'String',
        :'accent3' => :'String',
        :'accent4' => :'String',
        :'accent5' => :'String',
        :'accent6' => :'String',
        :'dark1' => :'String',
        :'dark2' => :'String',
        :'followed_hyperlink' => :'String',
        :'hyperlink' => :'String',
        :'light1' => :'String',
        :'light2' => :'String',
        :'self_uri' => :'ResourceUri',
        :'alternate_links' => :'Array<ResourceUri>',
        :'links' => :'Array<ResourceUri>'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Accent1']
        self.accent1 = attributes[:'Accent1']
      end
      
      if attributes[:'Accent2']
        self.accent2 = attributes[:'Accent2']
      end
      
      if attributes[:'Accent3']
        self.accent3 = attributes[:'Accent3']
      end
      
      if attributes[:'Accent4']
        self.accent4 = attributes[:'Accent4']
      end
      
      if attributes[:'Accent5']
        self.accent5 = attributes[:'Accent5']
      end
      
      if attributes[:'Accent6']
        self.accent6 = attributes[:'Accent6']
      end
      
      if attributes[:'Dark1']
        self.dark1 = attributes[:'Dark1']
      end
      
      if attributes[:'Dark2']
        self.dark2 = attributes[:'Dark2']
      end
      
      if attributes[:'FollowedHyperlink']
        self.followed_hyperlink = attributes[:'FollowedHyperlink']
      end
      
      if attributes[:'Hyperlink']
        self.hyperlink = attributes[:'Hyperlink']
      end
      
      if attributes[:'Light1']
        self.light1 = attributes[:'Light1']
      end
      
      if attributes[:'Light2']
        self.light2 = attributes[:'Light2']
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
