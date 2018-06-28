# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'RiverRecording' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!
  
  # Pods for RiverRecording
  pod 'Firebase/Core'
  pod 'IGListKit'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'SnapKit'

  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if ['RxCocoa', 'SnapKit'].include? target.name
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '4.0'
              end
          end
      end
  end

  target 'RiverRecordingTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RiverRecordingUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  


end
