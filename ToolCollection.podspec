#
# Be sure to run `pod lib lint ToolCollection.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ToolCollection'
  s.version          = '0.6.0'
  s.summary          = '工具集合'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://github.com/NeverAgain11/ToolCollection'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ljk' => 'liujk0723@gmail.com' }
  s.source           = { :git => 'https://github.com/NeverAgain11/ToolCollection.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5'
  s.requires_arc = true
  
  s.source_files = 'ToolCollection/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ToolCollection' => ['ToolCollection/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.dependency 'MMKV'
  s.dependency 'DifferenceKit'
  s.dependency 'RxSwift', '~> 5'
  s.dependency 'RxCocoa', '~> 5'
  s.dependency "Texture/Core", "~> 3.0"
  s.dependency 'CleanJSON'

end
