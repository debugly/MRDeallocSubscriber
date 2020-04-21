//
//  MRSubscriberProtocol.h
//  MRDeallocSubscriber
//
//  Created by Matt Reach on 2020/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MRSubscriberProtocol <NSObject>

///被订阅者dealloc的时候调用该方法
- (void)mr_onDeallocPublish;

@end

NS_ASSUME_NONNULL_END
