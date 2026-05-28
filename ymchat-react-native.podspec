require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "ymchat-react-native"
  s.version      = package['version']
  s.summary      = "React native bridge for YMChat"
  s.homepage     = "https://yellow.ai"
  s.license      = "MIT"
  s.author       = { "sankalp" => "sankalp.gupta@yellow.ai" }
  s.platform     = :ios, "13.0"
  s.source       = { :git => "https://github.com/yellowmessenger/ymchat-react-native.git", :tag => "master" }
  s.source_files = "ios/**/*.{h,m,mm}"
  s.requires_arc = true
  s.swift_version = "5.0"

  s.dependency "YMChat", "~> 1.24.0"

  # install_modules_dependencies handles New Architecture (TurboModule) dependencies
  # automatically when RCT_NEW_ARCH_ENABLED=1, and falls back to React-Core only otherwise.
  # Available from react-native >= 0.71.
  if respond_to?(:install_modules_dependencies, true)
    install_modules_dependencies(s)
  else
    # Fallback for older react-native versions without the helper
    if ENV['RCT_NEW_ARCH_ENABLED'] == '1'
      folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'
      s.compiler_flags = folly_compiler_flags + ' -DRCT_NEW_ARCH_ENABLED=1'
      s.pod_target_xcconfig = {
        'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/boost"',
        'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17'
      }
      s.dependency 'React-Codegen'
      s.dependency 'RCT-Folly'
      s.dependency 'RCTRequired'
      s.dependency 'RCTTypeSafety'
      s.dependency 'ReactCommon/turbomodule/core'
    end
  end
end
