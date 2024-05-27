#
#  Be sure to run `pod spec lint Qwary.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "Qwary"
  spec.version      = "1.0.0"
  spec.summary      = "The Qwary iOS SDK allows you to seamlessly integrate surveys and can make you flexible to show the surgery on any screen"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = "The Qwary iOS SDK allows you to seamlessly integrate surveys and feedback forms into your iOS application ,The Qwary iOS SDK allows you to seamlessly integrate surveys and feedback forms into your iOS application"

   spec.homepage     = "https://www.qwary.com/"
  


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = "MIT"
 


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "Geeks" => "development.geektech@gmail.com" }
  
  
  spec.platform     = :ios, "13.0"



  spec.source       = { :git => "https://github.com/vishaldrana/QwaryiOSSDK.git", :tag => spec.version.to_s }



  spec.source_files  = "QwaryIos/**/*.{swift}"
  spec.swift_versions = "5.0"
  spec.framework  = "Foundation"

end
