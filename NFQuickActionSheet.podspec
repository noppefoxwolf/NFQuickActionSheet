Pod::Spec.new do |s|
  s.name             = 'NFQuickActionSheet'
  s.version          = '0.3.0'
  s.summary          = 'A short description of NFQuickActionSheet.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/noppefoxwolf/NFQuickActionSheet'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '🦊Tomoya Hirano' => 'noppelabs@gmail.com' }
  s.source           = { :git => 'https://github.com/noppefoxwolf/NFQuickActionSheet.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/noppefoxwolf'

  s.ios.deployment_target = '11.0'
  s.source_files = 'NFQuickActionSheet/Classes/**/*'
end
