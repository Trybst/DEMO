//
//  RootController.m
//  Reader
//
//  Created by Bing Ma on 2017/1/24.
//  Copyright © 2017年 Hannb. All rights reserved.
//

#import "RootController.h"
#import "YLeftViewController.h"
#import "YRightViewController.h"
#import "YCenterViewController.h"
#import "YSearchViewController.h"
#import "YRankingViewController.h"
#import "FREvent.h"
#import "CommonMenuView.h"
#import "MBAboutViewController.h"
#import "MBWebVC.h"
#import "MBHTTPManager.h"
#import "AFHTTPSessionManager.h"
#import <Crashlytics/Crashlytics.h>

#import "YBookCatsViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKiPhoneDefaultShareViewUI/ShareSDKiPhoneDefaultShareViewUI.h>
#define kLeftAnimationDuration 0.25
#define kRightAnimationDuration 0.5
#define kLeftViewWidth 80
#define kRightViewWidth kScreenWidth*0.6

@import GoogleMobileAds;
@interface RootController ()<GADInterstitialDelegate, GADBannerViewDelegate> {
    NSArray *_dataArray;
}

@property (strong, nonatomic) YCenterViewController *centerVC;
@property (strong, nonatomic) YLeftViewController *leftVC;
@property (strong, nonatomic) YRightViewController *rightVC;
@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;
@property (strong, nonatomic) UIView *closeView;
@property (assign, nonatomic) YShowState currentShow;
@property (assign, nonatomic) BOOL hasLoad;

@property(nonatomic, strong) GADInterstitial *interstitial;
@property (nonatomic, strong) GADBannerView *bannerView;

@property(strong,nonatomic)UIWindow *window;
@property(strong,nonatomic)UIButton *button;

@end

@implementation RootController

//- (void)viewSafeAreaInsetsDidChange {
//    [super viewSafeAreaInsetsDidChange];
//
////    if (@available(iOS 11.0, *)) {
////        self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 34, 0);
////    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    // interstitial ad.
    self.interstitial.delegate = self;
//    self.interstitial = [self createAndLoadInterstitial];
    
    [self setupUI];
    
    __weak typeof(self) wself = self;
    self.centerVC.tapBarButton = ^(YShowState state) {
        [wself moveToVCWith:state];
    };
    
    self.rightVC.selectCell = ^(NSInteger index) {
        
        switch (index) {
            case 0: {
                YSearchViewController *vc = [[YSearchViewController alloc] init];
                [wself.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1: {
                YBookCatsViewController *vc = [UIStoryboard storyboardWithName:@"YBookCatsViewController" bundle:[NSBundle mainBundle]].instantiateInitialViewController; //[[YBookCatsViewController alloc] init];
                [wself.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 2: {
                YRankingViewController *vc = [[YRankingViewController alloc] init];
                [wself.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
    };
    
//    NSDictionary *dict1 = @{@"imageName" : @"home_classes",
//                            @"itemName" : @" 设置"
//                            };
    NSDictionary *dict2 = @{@"imageName" : @"home_share",
                            @"itemName" : @" 分享"
                            };
    NSDictionary *dict3 = @{@"imageName" : @"home_about",
                            @"itemName" : @"关于"
                            };
    NSArray *dataArray = @[dict2, dict3];
    _dataArray = dataArray;
    
    [CommonMenuView createMenuWithFrame:CGRectZero target:self dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        [wself doSomething:(NSString *)str tag:(NSInteger)tag]; // do something
    } backViewTap:^{
    }];
    
    AFNetworkReachabilityManager *reachMgr = [AFNetworkReachabilityManager sharedManager];
    [reachMgr startMonitoring];
    [reachMgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable || status == AFNetworkReachabilityStatusUnknown) {
            [YProgressHUD showErrorHUDWith:@"亲～ 网络异常，请查看！"];
        }
    }];
    
    [self registerNotifiction];
}

- (GADInterstitial *)createAndLoadInterstitial {
    
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:kINV_ID];
    interstitial.delegate = self;
    
    if ((random() % 10) == 1) {
        [interstitial loadRequest:[GADRequest request]];
    }
    
    return interstitial;
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    
    [self.interstitial presentFromRootViewController:self];
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    if ((random() % 3) == 1) {
        [self createButton];
    }
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    [self resignWindow];
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    [self resignWindow];
}

- (void)createButton
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"精品推荐 18s" forState:UIControlStateNormal];
    _button.frame = CGRectMake(0, IS_iPhoneX ? 44 : 0, kScreenWidth, 64);
//    [_button addTarget:self action:@selector(resignWindow) forControlEvents:UIControlEventTouchUpInside];
    
    [self setTheCountdownButton:_button startWithTime:18 title:@"精品推荐" countDownTitle:@"s" mColor:[UIColor whiteColor] countColor:[UIColor blackColor]];
    
    _window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64 + (IS_iPhoneX ? 44 : 0))];
    _window.windowLevel = UIWindowLevelAlert+1;
    _window.backgroundColor = [UIColor blackColor];
    _window.layer.cornerRadius = 1;
    _window.layer.masksToBounds = YES;
    [_window addSubview:_button];
    [_window makeKeyAndVisible];//关键语句,显示window
}

