# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'Minesweeper 3D' do
  use_frameworks!

  # Pods for Minesweeper 3D
  pod 'SwiftLint'
  pod 'Bond'
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
    end
  end
end
