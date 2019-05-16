//
//  MBAboutViewController.m
//  MoneyEasy
//
//  Created by Bing Ma on 15/11/3.
//  Copyright © 2015 Bing Ma. All rights reserved.
//

#import "MBAboutViewController.h"

@interface MBAboutViewController ()
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation MBAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (IS_iPhoneX) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, -44, kScreenWidth, 44)];
        v.backgroundColor = [UIColor blackColor];
        [self.view addSubview:v];
    }

    self.view.backgroundColor = [UIColor blackColor];
    
    [self addGroup0];

    
    // add header view.
    UIView *headerView =  [[[NSBundle mainBundle] loadNibNamed:@"MBAboutHeaderView" owner:nil options:nil] lastObject];
    self.tableView.tableHeaderView = headerView;
    
    
    UIButton *btn = [headerView viewWithTag:998];
    [btn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.scrollEnabled = NO;
}

- (void)backVC {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addGroup0 {
//    MBSettingItem *item1 = [MBSettingArrowItem itemWithImage:nil title:@"平分支持"];
//    item1.option = ^{
//        NSString *appid = @"1250283026";
//        NSString *str = [NSString stringWithFormat:
//                         @"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//    };
    
    
    MBSettingItem *item2 = [MBSettingArrowItem itemWithImage:nil title:@"微信公众号"];
    item2.subTitle = @"zhuishuvip";
    //    item2.option = ^{
    //        /*
    //         //         NSString *str = @"tel://18621515491";
    //         NSString *str = @"telprompt://18621515491";
    //         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //         */
    //        if (_webView == nil) {
    //            _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    //        }
    //        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://10010"]]];
    //        
    //    };
    
    
    [self.datas addObject:@[item2]];
}

@end

