
Pod::Spec.new do |s|
s.name             = "KeyboardLayoutGuide"
s.version          = "0.1.1"
s.summary          = "Enables you to set up Autolayout constraints directly between your views
and the iOS keyboard."

s.description      = <<-DESC
Imagine being able to set up Autolayout constraints directly between your views
and the iOS keyboard, so that your layout updates whenever the keyboard's frame changes.
KeyboardLayoutGuide makes that possible, providing options to do so entirely within
Interface Builder or in code.
DESC

s.homepage         = "https://github.com/johnpatrickmorgan/KeyboardLayoutGuide"
s.license          = 'MIT'
s.author           = { "John Morgan" => "johnpatrickmorganuk@gmail.com" }
s.source           = { :git => "https://github.com/johnpatrickmorgan/KeyboardLayoutGuide.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/jpmmusic'

s.platform     = :ios, '8.0'
s.requires_arc = true

s.source_files = 'Pod/Classes/**/*'

s.frameworks = 'UIKit'

s.dependency 'LifecycleHooks'

end
