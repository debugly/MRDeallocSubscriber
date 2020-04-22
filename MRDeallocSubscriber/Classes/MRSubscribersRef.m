//
//  MRSubscribersRef.m
//  MRDeallocSubscriber
//
//  Created by Matt Reach on 2020/4/21.
//

#import "MRSubscribersRef.h"

@interface MRSubscribersRef ()

@property (nonatomic, strong) NSHashTable *subscriberTable;
@property (nonatomic, assign) BOOL useWeak;

@end

@implementation MRSubscribersRef

- (instancetype)initWithWeakMemory:(BOOL)useWeak
{
    self = [super init];
    if (self) {
        self.useWeak = useWeak;
    }
    return self;
}

+ (instancetype)weakSubscribersRef
{
    return [[self alloc] initWithWeakMemory:YES];
}

+ (instancetype)strongSubscribersRef
{
    return [[self alloc] initWithWeakMemory:NO];
}

- (NSHashTable *)subscriberTable
{
    if (!_subscriberTable) {
        _subscriberTable = [NSHashTable hashTableWithOptions:self.useWeak ? NSPointerFunctionsWeakMemory : NSPointerFunctionsStrongMemory];
    }
    return _subscriberTable;
}

- (void)dealloc
{
    if (_subscriberTable) {
        [[_subscriberTable allObjects] enumerateObjectsUsingBlock:^(id<MRSubscriberProtocol>sub, NSUInteger idx, BOOL * _Nonnull stop) {
            [sub mr_onDeallocPublish];
        }];
        [_subscriberTable removeAllObjects];
    }
}

- (void)addSubscriber:(id<MRSubscriberProtocol>)sub
{
    [self.subscriberTable addObject:sub];
}

- (void)removeSubscriber:(id<MRSubscriberProtocol>)sub
{
    [self.subscriberTable removeObject:sub];
}

@end
