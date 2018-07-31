module AsposeSlidesCloud
  # 
  class LineFormat < BaseObject
    attr_accessor :alignment, :cap_style, :dash_style, :join_style, :style, :begin_arrow_head, :end_arrow_head, :custom_dash_pattern, :fill_format, :miter_limit, :width
    # attribute mapping from ruby-style variable name to JSON key
    def self.attribute_map
      {
        
        # 
        :'alignment' => :'Alignment',
        
        # 
        :'cap_style' => :'CapStyle',
        
        # 
        :'dash_style' => :'DashStyle',
        
        # 
        :'join_style' => :'JoinStyle',
        
        # 
        :'style' => :'Style',
        
        # 
        :'begin_arrow_head' => :'BeginArrowHead',
        
        # 
        :'end_arrow_head' => :'EndArrowHead',
        
        # 
        :'custom_dash_pattern' => :'CustomDashPattern',
        
        # 
        :'fill_format' => :'FillFormat',
        
        # 
        :'miter_limit' => :'MiterLimit',
        
        # 
        :'width' => :'Width'
        
      }
    end

    # attribute type
    def self.swagger_types
      {
        :'alignment' => :'String',
        :'cap_style' => :'String',
        :'dash_style' => :'String',
        :'join_style' => :'String',
        :'style' => :'String',
        :'begin_arrow_head' => :'ArrowHeadProperties',
        :'end_arrow_head' => :'ArrowHeadProperties',
        :'custom_dash_pattern' => :'CustomDashPattern',
        :'fill_format' => :'FillFormat',
        :'miter_limit' => :'Float',
        :'width' => :'Float'
        
      }
    end

    def initialize(attributes = {})
      return if !attributes.is_a?(Hash) || attributes.empty?

      # convert string to symbol for hash key
      attributes = attributes.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      
      if attributes[:'Alignment']
        self.alignment = attributes[:'Alignment']
      end
      
      if attributes[:'CapStyle']
        self.cap_style = attributes[:'CapStyle']
      end
      
      if attributes[:'DashStyle']
        self.dash_style = attributes[:'DashStyle']
      end
      
      if attributes[:'JoinStyle']
        self.join_style = attributes[:'JoinStyle']
      end
      
      if attributes[:'Style']
        self.style = attributes[:'Style']
      end
      
      if attributes[:'BeginArrowHead']
        self.begin_arrow_head = attributes[:'BeginArrowHead']
      end
      
      if attributes[:'EndArrowHead']
        self.end_arrow_head = attributes[:'EndArrowHead']
      end
      
      if attributes[:'CustomDashPattern']
        self.custom_dash_pattern = attributes[:'CustomDashPattern']
      end
      
      if attributes[:'FillFormat']
        self.fill_format = attributes[:'FillFormat']
      end
      
      if attributes[:'MiterLimit']
        self.miter_limit = attributes[:'MiterLimit']
      end
      
      if attributes[:'Width']
        self.width = attributes[:'Width']
      end
      
    end

  end
end
