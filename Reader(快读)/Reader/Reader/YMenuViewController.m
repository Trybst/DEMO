//
//  YMenuViewController.m
//  YReader
//
//  Created by Bing Ma on 2016/12/13.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YMenuViewController.h"
#import "YMoreSettingsViewController.h"
#import "YBottomButton.h"
#import "YReaderManager.h"
#import "YDownloadManager.h"
#import "YReaderSettings.h"
#import "YThemeViewCell.h"

@interface YMenuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *downloadView;
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downloadViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTop;
@property (weak, nonatomic) IBOutlet UIView *settingView;
@property (weak, nonatomic) IBOutlet UIButton *fontSizeReduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *fontSizeAddBtn;
@property (weak, nonatomic) IBOutlet UIButton *fontFanBtn;
@property (weak, nonatomic) IBOutlet UIButton *spaceSmallBtn;
@property (weak, nonatomic) IBOutlet UIButton *spaceNormalBtn;
@property (weak, nonatomic) IBOutlet UIButton *spaceBigBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *themeCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceBtnInterval;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fontSizeBtnInterval;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fontFanBtnInterval;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *settingViewBottom;

@property (weak, nonatomic) IBOutlet UISlider *brightSlider;

@property (weak, nonatomic) IBOutlet UILabel *bookTitleLbl;

@property (strong, nonatomic) YDownloadManager *downloadManager;
@property (strong, nonatomic) YBookDetailModel *downloadBook;
@property (strong, nonatomic) YReaderSettings *settings;
@property (strong, nonatomic) NSArray *themeArr;
@property (assign, nonatomic) YReaderTheme selectTheme;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeightCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stateCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightCons;

@end

@implementation YMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navHeightCons.constant = IS_iPhoneX ? 88 : 64;
    _stateCons.constant = IS_iPhoneX ? -88 : -64;
    _bottomHeightCons.constant = IS_iPhoneX ? 88 : 54;
    
    [self setupBottomViewUI];
    [self setupSettingViewUI];
    [self setupSettingButtonStatus];
    self.settingView.backgroundColor = YRGBAColor(0, 0, 0, 0.85);
    self.themeArr = self.settings.themeImageArr;
    self.selectTheme = self.settings.theme;
    
    self.themeCollectionView.delegate = self;
    self.themeCollectionView.dataSource = self;
    [self.themeCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YThemeViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([YThemeViewCell class])];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.themeCollectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(40, 40);
    layout.minimumLineSpacing = (kScreenWidth - 40 - 200) / 4;
    layout.minimumInteritemSpacing = 10;
    [self.themeCollectionView setCollectionViewLayout:layout];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    tap.delegate = self;
    tap.numberOfTouchesRequired = 1;
    [self.themeCollectionView addGestureRecognizer:tap];
    
    __weak typeof(self) wself = self;
    [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(UITapGestureRecognizer *sender) {
        [wself hideMenuView];
    }]];
    
    _brightSlider.minimumValue = 0;
    _brightSlider.minimumTrackTintColor = kMBColor(192, 56, 47, 1);
    _brightSlider.maximumValue = 1.0;
    _brightSlider.value = [UIScreen mainScreen].brightness;
    [_brightSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

-(void)sliderValueChanged:(UISlider *)paramSender{
    if ([paramSender isEqual:self.brightSlider]) {
        UIScreen.mainScreen.brightness = paramSender.value;
    }
}

- (void)click {
    NSLog(@"click - themeCollectionView's blank place -");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.themeArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YThemeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YThemeViewCell class]) forIndexPath:indexPath];
    cell.themeImage.layer.cornerRadius = cell.width/2;
    cell.themeImage.image = self.themeArr[indexPath.row];
    
    cell.tag = indexPath.row;
    
    
    if (indexPath.row == self.selectTheme) {
        cell.selectImage.hidden = NO;
    } else {
        cell.selectImage.hidden = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s %@",__func__,indexPath);
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    self.settings.theme = indexPath.row;
    self.selectTheme = indexPath.row;
    [collectionView reloadData];
}

