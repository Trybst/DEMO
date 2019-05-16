//
//  YBookRecommendListViewController.m
//  Reader
//
//  Created by Bing Ma on 7/6/17.
//  Copyright © 2017 SF. All rights reserved.
//

#import "YBookRecommendListViewController.h"
#import "YBookDetailViewController.h"
#import "YBookDetailCell.h"
#import "YNetworkManager.h"

@interface YBookRecommendListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tabView;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stateCons;

@property (strong, nonatomic) NSArray *sourceArr;

@end

@implementation YBookRecommendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _stateCons.constant = IS_iPhoneX ? 24 : 0;
    
    if (_type == YAPITypeRecommendBook) {
        _titleLbl.text = @"您可能感兴趣";
    } else if (_type == YAPITypeAuthorBookList) {
        _titleLbl.text = @"作者书单";
    } else {
        _titleLbl.text = _pars;
    }
    
    
    [self.tabView registerNib:[UINib nibWithNibName:NSStringFromClass([YBookDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YBookDetailCell class])];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getBookListSource];
}

- (void)getBookListSource {
    [YProgressHUD showLoadingHUD];
    __weak typeof(self) wself = self;
    YNetworkManager *netManager = [YNetworkManager shareManager];
    [netManager getWithAPIType:_type parameter:_pars success:^(id response) {
        wself.sourceArr = response;
        [wself.tabView reloadData];
        [YProgressHUD hideLoadingHUD];
    } failure:^(NSError *error) {
        [YProgressHUD showErrorHUDWith:error.localizedFailureReason];
    }];
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YBookDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YBookDetailCell class]) forIndexPath:indexPath];
    cell.bookModel = _sourceArr[indexPath.row]; //先用YBookModel
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < _sourceArr.count) {
        YBookModel *bookM = _sourceArr[indexPath.row];
        YBookDetailViewController *detailVC = [[YBookDetailViewController alloc] init];
        detailVC.selectBook = bookM;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (IBAction)popVC:(id)sender {
    [YProgressHUD hideLoadingHUD];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
