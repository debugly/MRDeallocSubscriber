//
//  MRBlockSubscriber.m
//  MRDeallocSubscriber
//
//  Created by Matt Reach on 2020/4/21.
//

#import "MRBlockSubscriber.h"

@interface MRBlockSubscriber ()

@property (nonatomic, copy) void(^MROnDeallocBlock)(void);

@end

@implementation MRBlockSubscriber
 
- (instancetype)initWithBlock:(void(^)(void))block
{
    self = [super init];
    if (self) {
        self.MROnDeallocBlock = block;
    }
    return self;
}

+ (instancetype)subscriberWithBlock:(void(^)(void))block
{
    return [[self alloc] initWithBlock:block];
}

- (void)mr_onDeallocPublish {
    if (self.MROnDeallocBlock) {
        self.MROnDeallocBlock();
    }
}

@end
