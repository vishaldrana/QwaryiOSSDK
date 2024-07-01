Pod::Spec.new do |s|
  s.name             = 'QwaryIos'
  s.version          = '2.1.0'
  s.summary          = 'An SDK to configure the Survey on customising Screen where the user can'
  
  s.description      = <<-DESC
                       The Qwary iOS SDK allows you to seamlessly integrate surveys and feedback forms into your iOS application.
                       DESC
  s.homepage         = 'https://www.qwary.com/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'devgeektech' => 'vishal@qwary.com' }
  s.source           = { :git => 'https://github.com/vishaldrana/QwaryiOSSDK.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '14.0'
  s.swift_version    = '5.0'
  
  s.source_files     = 'Classes/**/*.swift'
  
  # Uncomment and adjust the following lines if needed
   s.resources       = 'Classes/**/*.{html}'
  # s.resource_bundles = {
  #   'QwaryIos' => ['QwaryIos/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks      = 'UIKit', 'MapKit'
  # s.dependency      'AFNetworking', '~> 2.3'
end
