Pod::Spec.new do |s|

  s.name         = "BSKYCore"
  s.version      = "0.5.3"
  s.summary      = "BSKY core libraries"
  s.homepage     = "http://git.oschina.net/grandroutes/"  
  s.license      = "MIT"
  s.author             = { "dawenxi" => "heleiooooo@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://git.oschina.net/bskyios/BSKYCore-for-iOS.git", :tag => "0.4.8" }
  s.source_files  = "BSKYCorePods", "BSKYCorePods/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
  s.dependency "GTMBase64", "~> 1.0.0"
  s.dependency "YTKNetwork", "~> 2.0.4"
  s.dependency "YYCategories", "~> 1.0.4"
  s.dependency "SAMKeychain", "~> 1.5.1"
  s.dependency "MBProgressHUD", "~> 1.1.0"
end
