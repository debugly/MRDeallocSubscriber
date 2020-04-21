//
//  MRBlockSubscriber.h
//  MRDeallocSubscriber
//
//  Created by Matt Reach on 2020/4/21.
//

#import <Foundation/Foundation.h>
#import "MRSubscriberProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MRBlockSubscriber : NSObject <MRSubscriberProtocol>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithBlock:(void(^)(void))block NS_DESIGNATED_INITIALIZER;
+ (instancetype)subscriberWithBlock:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
