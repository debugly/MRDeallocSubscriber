//
//  MRViewController.m
//  MRDeallocSubscriber
//
//  Created by summerhanada@163.com on 04/21/2020.
//  Copyright (c) 2020 summerhanada@163.com. All rights reserved.
//

#import "MRViewController.h"
#import <MRDeallocSubscriber/NSObject+MRDeallocSubscriber.h>
#import "MRTask.h"

@interface MRViewController ()

@property (nonatomic, strong) NSObject *testObj;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) MRTask *request;

@end

@implementation MRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.text = @"";
    self.testObj = [NSObject new];
    [self showMsg:@"创建testObj，等待来订阅"];
    self.request = [[MRTask alloc] initWithName:@"耗时任务1，我被 ViewController 持有了,没有被testObj持有"];
    [self.request onCanceld:^{
        [self showMsg:@"耗时任务1 被 ViewController 持有着，所以只是取消"];
    }];
    
    [self showMsg:@"耗时任务1，开始执行了"];
}

- (void)showMsg:(NSString *)msg
{
    self.textView.text = [self.textView.text stringByAppendingFormat:@"%@\n\n",msg];
}

- (IBAction)onClicked:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    if (tag == 1000) {
        
        [self.testObj mr_addDeallocBlock:^{
            [self showMsg:@"Block订阅回调了\n\n"];
        }];
        
        [self showMsg:@"通过Block订阅了testObj的销毁事件"];
        
    } else if (tag == 2000) {
        MRTask *req = [[MRTask alloc] initWithName:@"耗时任务2，我通过强引用订阅方式，获取到了跟 testObj 对象相同的声明周期"];
        [req onCanceld:^{
            [self showMsg:@"绑定对象被销毁了，因此耗时任务2 也被销毁"];
        }];
        
        [self.testObj mr_addStrongDeallocSubscriber:req];
        
        [self showMsg:req.name];
    } else if (tag == 3000) {
        [self.testObj mr_addDeallocSubscriber:self.request];
        [self showMsg:self.request.name];
    } else if (tag == 4000) {
        
        [self showMsg:@"--------------------"];
        [self showMsg:@"[testObj] 销毁了"];
        self.testObj = nil;
    }
}

@end
