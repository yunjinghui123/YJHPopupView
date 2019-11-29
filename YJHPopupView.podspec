Pod::Spec.new do |spec|
  spec.name         = "YJHPopupView"
  spec.version      = "0.0.9"
  spec.summary      = "A simple bottom popup view"
  spec.homepage     = "https://github.com/yunjinghui123/YJHPopupView"
  spec.license      = "MIT"
  spec.author       = { "yunjinghui123" => "1432680302@qq.com" }
  spec.platform     = :ios, "6.0"
  spec.source       = { :git => "https://github.com/yunjinghui123/YJHPopupView.git", :tag => "#{spec.version}" }
  spec.source_files  = "YJHPopupView", "YJHPopupView/**/*.{h,m}"
  spec.requires_arc = true
end
