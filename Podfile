# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'iOS-Template' do
  # Comment the next line if you don't want to use dynamic frameworks
  platform :ios, '14.4'
  use_frameworks!

  # Pods for ios-template
  pod 'SwiftLint'
  pod 'SwiftGen', '~> 6.1'
  pod 'SnapKit', '~> 5.0'
  pod 'RxSwift', '~> 4.0'
  pod 'RxCocoa', '~> 4.0'

  target 'iOS-TemplateTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOS-TemplateUITests' do
    # Pods for testing
  end

end

# Remove iOS 8 support, mentioned here:
## https://developer.apple.com/forums/thread/656616
post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
  end
 end
end
