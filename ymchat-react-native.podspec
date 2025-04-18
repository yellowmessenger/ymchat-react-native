require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "ymchat-react-native"
  s.version      =  package['version']
  s.summary      = "React native bridge for YMChat"
  s.homepage     = "https://yellow.ai"
  s.license      = "MIT"
  s.author       = { "sankalp" => "sankalp.gupta@yellow.ai" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/yellowmessenger/ymchat-react-native.git", :tag => "master" }
  s.source_files  = "ios/*.{h,m}"
  s.requires_arc = true
  s.swift_version = "5.0"

  s.dependency "React"
  s.dependency "YMChat", "~> 1.24.0"

end
