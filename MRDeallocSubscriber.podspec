#
# Be sure to run `pod lib lint MRDeallocSubscriber.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MRDeallocSubscriber'
  s.version          = '0.1.0'
  s.summary          = 'Objective-C Object dealloc event subscriber.(Objective-C 对象析构事件订阅者)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.requires_arc     = true
  s.description      = <<-DESC
If you want auto "cancel" obj B's method when obj A dealloc, You can let obj B subscribe the obj A's dealloc event by block or B confirm MRSubscriberProtocol.
If you want "bind" obj A to obj B，require them have same lifecycle，you can use strong subscriber.
(如果你想在obj A 析构时，自动调用 obj B 的方法时，可以让 B 去订阅 A 的析构事件来实现。
 如果你想将 obj A 和 obj B “绑定”，已达到他们的生命周期相同的目的，那么你可以使用强引用订阅。)
                       DESC

  s.homepage         = 'https://github.com/debugly/MRDeallocSubscriber'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MattReach' => 'qianlongxu@gmail.com' }
  s.source           = { :git => 'https://github.com/debugly/MRDeallocSubscriber.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.5'
  s.source_files = 'MRDeallocSubscriber/Classes/**/*'
  s.public_header_files = 'MRDeallocSubscriber/Classes/MRSubscriberProtocol.h', 'MRDeallocSubscriber/Classes/NSObject+MRDeallocSubscriber.h'
  
end
