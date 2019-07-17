project 'SwiftStudy.xcodeproj'

# Uncomment the next line to define a global platform for your project
# platform :ios, '8.0'

target 'SwiftStudy' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    pod "Alamofire" 
    pod "HandyJSON"
    pod "Kingfisher"
    pod "MJRefresh"
    pod "Moya"
    pod "SnapKit"
    #播放网络音频
    pod "StreamingKit"
    pod "SVProgressHUD"
     #消息提示
    pod "SwiftMessages", "~> 6.0.2" 
    pod 'FSPagerView'
    pod "SwiftyJSON"
    pod 'ESTabBarController-swift', '~> 2.6.2'
    pod 'DNSPageView', '~> 1.0.1'
    #跑马灯 
    pod 'JXMarqueeView'
    pod 'LTScrollView', '~> 0.2.0'


end


post_install do |installer|

     installer.pods_project.targets.each do |target|

          target.build_configurations.each do |config|

               config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.2'

          end

      end

end


