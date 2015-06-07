Pod::Spec.new do |s|
  s.name         = "UIViewController+KBDropdownController"
  s.version      = "1.0"
  s.summary      = "A short description of UIViewController+KBDropdownController."
  s.homepage     = "https://github.com/dai-jing/UIViewController-KBDropdownController"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Jing Dai" => "daijing24@gmail.com" }
  s.platform     = :ios
  s.platform   	 = :ios, "7.0"
  s.requires_arc = true
  s.source       = { 
	:git => "https://github.com/dai-jing/UIViewController-KBDropdownController",
	:branch => "master",
	:tag => s.version.to_s 
  }
  s.source_files = ".{h,m}"
  s.public_header_files = "*.h"
end
