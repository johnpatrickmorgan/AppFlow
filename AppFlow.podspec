
Pod::Spec.new do |s|
  s.name             = 'AppFlow'
  s.version          = '0.1.2'
  s.summary          = "AppFlow provides a type-checked declarative DSL for defining your app's user and data flow."

  s.description      = <<-DESC
    AppFlow provides a type-checked declarative DSL for defining your app's user and data flow.
    It makes it easy to adopt the flow coordinator/controller pattern and keep your UIViewControllers agnostic.
                       DESC

  s.homepage         = 'https://github.com/johnpatrickmorgan/AppFlow'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'johnpatrickmorgan' => 'johnpatrickmorganuk@gmail.com' }
  s.source           = { :git => 'https://github.com/johnpatrickmorgan/AppFlow.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jpmmusic'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/**/*'

  s.frameworks = 'UIKit'

end
