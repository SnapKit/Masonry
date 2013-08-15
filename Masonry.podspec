Pod::Spec.new do |s|
  s.name     = 'Masonry'
  s.version  = '0.1.6'
  s.license  = 'MIT'
  s.summary  = 'Harness the power of iOS AutoLayout NSLayoutConstraints with a simplified, chainable and descriptive syntax.'
  s.homepage = 'https://github.com/cloudkite/Masonry'
  s.author   = { 'Jonas Budelmann' => 'jonas.budelmann@gmail.com' }

  s.source   = { :git => 'https://github.com/cloudkite/Masonry.git', :tag => 'v0.1.6' }

  s.description = %{
    Masonary is a light-weight layout framework which wraps AutoLayout with a nicer syntax.
	Masonary has its own layout DSL which provides a chainable way of describing your
	NSLayoutConstraints which results in layout code which is more concise and readable.
  }

  s.source_files = 'Masonry/*.{h,m}'

  s.frameworks = 'Foundation', 'UIKit'

  s.ios.deployment_target = '6.0' # using autolayout
  s.requires_arc = true
end