/**
 *  关闭悬浮的window
 */
- (void)resignWindow {
    [_window resignKeyWindow];
    _window = nil;
}

#pragma mark - button's action view
- (void)setTheCountdownButton:(UIButton *)button startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    __weak __typeof__(self) weakSelf = self;
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(_timer, ^{
        
        if (timeOut == 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf resignWindow];
            });
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.1d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = color;
                [button setTitle:[NSString stringWithFormat:@"精品推荐 (%@) %@",timeStr,subTitle]forState:UIControlStateNormal];
                button.userInteractionEnabled =NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_hasLoad) {
        _hasLoad = YES;
        [self.centerVC autoRefreshbooks];
    }
}

- (void)setupUI {
    self.centerVC = [[YCenterViewController alloc] init];
    self.leftVC = [[YLeftViewController alloc] init];
    self.rightVC = [[YRightViewController alloc] init];
    self.centerVC.view.frame = self.view.bounds;
    self.leftVC.view.frame = self.view.bounds;
    self.rightVC.view.frame = self.view.bounds;
    [self.centerView addSubview:self.centerVC.view];
    [self.view addSubview:self.centerView];
}

- (void)moveToVCWith:(YShowState)state {
    
    if (state == YShowStateMenu) {
        [CommonMenuView showMenuAtPoint: IS_iPhoneX ? CGPointMake(25, 84) : CGPointMake(25, 60)];
        return;
    }
    
    [self prepareViewWith:state];
    NSTimeInterval duration = state == YShowStateRight ? kRightAnimationDuration : 0;
    CGFloat left = state == YShowStateRight ? -kRightViewWidth : 0;
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:10 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.centerView.left = left;
        
    } completion:^(BOOL finished) {
        [self.centerView addSubview:self.closeView];
        self.currentShow = state;
    }];
}

- (void)prepareViewWith:(YShowState)state {
    if (state == YShowStateRight) {
        [self.rightView addSubview:self.rightVC.view];
        [self.view insertSubview:self.rightView belowSubview:self.centerView];
    }
}

- (UIView *)centerView {
    if (_centerView == nil) {
        _centerView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _centerView;
}

- (UIView *)leftView {
    if (_leftView == nil) {
        _leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _leftView;
}

- (UIView *)rightView {
    if (_rightView == nil) {
        _rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _rightView;
}

- (UIView *)closeView {
    if (_closeView == nil) {
        _closeView = [[UIView alloc] initWithFrame:self.view.bounds];
        [_closeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCloseView)]];
        [_closeView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)]];
    }
    return _closeView;
}

- (void)handleCloseView {
    [UIView animateWithDuration:kLeftAnimationDuration animations:^{
        self.centerView.left = 0;
    } completion:^(BOOL finished) {
        [self.closeView removeFromSuperview];
        [self.leftView removeFromSuperview];
        [self.rightView removeFromSuperview];
    }];
}

