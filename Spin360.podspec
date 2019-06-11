#
# Be sure to run `pod lib lint Spin360.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'Spin360'
s.version          = '0.1.5'
s.summary          = 'Spin360 framework is used to take 360 Videos.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
Spin360 framework is used to take 360 Videos, Process, Preview and Upload.
DESC

s.homepage         = 'https://github.com/MadhuNunc/Spin360'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'MadhuNunc' => 'madhusudhan.gadiraju@nuncsystems.com' }
s.source           = { :git => 'https://github.com/MadhuNunc/Spin360.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '10.0'

s.source_files = 'Spin360/Classes/**/*.{h}'

# s.resource_bundles = {
#   'Spin360' => ['Spin360/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