#pragma mark - download Chpaters
- (void)downloadChpatersWith:(YDownloadType)type {
    [UIView animateWithDuration:0.25 animations:^{
        self.downloadViewBottom.constant = IS_iPhoneX ? 88 : 54;
        [self.view layoutIfNeeded];
    }];
    
    self.downloadManager = [YDownloadManager shareManager];
    [self.downloadManager downloadReaderBookWith:self.downloadBook type:type];
    [self setDownloadBookCallback];
}

- (void)setDownloadBookCallback {
    __weak typeof(self) wself = self;
    self.downloadBook.loadProgress = ^(NSUInteger chapter, NSUInteger totalChapters) {
        wself.downloadLabel.text = [NSString stringWithFormat:@"正在缓存中 (%zi/%zi) ...",chapter,totalChapters];
    };
    
    self.downloadBook.loadCompletion = ^ {
        wself.downloadLabel.text = @"缓存完成";
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //            [wself hideMenuView];
        //        });
    };
    
    self.downloadBook.loadFailure = ^(NSString *msg) {
        wself.downloadLabel.text = [NSString stringWithFormat:@"缓存失败: %@",msg];
    };
    
    self.downloadBook.loadCancel = ^ {
        wself.downloadLabel.text = [NSString stringWithFormat:@"缓存取消"];
    };
}

#pragma mark - 点击上/下部按钮
- (IBAction)handleButton:(UIButton *)btn {
    if (self.menuTapAction) {
        self.menuTapAction(btn.tag);
    }
    if (btn.tag != 102) { //102:close
        [self hideMenuView];
    }
}

