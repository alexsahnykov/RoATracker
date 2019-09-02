#
# Be sure to run `pod lib lint RoATracker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RoATracker'
  s.version          = '1.0.0'
  s.summary          = 'A short description of RoATracker.'
  s.summary          = 'Description.'
  s.swift_version    = '4.0'
  s.source           = '**/*.swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/alexSahnykov/RoATracker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'alexSahnykov' => 'alexsahnykov@gmail.com' }
  s.source           = { :git => 'https://github.com/alexSahnykov/RoATracker.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'

  s.source_files = 'RoATracker/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RoATracker' => ['RoATracker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'FBSDKCoreKit', '5.3.0'
   s.dependency 'AppsFlyerFramework'
   s.static_framework = true
end
