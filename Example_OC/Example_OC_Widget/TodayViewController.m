//
//  TodayViewController.m
//  Example_OC_Widget
//
//  Created by light on 2018/5/17.
//  Copyright © 2018年 light. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 10.0, *)){
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

/**
  ios(10.0)
 activeDisplayMode有以下两种
      NCWidgetDisplayModeCompact, // 收起模式
      NCWidgetDisplayModeExpanded, // 展开模式
 
  */
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize  API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10.0, *)) {
        if(activeDisplayMode == NCWidgetDisplayModeCompact) {
            // 尺寸只设置高度即可，因为宽度是固定的，设置了也不会有效果
            self.preferredContentSize = CGSizeMake(0, 110);
        }else{
            self.preferredContentSize = CGSizeMake(0, 500);
        }
    } else {
        // Fallback on earlier versions
    }
}

@end
