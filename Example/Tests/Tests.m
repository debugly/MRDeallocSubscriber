//
//  MRDeallocSubscriberTests.m
//  MRDeallocSubscriberTests
//
//  Created by summerhanada@163.com on 04/21/2020.
//  Copyright (c) 2020 summerhanada@163.com. All rights reserved.
//

@import XCTest;
#import "MRTask.h"
#import <MRDeallocSubscriber/NSObject+MRDeallocSubscriber.h>

@interface Tests : XCTestCase

@property (nonatomic, strong) MRTask *request;
@property (nonatomic, weak) MRTask *weakrequest;
@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.request = [[MRTask alloc] initWithName:@"耗时任务1，我被 Tests 持有了,没有被testObj持有"];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    ///check for testDeallocEventWithWeakProtocolObj method
    XCTAssertNil(self.weakrequest);
    XCTAssertNotNil(self.request);
    self.request = nil;
}

- (void)testDeallocEventWithBlock
{
    NSObject *testObj = [NSObject new];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Block should be invoke"];
    [testObj mr_addDeallocBlock:^{
        [expectation fulfill];
    }];
    testObj = nil;
    
    [self waitForExpectationsWithTimeout:2 handler:NULL];
}

- (void)testDeallocEventWithStrongProtocolObj
{
    NSObject *testObj = [NSObject new];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Block should be invoke"];
    
    MRTask *req = [[MRTask alloc] initWithName:@"耗时任务2，我通过强引用订阅方式，获取到了跟 testObj 对象相同的声明周期"];
    [req onCanceld:^{
        [expectation fulfill];
    }];
    
    [testObj mr_addStrongDeallocSubscriber:req];
    
    testObj = nil;
    [self waitForExpectationsWithTimeout:2 handler:NULL];
}

- (void)testDeallocEventWithWeakProtocolObj
{
    NSObject *testObj = [NSObject new];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Block should be invoke"];
    
    MRTask *req = [[MRTask alloc] initWithName:@"耗时任务3，我通过强引用订阅方式，获取到了跟 testObj 对象相同的声明周期"];
    
    [req onCanceld:^{
        [expectation fulfill];
    }];
    [testObj mr_addDeallocSubscriber:req];
    ///赋值给weakrequest属性，等测试结束后判断是否为nil，来证明确实销毁了
    self.weakrequest = req;
    testObj = nil;
    [self waitForExpectationsWithTimeout:2 handler:NULL];
}

- (void)testRemoveDeallocEventWithWeakProtocolObj
{
    NSObject *testObj = [NSObject new];
    [self.request onCanceld:^{
        NSLog(@"不应该走这里");
        XCTAssert(NO);
    }];
    [testObj mr_addDeallocSubscriber:self.request];
    [testObj mr_removeDeallocSubscriber:self.request];
    
    testObj = nil;
}

- (void)testRemoveDeallocEventWithBlock
{
    NSObject *testObj = [NSObject new];
    id<MRSubscriberProtocol> sub = [testObj mr_addDeallocBlock:^{
        NSLog(@"不应该走这里");
        XCTAssert(NO);
    }];
    [testObj mr_removeDeallocBlock:sub];
    
    testObj = nil;
}


@end

