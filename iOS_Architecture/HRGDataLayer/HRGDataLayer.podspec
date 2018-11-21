#
# Be sure to run `pod lib lint HRGDataLayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HRGDataLayer'
  s.version          = '1.0.0'
  s.summary          = 'A short description of HRGDataLayer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/1290374862@qq.com/HRGDataLayer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1290374862@qq.com' => '1290374862@qq.com' }
  s.source           = { :git => 'https://github.com/1290374862@qq.com/HRGDataLayer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.subspec 'Code' do |ss|
      ss.source_files = "HRGDataLayer/DataLayer/**/*.{h,m}", "HRGDataLayer/DataLayer/*.{h,m}", "HRGDataLayer/Tool/*.{h,m}"
  end

  #s.resources = "HRGDataLayer/Assets/*.png"

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'YYKit'
  s.dependency 'AFNetworking'
  s.dependency 'AMapLocation'
  # s.dependency 'ReactiveCocoa', :git => 'https://github.com/zhao0/ReactiveCocoa.git', :tag => '2.5.2'

end
