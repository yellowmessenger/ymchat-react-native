
Pod::Spec.new do |s|
  s.name         = "ymchat-react-native"
  s.version      = "1.0.0"
  s.summary      = "React native bridge for YMChat"
  s.homepage     = "https://yellowmessenger.com"
  s.license      = "MIT"
  s.author       = { "kaunteya" => "kaunteya@yellowmessenger.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/author/YMChat.git", :tag => "master" }
  s.source_files  = "ios/*.{h,m}"
  s.requires_arc = true
  s.swift_version = "5.0"

  s.dependency "React"
  s.dependency "YMChat", "~> 0.0.6"
  
end

  