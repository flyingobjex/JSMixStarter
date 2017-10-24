# Uncomment the next line to define a global platform for your project
platform :ios, '9.1'

target 'JSMixStarter' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for JSMixStarter

  target 'JSMixStarterTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
  end

  target 'JSMixStarterUITests' do
    inherit! :search_paths
    # Pods for testing
  end

   # Manually making Quick compiler version be swift 3.2
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.name == 'Quick' || target.name == 'Nimble'
        print "Changing Quick swift version to 3.2\n"
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '3.2'
        end
      end
    end
  end

end
