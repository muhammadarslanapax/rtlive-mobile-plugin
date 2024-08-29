#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ugsv_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ugsv_flutter'
  s.version          = '1.0.0'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.resource_bundles = {
    'UGSVFlutterResources' => ['Localizable/**/*']
  }

  s.dependency "AFNetworking"
  s.dependency "MJRefresh"
  s.dependency "MBProgressHUD"
  s.dependency "SDWebImage"
  s.dependency 'QCloudQuic'
  s.dependency 'QCloudCOSXML/Slim','6.2.6'
  s.dependency 'XMagic','2.5.0.250'
  s.dependency 'Bugly'
  s.dependency 'UGCKit/Professional'
  s.dependency 'TXLiteAVSDK_Professional'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
