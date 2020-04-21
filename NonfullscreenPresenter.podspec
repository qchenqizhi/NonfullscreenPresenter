#
# Be sure to run `pod lib lint NonfullscreenPresenter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NonfullscreenPresenter'
  s.version          = '0.1.0'
  s.summary          = 'A lightweight wrapper for easily customizing animation of present non-fullscreen view controller.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A lightweight wrapper for easily customizing animation of present non-fullscreen view controller, also applicable to non-nonfullscreen (fullscreen).
                       DESC

  s.homepage         = 'https://github.com/qchenqizhi/NonfullscreenPresenter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chen Qizhi' => 'qchenqizhi@gmail.com' }
  s.source           = { :git => 'https://github.com/qchenqizhi/NonfullscreenPresenter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'NonfullscreenPresenter/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NonfullscreenPresenter' => ['NonfullscreenPresenter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.swift_version = '5.0'
  # s.dependency 'AFNetworking', '~> 2.3'
end
