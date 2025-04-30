Pod::Spec.new do |spec|
  spec.name         = "XXNetworkHelper"
  spec.version      = "0.0.1"
  spec.summary      = "XXNetworkHelper is a lightweight, chainable Objective-C HTTP networking wrapper based on NSURLSession, designed for simplicity, performance, and modern iOS practices."
  spec.description  = <<-DESC
                   XXNetworkHelper is a lightweight and extensible Objective-C networking utility built on top of NSURLSession. It simplifies the process of making HTTP requests by providing a clean and chainable API, while offering flexible configuration, request/response interceptors, and detailed logging. Designed for modern iOS development, it supports JSON requests, file uploads, automatic retry logic, network reachability integration, and more..
                   DESC
  spec.homepage     = "https://github.com/xygkevin/XXObjCKit"
  spec.license      = "MIT (example)"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "许亚光" => "xu_yaguang@163.com" }
  spec.platform     = :ios, "15.0"
  spec.source       = { :git => "https://github.com/xygkevin/XXObjCKit.git", :tag => "#{spec.version}" }
  spec.source_files = "XXObjCKit/Source/Network/XXNetworkHelper.{h,m}"
  spec.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }
  spec.requires_arc = true
  spec.dependency  'AFNetworking'
  spec.dependency  'ReactiveObjC'

end
