//
//  NSObject+MRDeallocSubscriber.m
//  MRDeallocSubscriber
//
//  Created by Matt Reach on 2020/4/21.
//

#import "NSObject+MRDeallocSubscriber.h"
#import "MRSubscribersRef.h"
#import "objc/runtime.h"
#import "MRBlockSubscriber.h"

@implementation NSObject (MRDeallocSubscriber)

- (void)mr_addDeallocSubscriber:(id<MRSubscriberProtocol>)suber
{
    if (!suber || ![suber respondsToSelector:@selector(mr_onDeallocPublish)]) {
        NSAssert(NO, @"must implementation -[mr_onDeallocPublish]");
        return;
    }
    
    [[self mr_weakSubscribersRef] addSubscriber:suber];
}

- (void)mr_removeDeallocSubscriber:(id<MRSubscriberProtocol>)suber
{
    [[self mr_weakSubscribersRef] removeSubscriber:suber];
}

- (void)mr_addStrongDeallocSubscriber:(id<MRSubscriberProtocol>)suber
{
    if (!suber || ![suber respondsToSelector:@selector(mr_onDeallocPublish)]) {
        NSAssert(NO, @"must implementation -[mr_onDeallocPublish]");
        return;
    }
    
    [[self mr_strongSubscribersRef] addSubscriber:suber];
}

- (void)mr_removeStrongDeallocSubscriber:(id<MRSubscriberProtocol>)suber
{
    [[self mr_strongSubscribersRef] removeSubscriber:suber];
}

- (id<MRSubscriberProtocol>)mr_addDeallocBlock:(MROnDeallocBlock)block
{
    MRBlockSubscriber *suber = [MRBlockSubscriber subscriberWithBlock:block];
    [[self mr_strongSubscribersRef] addSubscriber:suber];
    return suber;
}

- (void)mr_removeDeallocBlock:(id<MRSubscriberProtocol>)suber
{
    [[self mr_strongSubscribersRef] removeSubscriber:suber];
}

- (MRSubscribersRef *)mr_weakSubscribersRef
{
    MRSubscribersRef *ref = objc_getAssociatedObject(self, _cmd);
    if (!ref) {
        ref = [MRSubscribersRef weakSubscribersRef];
        objc_setAssociatedObject(self, _cmd, ref, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return ref;
}

- (MRSubscribersRef *)mr_strongSubscribersRef
{
    MRSubscribersRef *ref = objc_getAssociatedObject(self, _cmd);
    if (!ref) {
        ref = [MRSubscribersRef strongSubscribersRef];
        objc_setAssociatedObject(self, _cmd, ref, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return ref;
}

@end
