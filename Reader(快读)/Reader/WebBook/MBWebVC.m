//
//  MBWebVC.m
//  Reader
//
//  Created by Bing Ma on 6/20/17.
//  Copyright © 2017 SF. All rights reserved.
//

#import "MBWebVC.h"
#import "MBAlphaImageView.h"

@import GoogleMobileAds;
@interface MBWebVC ()<UIWebViewDelegate, GADInterstitialDelegate, GADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *vcTitle;
@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) GADBannerView *bannerView;
@property (nonatomic, strong) GADInterstitial *interstitial;
@property (nonatomic, strong) MBAlphaImageView *frameV;
@end

@implementation MBWebVC


- (IBAction)backVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vcTitle.text = _titlemain;
    [self setupWebView];
    
    [self setBanner];
    // interstitial ad.
    self.interstitial.delegate = self;
    self.interstitial = [self createAndLoadInterstitial];
}

- (void)setupWebView {
    
    UIWebView *webView = [[UIWebView alloc] init];
    self.webView = webView;
    
    webView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight -64 -50);//self.view.frame;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlmain]]];
    
//    __weak typeof(self) wself = self;
//    [[YProgressHUD shareProgressHUD] setCancelAction:^{
//        [wself.navigationController popViewControllerAnimated:YES];
//    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.querySelector('.footer').style.display='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('main').style.paddingBottom = '8px';"];

//    [self.webView stringByEvaluatingJavaScriptFromString:@"document.querySelector('.footer').style.display='none'"];
//    [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.style.padding=0"];
//    [self.webView stringByEvaluatingJavaScriptFromString:@"$('.pagination').parent().hide()"];
//    [self.webView stringByEvaluatingJavaScriptFromString:@"$('.ds-thread').hide()"];
    
    [YProgressHUD hideLoadingHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [YProgressHUD showLoadingHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ads.
- (GADInterstitial *)createAndLoadInterstitial {
    
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:kINV_ID];
    interstitial.delegate = self;
//    if ((random() % 2) < 1 ) {
        [interstitial loadRequest:[GADRequest request]];
//    }
    return interstitial;
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.interstitial presentFromRootViewController:self];
    });
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    //leave this method as empty
}

- (void)setBanner {
    self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    self.bannerView.adUnitID = kBANNER_ID;
    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;
    GADRequest *req = [GADRequest request];
    [self.bannerView loadRequest:req];
    [self.view addSubview:_bannerView];
    
    _frameV = [[MBAlphaImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 56)];
    _frameV.image = [UIImage imageNamed:@"ad_frm"];
    _frameV.center = _bannerView.center;
    _frameV.hidden = YES;
    [self.view addSubview:_frameV];
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    _frameV.hidden = NO;
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    self.webView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
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
