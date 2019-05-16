//
//  YMoreSettingsViewController.m
//  YReader 
//
//  Created by Bing Ma on 2016/12/25.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YMoreSettingsViewController.h"
#import "YMoreSettingsCell.h"
#import "YReaderSettings.h"

@interface YMoreSettingsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) YReaderSettings *settings;
@property (assign, nonatomic) int idxFont;

@end

@implementation YMoreSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settings = [YReaderSettings shareReaderSettings];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YMoreSettingsCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YMoreSettingsCell class])];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMoreSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YMoreSettingsCell class]) forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:{
            cell.titleLabel.text = @"翻页方式";
            if (self.settings.pageStyle == YTurnPageStylePageCurl) {
                cell.styleLabel.text = @"拟真";
            } else if (self.settings.pageStyle == YTurnPageStyleScroll) {
                cell.styleLabel.text = @"滑动";
            }
        }
            break;
        case 1:{
            cell.titleLabel.text = @"设置字体";
            
            _idxFont = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"idxFont"];
            
            switch (_idxFont) {
                case 0:{
                    cell.styleLabel.text = @"默认";
                    cell.styleLabel.font = [UIFont systemFontOfSize:15.0];
                    self.settings.font = [UIFont systemFontOfSize:self.settings.fontSize];
                    [[YReaderSettings shareReaderSettings] updateFontFormat];
                }
                    break;
                case 1:{
                    cell.styleLabel.text = @"华文楷体";
                    cell.styleLabel.font = [UIFont fontWithName:@"STKaiti" size:15.0];
                    self.settings.font = [UIFont fontWithName:@"STKaiti" size:self.settings.fontSize];
                    [[YReaderSettings shareReaderSettings] updateFontFormat];
                }
                    break;
                case 2:{
                    cell.styleLabel.text = @"方正喵呜体";
                    cell.styleLabel.font = [UIFont fontWithName:@"FZMWJW--GB1-0" size:15.0];
                    self.settings.font = [UIFont fontWithName:@"FZMWJW--GB1-0" size:self.settings.fontSize];
                    [[YReaderSettings shareReaderSettings] updateFontFormat];
                }
                    break;
                default:
                    break;
            }
        }
            
            break;
        default:
            break;
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self showSelectTurnPageStyle];
    } else if (indexPath.row == 1) {
        [self showSelectFontFormatStyle];
    }
}

- (void)showSelectTurnPageStyle {
    __weak typeof(self) wself = self;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择翻页方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    void (^turnPageStyle)(NSInteger) = ^(NSInteger style) {
        wself.settings.pageStyle = style;
        [wself.tableView reloadData];
    };
    UIAlertAction *curlAction = [UIAlertAction actionWithTitle:@"拟真" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        turnPageStyle(YTurnPageStylePageCurl);
    }];
    UIAlertAction *scrollAction = [UIAlertAction actionWithTitle:@"滑动" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        turnPageStyle(YTurnPageStyleScroll);
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:curlAction];
    [alertVC addAction:scrollAction];
    [wself presentViewController:alertVC animated:YES completion:nil];
}

- (void)showSelectFontFormatStyle {
    __weak typeof(self) wself = self;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择字体样式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    void (^fontFormatStyle)(NSInteger) = ^(NSInteger style) {
        wself.idxFont = (int)style;
        
        // NSDefault - > save the idx.
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:_idxFont forKey:@"idxFont"];
        [defaults synchronize];
        
        
        [wself.tableView reloadData];
    };
    UIAlertAction *oneFontAction = [UIAlertAction actionWithTitle:@"默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        fontFormatStyle(0);
    }];
    
    UIAlertAction *twoFontAction = [UIAlertAction actionWithTitle:@"华文楷体" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        fontFormatStyle(1);
    }];

    UIAlertAction *threeFontAction = [UIAlertAction actionWithTitle:@"方正喵呜体" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        fontFormatStyle(2);
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:oneFontAction];
    [alertVC addAction:twoFontAction];
    [alertVC addAction:threeFontAction];
    [wself presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)backBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
