Pod::Spec.new do |s|
  s.name             = "SRefresh"
  s.version          = "1.0.0"
  s.summary          = "A refreshControl used on iOS."
  s.description      = "
                       It is a refreshControl used on iOS, which implement by Objective-C."

  s.homepage         = "https://github.com/cs0811/SRefresh"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = "MIT"
  s.author           = { "S" => "382766636@qq.com" }
  s.source           = { :git => "https://github.com/cs0811/SRefresh.git", :tag => s.version.to_s }  # s.social_media_url = 'https://twitter.com/NAME'

  s.platform     = :ios, '7.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = "SRefresh/*.{h,m}"
  # s.resources = 'Assets'

  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation', 'UIKit'
  s.dependency "Masonry", "~> 0.6.2"

end