module AsposeSlidesCloud
  # 
  class Shape < BaseObject
    attr_accessor :text, :paragraphs, :shape_type, :name, :width, :height, :alternative_text, :hidden, :x, :y, :z_order_position, :shapes, :fill_format, :line_format, :self_uri, :alternate_links, :links
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'text' => :'Text',
        
        # 
        :'paragraphs' => :'Paragraphs',
        
        # 
        :'shape_type' => :'ShapeType',
        
        # 
        :'name' => :'Name',
        
        # 
        :'width' => :'Width',
        
        # 
        :'height' => :'Height',
        
        # 
        :'alternative_text' => :'AlternativeText',
        
        # 
        :'hidden' => :'Hidden',
        
        # 
        :'x' => :'X',
        
        # 
        :'y' => :'Y',
        
        # 
        :'z_order_position' => :'ZOrderPosition',
        
        # 
        :'shapes' => :'Shapes',
        
        # 
        :'fill_format' => :'FillFormat',
        
        # 
        :'line_format' => :'LineFormat',
        
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
        :'paragraphs' => :'ResourceUriElement',
        :'shape_type' => :'String',
        :'name' => :'String',
        :'width' => :'Float',
        :'height' => :'Float',
        :'alternative_text' => :'String',
        :'hidden' => :'BOOLEAN',
        :'x' => :'Float',
        :'y' => :'Float',
        :'z_order_position' => :'Integer',
        :'shapes' => :'ResourceUriElement',
        :'fill_format' => :'FillFormat',
        :'line_format' => :'LineFormat',
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
      
      if attributes[:'Paragraphs']
        self.paragraphs = attributes[:'Paragraphs']
      end
      
      if attributes[:'ShapeType']
        self.shape_type = attributes[:'ShapeType']
      end
      
      if attributes[:'Name']
        self.name = attributes[:'Name']
      end
      
      if attributes[:'Width']
        self.width = attributes[:'Width']
      end
      
      if attributes[:'Height']
        self.height = attributes[:'Height']
      end
      
      if attributes[:'AlternativeText']
        self.alternative_text = attributes[:'AlternativeText']
      end
      
      if attributes[:'Hidden']
        self.hidden = attributes[:'Hidden']
      end
      
      if attributes[:'X']
        self.x = attributes[:'X']
      end
      
      if attributes[:'Y']
        self.y = attributes[:'Y']
      end
      
      if attributes[:'ZOrderPosition']
        self.z_order_position = attributes[:'ZOrderPosition']
      end
      
      if attributes[:'Shapes']
        self.shapes = attributes[:'Shapes']
      end
      
      if attributes[:'FillFormat']
        self.fill_format = attributes[:'FillFormat']
      end
      
      if attributes[:'LineFormat']
        self.line_format = attributes[:'LineFormat']
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
