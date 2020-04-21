//
//  MRTask.h
//  MRDeallocSubscriber_Example
//
//  Created by Matt Reach on 2020/4/21.
//  Copyright © 2020 summerhanada@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MRDeallocSubscriber/MRSubscriberProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRTask : NSObject <MRSubscriberProtocol>

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
