Pod::Spec.new do |spec|
  spec.name         = "YJHPopupView"
  spec.version      = "0.2.4"
  spec.summary      = "A simple bottom popup view"
  spec.homepage     = "https://github.com/yunjinghui123/YJHPopupView"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "yunjinghui123" => "1432680302@qq.com" }
  spec.platform     = :ios, "6.0"
  spec.source       = { :git => "https://github.com/yunjinghui123/YJHPopupView.git", :tag => "#{spec.version}" }
  spec.requires_arc = true
  spec.source_files  = "YJHPopupView/*.{h,m}"
  spec.resource_bundles = {'YJHPopupView' => ['YJHPopupView/Resources/PrivacyInfo.xcprivacy']}
end
