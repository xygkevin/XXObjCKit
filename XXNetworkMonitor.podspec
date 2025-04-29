Pod::Spec.new do |spec|

  spec.name         = "XXNetworkMonitor"
  spec.version      = "0.0.1"
  spec.summary = 'A network monitoring utility for iOS using NWPathMonitor, supporting network type and reachability detection.'
  spec.description  = <<-DESC
  		     XXNetworkMonitor is an Objective-C SDK that provides real-time detection of network status, connection type (WiFi/Cellular), and constraints using Apple's Network framework.
                   DESC
  spec.homepage     = "https://github.com/xygkevin/XXObjCKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "许亚光" => "xu_yaguang@163.com" }
  spec.platform     = :ios, "15.0"
  spec.source       = { :git => "https://github.com/xygkevin/XXObjCKit.git", :tag => "#{spec.version}" }

  spec.source_files  = "XXObjCKit/Source/Network/XXNetworkMonitor.{h,m}"
  spec.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }
  spec.framework  = "Network"
  spec.requires_arc = true


end