- (void)handlePanGesture:(UIPanGestureRecognizer*)panGesture
{
    UIGestureRecognizerState state = panGesture.state;
    CGPoint translation = [panGesture translationInView:self.view];
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            self.currentShow = self.centerView.left > 0 ? YShowStateLeft : YShowStateRight;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGRect centerFrame = self.centerView.frame;
            centerFrame.origin.x += translation.x;
            BOOL shouldClose = NO;
            if (self.currentShow == YShowStateRight) {
                if (centerFrame.origin.x >= 0) {
                    centerFrame.origin.x = 0;
                    shouldClose = YES;
                }
            } else {
                if (centerFrame.origin.x <= 0) {
                    centerFrame.origin.x = 0;
                    shouldClose = YES;
                }
            }
            self.centerView.frame = centerFrame;
            if (shouldClose) {
                [self handleCloseView];
            }
        }
            break;
        default: {
            BOOL shouldClose = YES;
            CGFloat left = 0.0;
            if (self.currentShow == YShowStateLeft) {
                if (self.centerView.left > kLeftViewWidth/2) {
                    shouldClose = NO;
                    left = kLeftViewWidth;
                }
            } else if (self.currentShow == YShowStateRight) {
                if (self.centerView.left < -kRightViewWidth/2) {
                    shouldClose = NO;
                    left = -kRightViewWidth;
                }
            }
            
            if (shouldClose) {
                [self handleCloseView];
            } else {
                [UIView animateWithDuration:self.currentShow == YShowStateLeft ? kLeftAnimationDuration / 2.0 : kRightAnimationDuration / 2.0 animations:^{
                    self.centerView.left = left;
                }];
            }
        }
            break;
    }
    [panGesture setTranslation:CGPointZero inView:self.view];
}

#pragma mark - menu ui.

- (void)doSomething:(NSString *)str tag:(NSInteger)tag{

    if (tag == 1) {
        [self shareSDKUI];
    } else if (tag == 2) {
        MBAboutViewController *aboutVc = [[MBAboutViewController alloc] init];
        aboutVc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:aboutVc animated:YES];
    }
    
    [CommonMenuView hidden];
}

- (void)shareSDKUI {
    [CommonMenuView hidden];

    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"share_logo"  ofType:@"png"];  //make sure you actually have the picture in your project

    id<ISSContent> publishContent = [ShareSDK content:@"追书神器！百万小说，极速更新，免费阅读！全站阅读无广告，多维推荐送好书！下载地址：https://itunes.apple.com/cn/app/id1250283026?mt=8 "
                                       defaultContent:@"百万小说，免费阅读！"                                                                             image:[ShareSDK imageWithPath:imagePath]
                                                title:@"快·读 - 百万免费小说，追书阅读神器！"
                                                  url:@"https://itunes.apple.com/cn/app/id1250283026?mt=8"
                                          description:@"细细品味，感悟人生！"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //show share content view
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end)
    {
        if (state == SSResponseStateSuccess)
        {
            NSLog(@"Share Success!");
        }
        else if (state == SSResponseStateFail)
        {
            NSLog(@"Share Fail,Error code:%ld,Error description:%@", (long)[error errorCode], [error errorDescription]);
        }                             
    }];
}

#pragma mark - network setting.
- (void)showNetworkError {
    UIAlertView *altV = [[UIAlertView alloc]initWithTitle:@"网络异常，请检查网络设置！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"重试", @"前往设置", nil];
    altV.tag = 966;
    [altV show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 966) {
        if (buttonIndex == 0) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"true" forKey:@"is_show"];
            [defaults synchronize];
            
        } else {
            
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
            }
        }
        
    }
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView {
    [self resignWindow];
}

- (void)setBanner {
    self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(8, 16, kScreenWidth-16, 49)];
    self.bannerView.adUnitID = kBANNER_ID;
    self.bannerView.rootViewController = self;
    _bannerView.delegate = self;
    GADRequest *req = [GADRequest request];
    [self.bannerView loadRequest:req];
    [self.view addSubview:_bannerView];
    
    UIButton *c = [[UIButton alloc] initWithFrame:CGRectMake(8, 16, 10, 10)];
    [c setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [c addTarget:self action:@selector(resignWindow) forControlEvents:UIControlEventTouchUpInside];
    
    _window = [[UIWindow alloc]initWithFrame:CGRectMake(0, kScreenHeight - 49-16 - (IS_iPhoneX ? 34 : 0), kScreenWidth, 49+16)];
    _window.windowLevel = UIWindowLevelAlert+1;
    //    _window.backgroundColor = kMBColor(60, 198, 145, 1);//[UIColor redColor];
    _window.backgroundColor = [UIColor clearColor];
    _window.layer.cornerRadius = 1;
    _window.layer.masksToBounds = YES;
    [_window addSubview:self.bannerView];
    [_window addSubview:c];
    [_window makeKeyAndVisible];//关键语句,显示window
}

- (void)registerNotifiction {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
}

- (void)tongzhi:(NSNotification *)notic{
    
//    if ([notic.userInfo[@"notic"] isEqualToString:@"showAD"]) {
//        
//        self.interstitial = [self createAndLoadInterstitial];
//        return;
//    } else if ([notic.userInfo[@"notic"] isEqualToString:@"showAdBanner"]) {
//        [self setBanner];
//        return;
//    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
