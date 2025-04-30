platform :ios, '15.0'

target 'XXObjCKit' do
  # Comment the next line if you don't want to use dynamic frameworks
  #use_frameworks!
  pod 'AFNetworking'
  pod 'ReactiveObjC'    , :git => 'https://github.com/xygkevin/ReactiveObjC.git', :branch => 'master'

end

# 1.hook 配置, 在 preparing 阶段后，install 之前
#pre_install do |installer|
#    
#end

# 2.hook 配置，在 pod install 之后，可用于修改工程配置等
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = '$(inherited)'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
            config.build_settings['ENABLE_BITCODE'] = 'NO'
#            config.build_settings['DEAD_CODE_STRIPPING'] = 'YES'
            config.build_settings['CODE_SIGN_IDENTITY'] = ''
        end
    end
end
