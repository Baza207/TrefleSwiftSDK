Pod::Spec.new do |s|

  s.name         = "TrefleSwiftSDK"
  s.version      = "0.0.4"
  s.summary      = "TrefleSwiftSDK is a Swift wrapper around the Trefle API."
  s.homepage     = "https://github.com/Baza207/TrefleSwiftSDK"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "James Barrow" => "james@pigonahill.com" }
  s.platform     = :ios
  s.ios.deployment_target = "12.0"
  s.source       = { :git => "https://github.com/Baza207/TrefleSwiftSDK.git", :tag => "#{s.version}" }
  s.source_files = "Source/**/*.swift"
  s.exclude_files = 'Tests/**/TestConfig.{json}'
  s.swift_version = "5.1"

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.swift'
  end
end
