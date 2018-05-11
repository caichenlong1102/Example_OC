//
//  TestViewController.m
//  Example_OC
//
//  Created by light on 2018/5/7.
//  Copyright © 2018年 light. All rights reserved.
//

#import "TestViewController.h"

#import "TableViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

#pragma mark ------LifeCicle------

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addTimer];
//    [self createObserver];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------UIButtonAction------

- (IBAction)goTableViewAction:(id)sender {
    TableViewController *tableVC = [[TableViewController alloc]init];
    tableVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tableVC animated:YES];
}


#pragma mark ------RunLoopTest------
- (void)addTimer{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)timerTest{
    NSLog(@"timerTest----");
}

- (void)createObserver{
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"--------%zd", activity);
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);  // 添加监听者，关键！
    CFRelease(observer); // 释放
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
