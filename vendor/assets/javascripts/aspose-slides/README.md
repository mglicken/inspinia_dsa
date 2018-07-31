# Aspose.Slides Cloud SDK For Ruby
This SDK lets you use [Aspose Cloud Slides APIs](https://www.aspose.com/products/slides/cloud) in your web apps.

<p align="center">
  <a title="Download complete Aspose.Slides for Cloud source code" href="https://github.com/asposeslides/Aspose_slides_Cloud/archive/master.zip">
	<img src="https://raw.github.com/AsposeExamples/java-examples-dashboard/master/images/downloadZip-Button-Large.png" />
  </a>
</p>

## How to Use the SDK?
The complete source code is available in this repository folder, you can either directly use it in your project or use RubyGems. For more details, please visit our [documentation website](https://docs.aspose.com/display/slidescloud/Available+SDKs).


## Usage
APIs of this SDK can be called as follows:

```ruby
require 'aspose_slides_cloud'

class SlidesUsage
  
  include AsposeSlidesCloud
  include AsposeStorageCloud
	
  def initialize
    #Get App key and App SID from https://cloud.aspose.com
    AsposeApp.app_key_and_sid("APP_KEY", "APP_SID")
    @slides_api = SlidesApi.new  
  end
  
  def put_slides_convert
    #Convert presentation from request content to format specified.
    file_name = "sample.pptx"
    convert_to_format = "pdf"
    response = @slides_api.put_slides_convert(File.open("data/" << file_name,"r") { |io| io.read }, {format: convert_to_format})
  end
  
end
```
## Unit Tests
Aspose Slides SDK includes a suite of unit tests within the [test](https://github.com/aspose-slides/Aspose.Slides-for-Cloud/blob/master/SDKs/Aspose.Slides-Cloud-SDK-for-Ruby/test/slides_tests.rb) subdirectory. These Unit Tests also serves as examples of how to use the Aspose Slides SDK.

## Contact Us
Your feedback is very important to us. Please feel free to contact us using our [Support Forums](https://www.aspose.com/community/forums/).
