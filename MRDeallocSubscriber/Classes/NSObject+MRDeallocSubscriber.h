//
//  NSObject+MRDeallocSubscriber.h
//  MRDeallocSubscriber
//
//  Created by Matt Reach on 2020/4/21.
//

#import <Foundation/Foundation.h>
#import "MRSubscriberProtocol.h"

typedef void(^MROnDeallocBlock)(void);

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(macos(10.6), ios(6.0))
@interface NSObject (MRDeallocSubscriber)

/// 向调用对象添加dealloc事件若引用订阅者，
/// @param suber 订阅者，内部不会持有 suber
- (void)mr_addDeallocSubscriber:(id<MRSubscriberProtocol>)suber;

/// 从调用对象移除dealloc事件若引用订阅者
/// @param suber 订阅者
- (void)mr_removeDeallocSubscriber:(id<MRSubscriberProtocol>)suber;


/// 向调用对象添加dealloc事件强引用订阅者，
/// @param suber 订阅者，内部会持有 suber
- (void)mr_addStrongDeallocSubscriber:(id<MRSubscriberProtocol>)suber;

/// 从调用对象移除dealloc事件强引用订阅者
/// @param suber 订阅者
- (void)mr_removeStrongDeallocSubscriber:(id<MRSubscriberProtocol>)suber;


/// 向调用对象添加dealloc事件强引用订阅Block，
/// @param block 当调用对象销毁时，回调这个block
/// @return 内部生成的私有对象，可通过该对象，取消block类型的订阅
- (id<MRSubscriberProtocol>)mr_addDeallocBlock:(MROnDeallocBlock)block;

/// 从调用对象移除dealloc事件强引用订阅Block，
/// @param suber 调用 mr_addDeallocBlock 的返回值
- (void)mr_removeDeallocBlock:(id<MRSubscriberProtocol>)suber;

@end

NS_ASSUME_NONNULL_END
