//
//  MRTask.m
//  MRDeallocSubscriber_Example
//
//  Created by Matt Reach on 2020/4/21.
//  Copyright © 2020 summerhanada@163.com. All rights reserved.
//
// 模拟耗时操作

#import "MRTask.h"

@implementation MRTask

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"MRTask [%@] 销毁了",self.name);
}

- (void)cancel
{
    NSLog(@"耗时操作已经取消！");
}

- (void)mr_onDeallocPublish
{
    [self cancel];
}

@end
