//
//  YSummaryViewController.m
//  YReader 
//
//  Created by Bing Ma on 2016/12/18.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YSummaryViewController.h"
#import "YBookSummaryModel.h"
#import "YSummaryViewCell.h"
#import "YNetworkManager.h"
#import "YBookDetailModel.h"

@interface YSummaryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) YNetworkManager *netManager;
@property (strong, nonatomic) NSArray *summaryArr;
@property (strong, nonatomic) NSURLSessionTask *urlTask;
@property (assign, nonatomic) NSInteger selectSummaryCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stateCons;

@end

@implementation YSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _stateCons.constant = IS_iPhoneX ? 24 : 0;
    
    self.netManager = [YNetworkManager shareManager];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YSummaryViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YSummaryViewCell class])];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    [self getBookSummarys];
}

- (void)getBookSummarys {
    __weak typeof(self) wself = self;
    [YProgressHUD showLoadingHUD];
    wself.view.userInteractionEnabled = NO;
    [[YProgressHUD shareProgressHUD] setCancelAction:^{
        if (wself.urlTask.state == NSURLSessionTaskStateRunning) {
            [wself.urlTask cancel];
        }
        [wself dismissViewControllerAnimated:YES completion:nil];
    }];
    
    _urlTask = [_netManager getWithAPIType:YAPITypeBookSummary parameter:_bookM.idField success:^(id response) {
        [YProgressHUD hideLoadingHUD];
        wself.view.userInteractionEnabled = YES;
        NSMutableArray *arr = response;
        [arr removeObjectAtIndex:0]; // 丢失“zhuishuvip”
        if (arr.count > 0) {
            wself.summaryArr = arr;
            [wself.tableView reloadData];
        }
    } failure:^(NSError *error) {
        if (error.code != -999) {
            [YProgressHUD showErrorHUDWith:error.localizedFailureReason];
            [wself dismissViewControllerAnimated:YES completion:nil];
        }
        [YProgressHUD hideLoadingHUD];
        wself.view.userInteractionEnabled = YES;
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.summaryArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSummaryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YSummaryViewCell class]) forIndexPath:indexPath];
    cell.summaryM = _summaryArr[indexPath.row];
    cell.isSelectSummary = [cell.summaryM.idField isEqualToString:_summaryM.idField];
    if (cell.isSelectSummary) {
        self.selectSummaryCount = indexPath.row;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YBookSummaryModel *summaryM = nil;
    if (indexPath.row < _summaryArr.count && indexPath.row != _selectSummaryCount) {
        summaryM = _summaryArr[indexPath.row];
        if ([summaryM.source isEqualToString:@"zhuishuvip"]) {
            [YProgressHUD showErrorHUDWith:@"此来源已失效"];
            return;
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (summaryM && self.updateSelectSummary) {
            self.updateSelectSummary(summaryM);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
