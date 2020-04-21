//
//  MRSubscribersRef.h
//  MRDeallocSubscriber
//
//  Created by Matt Reach on 2020/4/21.
//

#import <Foundation/Foundation.h>
#import "MRSubscriberProtocol.h"

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(macos(10.6), ios(6.0))
@interface MRSubscribersRef : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithWeakMemory:(BOOL)useWeak NS_DESIGNATED_INITIALIZER;
+ (instancetype)weakSubscribersRef;
+ (instancetype)strongSubscribersRef;

- (void)addSubscriber:(id<MRSubscriberProtocol>)sub;
- (void)removeSubscriber:(id<MRSubscriberProtocol>)sub;

@end

NS_ASSUME_NONNULL_END
