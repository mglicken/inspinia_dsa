# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "aspose_slides_cloud/version"

Gem::Specification.new do |s|
  s.name        = "aspose_slides_cloud"
  s.version     = AsposeSlidesCloud::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["M. Sohail Ismail"]
  s.email       = ["muhammad.sohail@aspose.com"]
  s.homepage    = "http://www.aspose.com/cloud/powerpoint-api.aspx"
  s.summary     = %q{Aspose.Slides for Cloud}
  s.description = %q{Aspose.Slides for Cloud is a REST API which allows you to process presentations. It allows you to create, modify, and convert presentations and provides a wide variety of features for working with presentations in the cloud. You can convert a presentation to TIFF, PDF, XPS, PPTX, ODP, PPSX, PPTM, PPSM, POTX, POTM, HTML and image formats. Aspose.Slides for Cloud allows you to extract different elements or a presentation including slide, text, color schemes, font schemes, shapes and images etc. Aspose.Slides for Cloud’s powerful API lets your apps process Microsoft PowerPoint presentations in the cloud, saving you the time it would take to develop your own API.}
  s.license     = "MIT"

  s.add_runtime_dependency 'typhoeus', '~> 0.8'
  s.add_runtime_dependency 'json', '~> 1.7'
  s.add_runtime_dependency 'aspose_storage_cloud', '~> 1.0', '>= 1.0.0'

  s.add_development_dependency 'minitest', '~> 5.8'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = []
  s.require_paths = ["lib"]
end