#pragma mark - 点击设置里面按钮
- (IBAction)settingButtonAction:(UIButton *)btn {
    NSLog(@"%s %zi",__func__,btn.tag);
    switch (btn.tag) {
        case 300: {             //字体-
            if (self.settings.fontSize > kYFontSizeMin) {
                self.settings.fontSize --;
                if (self.settings.fontSize == kYFontSizeMin) {
                    btn.enabled = NO;
                }
                self.fontSizeAddBtn.enabled = YES;
            } else {
                btn.enabled = NO;
            }
        }
            break;
        case 301: {             //字体+
            if (self.settings.fontSize < kYFontSizeMax) {
                self.settings.fontSize ++;
                if (self.settings.fontSize == kYFontSizeMax) {
                    btn.enabled = NO;
                }
                self.fontSizeReduceBtn.enabled = YES;
            } else {
                btn.enabled = NO;
            }
        }
            break;
        case 302: {             //繁简体
            self.settings.isTraditional = !self.settings.isTraditional;
            if (self.settings.isTraditional) {
                [self.fontFanBtn setImage:[UIImage imageNamed:@"setting_font_jian"] forState:UIControlStateNormal];
            } else {
                [self.fontFanBtn setImage:[UIImage imageNamed:@"setting_font_fan"] forState:UIControlStateNormal];
            }
        }
            break;
        case 303: {             //字体
            
        }
            break;
        case 304: {             //行间距:密集
            self.settings.lineSpacing = kYLineSpacingCompact;
            self.spaceSmallBtn.selected = YES;
            self.spaceBigBtn.selected = NO;
            self.spaceNormalBtn.selected = NO;
        }
            break;
        case 305: {             //行间距:正常
            self.settings.lineSpacing = kYLineSpacingNormal;
            self.spaceSmallBtn.selected = NO;
            self.spaceBigBtn.selected = NO;
            self.spaceNormalBtn.selected = YES;
        }
            break;
        case 306: {             //行间距:稀疏
            self.settings.lineSpacing = kYLineSpacingSparse;
            self.spaceSmallBtn.selected = NO;
            self.spaceBigBtn.selected = YES;
            self.spaceNormalBtn.selected = NO;
        }
            break;
        case 307: {             //自动翻页
            
        }
            break;
        case 308: {             //横竖屏
            
        }
            break;
        case 309: {             //更多设置
            YMoreSettingsViewController *moreVC = [[YMoreSettingsViewController alloc] init];
            [self presentViewController:moreVC animated:YES completion:nil];
            [self hideMenuView];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - show views
- (void)showSettingView {
    if (self.settingViewBottom.constant == self.bottomView.height) {
        return;
    }
    [self hideDownloadView];
    [UIView animateWithDuration:0.25 animations:^{
        self.settingViewBottom.constant = self.bottomView.height;
        self.bgViewBottom.constant = self.settingView.height + self.bottomView.height;
        [self.view layoutIfNeeded];
    }];
}

- (void)hideSettingView {
    if (self.settingViewBottom.constant == -self.settingView.height) {
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.settingViewBottom.constant = -self.settingView.height;
        self.bgViewBottom.constant = self.bottomView.height;
        [self.view layoutIfNeeded];
    }];
}

- (void)showDownloadView {
    if (self.downloadViewBottom.constant != self.bottomView.height) {
        [UIView animateWithDuration:0.25 animations:^{
            self.downloadViewBottom.constant = self.bottomView.height;
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)hideDownloadView {
    if (self.downloadViewBottom.constant == self.bottomView.height) {
        [UIView animateWithDuration:0.25 animations:^{
            self.downloadViewBottom.constant = -self.downloadView.height;
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)showMenuView {
    self.view.hidden = NO;
    BOOL showLoadView = self.downloadBook.loadStatus != YDownloadStatusNone;
    [UIView animateWithDuration:0.25 animations:^{
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        
        self.topViewTop.constant = 0;
        self.bottomViewBottom.constant = 0;
        if (showLoadView) {
            self.downloadViewBottom.constant = self.bottomView.height;
        }
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
//        if (finished) {
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//        }
    }];
    if (self.downloadBook.loadStatus != YDownloadStatusNone) {
        [self setDownloadBookCallback];
    }
    
    YBottomButton *btn = [self.bottomView viewWithTag:199];
    if (self.settings.theme == 8) {
        [btn setTitle:@"白天" imageName:@"day_mode"];
    } else {
        [btn setTitle:@"夜间" imageName:@"night_mode"];
    }
    
}

- (void)hideMenuView {
    [UIView animateWithDuration:0.25 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:!IS_iPhoneX withAnimation:UIStatusBarAnimationFade];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
        self.topViewTop.constant = -self.topView.height;
        self.bottomViewBottom.constant = -self.bottomView.height - self.downloadView.height;
        self.downloadViewBottom.constant = -self.downloadView.height;
        self.settingViewBottom.constant = -self.settingView.height;
        self.bgViewBottom.constant = self.bottomView.height;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            self.view.hidden = YES;
//            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        }
    }];
}

- (YBookDetailModel *)downloadBook {
    if (!_downloadBook) {
        _downloadBook = [YReaderManager shareReaderManager].readingBook;
    }
    return _downloadBook;
}

- (YReaderSettings *)settings {
    if (!_settings) {
        _settings = [YReaderSettings shareReaderSettings];
    }
    return _settings;
}

#pragma mark - setup UI
- (void)setupSettingButtonStatus {
    if (self.settings.fontSize >= kYFontSizeMax) {
        self.fontSizeAddBtn.enabled = NO;
    } else if (self.settings.fontSize <= kYFontSizeMin) {
        self.fontSizeReduceBtn.enabled = NO;
    }
    if (self.settings.lineSpacing <= kYLineSpacingCompact + 0.1) {
        self.spaceSmallBtn.selected = YES;
    } else if (self.settings.lineSpacing <= kYLineSpacingNormal + 0.1) {
        self.spaceNormalBtn.selected = YES;
    } else {
        self.spaceBigBtn.selected  =YES;
    }
    if (self.settings.isTraditional) {
        [self.fontFanBtn setImage:[UIImage imageNamed:@"setting_font_jian"] forState:UIControlStateNormal];
    } else {
        [self.fontFanBtn setImage:[UIImage imageNamed:@"setting_font_fan"] forState:UIControlStateNormal];
    }
}

- (void)setupSettingViewUI {
    CGFloat space = kScreenWidth - 15 * 2 - self.fontSizeAddBtn.width * 2 - self.fontFanBtn.width * 2;
    self.fontSizeBtnInterval.constant = space / 80 * 30.0;
    self.fontFanBtnInterval.constant = space / 80 * 25.0;
    self.spaceBtnInterval.constant = (self.fontSizeAddBtn.width * 2 + self.fontSizeBtnInterval.constant - self.spaceBigBtn.width * 3)/2.0;
    
}

- (void)setupBottomViewUI {
    //    NSArray *imgArr = @[@"night_mode",@"feedback",@"directory",@"preview_btn",@"reading_setting"];
    //    NSArray *titleArr = @[@"夜间",@"反馈",@"目录",@"缓存",@"设置"];
    NSArray *imgArr = @[@"night_mode",@"reading_setting",@"directory",@"preview_btn"];
    NSArray *titleArr = @[@"夜间",@"设置",@"目录",@"缓存"];
    __weak typeof(self) wself = self;
    void (^tapAction)(NSInteger) = ^(NSInteger tag){
        NSLog(@"tapAction %zi",tag);
        switch (tag) {
            case 200:            //设置
                [wself showSettingView];
                break;
            case 201: {          //目录
                [wself hideMenuView];
                if (wself.menuTapAction) {
                    wself.menuTapAction(202);
                }
            }
                break;
            case 202: {          //缓存
                [wself hideSettingView];
                if (wself.downloadBook.loadStatus != YDownloadStatusNone) {
                    return ;
                }
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择缓存章节方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *someAction = [UIAlertAction actionWithTitle:@"后面50章" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [wself downloadChpatersWith:YDownloadTypeBehindSome];
                }];
                UIAlertAction *behindAction = [UIAlertAction actionWithTitle:@"后面全部" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [wself downloadChpatersWith:YDownloadTypeBehindAll];
                }];
                UIAlertAction *allAction = [UIAlertAction actionWithTitle:@"全部章节" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [wself downloadChpatersWith:YDownloadTypeAllLoad];
                }];
                [alertVC addAction:cancelAction];
                [alertVC addAction:someAction];
                [alertVC addAction:behindAction];
                [alertVC addAction:allAction];
                [wself presentViewController:alertVC animated:YES completion:nil];
            }
                break;
            case 199:{           //夜间
                
                if (self.settings.theme == 8) {
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSInteger selectedT = [defaults integerForKey:@"select_theme"];
                    
                    self.settings.theme = selectedT;
                    self.selectTheme = selectedT;
                    [_themeCollectionView reloadData];
                    YBottomButton *btn = [wself.bottomView viewWithTag:199];
                    [btn setTitle:@"夜间" imageName:@"night_mode"];
                } else {
                    
                    self.settings.theme = 8;
                    self.selectTheme = 8;
                    [_themeCollectionView reloadData];
                    YBottomButton *btn = [wself.bottomView viewWithTag:199];
                    [btn setTitle:@"白天" imageName:@"day_mode"];
                }
                break;
            }
            default:
                break;
        }
    };
    for (NSInteger i = 0; i < imgArr.count; i++) {
        YBottomButton *btn = [YBottomButton bottonWith:titleArr[i] imageName:imgArr[i] tag:i];
        btn.tapAction = tapAction;
        [self.bottomView addSubview:btn];
    }
}

#pragma mark - 手势冲突（collectionView:didSelectItemAtIndexPath:无法调用） - 零时解决办法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isKindOfClass:[UICollectionView class]]) {
        return YES;
    } else {
        
        // 修改 主题 背景颜色（临时解决方案） -- 长按手势才可以调用didSelect方法！
        UIView *c = [touch.view superview];
        self.settings.theme = c.tag;
        self.selectTheme = c.tag;
        
        if (c.tag != 8) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setInteger:c.tag forKey:@"select_theme"];
            [defaults synchronize];
        }
        
        [_themeCollectionView reloadData];
        
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
