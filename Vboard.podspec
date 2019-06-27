Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "Vboard"
s.summary = "VBoard. is video at your fingertips! Add videos from everywhere to your conversations anywhere."
s.requires_arc = true
s.version = "0.1.0"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Rabia" => "rabia.dastgir@argonteq.com" }
s.homepage = "https://github.com/TheCodedSelf/RWPickFlavor"
s.source = { :git => "https://github.com/ArgonTech/VBoard.git",
:tag => "#{s.version}" }
s.framework = "UIKit"
s.dependency 'SDWebImage', '~>3.7'
s.dependency "YoutubePlayer-in-WKWebView", "~> 0.2.0"
s.source_files = "VboardFramework/**/*"
s.resources = "VboardFramework/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

end
