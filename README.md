# MRDeallocSubscriber

[![CI Status](https://img.shields.io/travis/debugly/MRDeallocSubscriber.svg?style=flat)](https://travis-ci.org/debugly/MRDeallocSubscriber)
[![Version](https://img.shields.io/cocoapods/v/MRDeallocSubscriber.svg?style=flat)](https://cocoapods.org/pods/MRDeallocSubscriber)
[![License](https://img.shields.io/cocoapods/l/MRDeallocSubscriber.svg?style=flat)](https://cocoapods.org/pods/MRDeallocSubscriber)
[![Platform](https://img.shields.io/cocoapods/p/MRDeallocSubscriber.svg?style=flat)](https://cocoapods.org/pods/MRDeallocSubscriber)

**Objective-C Object dealloc event subscriber.**

- If you want auto "invoke" obj B's method when obj A dealloc, You can let obj B subscribe the obj A's dealloc event by block or B confirm MRSubscriberProtocol.

- If you want "bind" obj A to obj B，require them have same lifecycle，you can use strong subscriber.

Specific scenes

- cancel network request
- invidate timers
- send statistics
- dealloc clean etc.

**OC 对象 dealloc 事件订阅器。**

- 如果你想在obj A 析构时，自动调用 obj B 的方法时，可以让 B 去订阅 A 的析构事件来实现
	- 1、可以通过 block 形式订阅 A 的析构事件，在 block 里调用 B 的相应方法
	- 2、可以让 obj B 遵循 MRSubscriberProtocol 协议，在协议方法里调用相应方法
- 如果你想将 obj A 和 obj B “绑定”，已达到他们的生命周期相同的目的，那么你可以使用强引用订阅
	- 其他对象不要强引用 obj B , 让 obj B 以强引用的形式去订阅 obj A 的析构方法
- 默认订阅是弱引用形式的。

**具体使用场景：**

- 取消网络请求，避免请求回调带来的副作用
- 取消定时器
- 发送行为统计
- 其他销毁时清理行为

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

示例程序，对强、若引用的订阅均做了演示，关于到底使用哪个，取决于订阅对象本身的控制权。

## Requirements

Available macOS(10.6) and iOS(6.0).

## Installation

MRDeallocSubscriber is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MRDeallocSubscriber'
```

## License

MRDeallocSubscriber is available under the MIT license. See the LICENSE file for more info.
