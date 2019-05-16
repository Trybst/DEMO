//
//  YReadPageViewController.m
//  YReader 
//
//  Created by Bing Ma on 2016/12/12.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YReadPageViewController.h"
#import "YBatteryView.h"
#import "YDateModel.h"
#import "YReaderView.h"
#import "YReaderUniversal.h"
#import "YReaderSettings.h"
#import "MBAlphaImageView.h"

@import GoogleMobileAds;
@interface YReadPageViewController ()<GADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pageNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet YBatteryView *batteryView;
@property (strong, nonatomic) YReaderView *readerView;
@property (weak, nonatomic) IBOutlet UIImageView *themeImageV;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLblCons;

@property (nonatomic, strong) GADBannerView *bannerView;
@property (nonatomic, strong) MBAlphaImageView *frameV;
@end

@implementation YReadPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bottomView.hidden = IS_iPhoneX ? YES : NO;
    _titleLblCons.constant = IS_iPhoneX ? (kScreenHeight - 44) : 10;
    _titleLabel.textAlignment = IS_iPhoneX ? NSTextAlignmentCenter : NSTextAlignmentLeft;
    
    if (IS_iPhoneX) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
        
    //有时候会显示少一行,先把显示高度时加15处理
//    _readerView = [[YReaderView alloc] initWithFrame:CGRectMake(kYReaderLeftSpace, kYReaderTopSpace - 5, kScreenWidth - kYReaderLeftSpace - kYReaderRightSpace, kScreenHeight - kYReaderTopSpace - kYReaderBottomSpace + 15)];
    
    _readerView = [[YReaderView alloc] initWithFrame:CGRectMake(20, (IS_iPhoneX ? 40 : 40), kScreenWidth - 20 - 20, kScreenHeight - 44 - (IS_iPhoneX ? 0 : 20))];
    
    _readerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_readerView];
    YReaderSettings *settings = [YReaderSettings shareReaderSettings];
    self.themeImageV.image = settings.themeImage;
    UIColor *textColor = settings.otherTextColor;
    
    NSArray *fontNameArr = @[@"", @"STKaiti", @"FZMWJW--GB1-0"];
    int idxFont = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"idxFont"];

    self.titleLabel.textColor = textColor;
    self.titleLabel.font = idxFont > 0 ? [UIFont fontWithName:fontNameArr[idxFont] size:15.0] : [UIFont systemFontOfSize:15.0];
    self.timeLabel.textColor = textColor;
    self.timeLabel.font = idxFont > 0 ? [UIFont fontWithName:fontNameArr[idxFont] size:12.0] : [UIFont systemFontOfSize:12.0];
    self.pageNumberLabel.textColor = textColor;
    self.pageNumberLabel.font = idxFont > 0 ? [UIFont fontWithName:fontNameArr[idxFont] size:12.0] : [UIFont systemFontOfSize:12.0];
    self.batteryView.fillColor = textColor;
    self.batteryView.backgroundColor = [UIColor clearColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.titleLabel.text = IS_iPhoneX ? [NSString stringWithFormat:@"%@     第%zi/%zi页", self.booktitle, self.page+1, self.totalPage] : self.booktitle;
    self.pageNumberLabel.text = [NSString stringWithFormat:@"第%zi/%zi页",self.page+1,self.totalPage];
    self.timeLabel.text = [[YDateModel shareDateModel] getTimeString];
    [self.batteryView setNeedsDisplay];
    self.readerView.content = self.pageContent;
    
    int idx = (random() % 7);
    if (self.page+1 == self.totalPage && idx == 2) {
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"showAdBanner", @"notic", nil];
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    _frameV.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
