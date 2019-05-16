//
//  YBookCatsBookListViewController.m
//  Reader
//
//  Created by Bing Ma on 7/7/17.
//  Copyright © 2017 SF. All rights reserved.
//

#import "YBookCatsBookListViewController.h"
#import "MBPiecewiseView.h"
#import "YBookDetailCell.h"
#import "YNetworkManager.h"
#import "YBookDetailViewController.h"
#import "CommonMenuView.h"

@interface YBookCatsBookListViewController ()<MBPiecewiseViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSArray *catsItems;
    NSArray *catsItemPars;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;

@property (weak, nonatomic) IBOutlet UIButton *subCatsBtn;

@property (nonatomic, strong) NSArray *sourceArr;
@property (nonatomic, assign) NSInteger selectedIdx;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stateCons;

@end

@implementation YBookCatsBookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _stateCons.constant = IS_iPhoneX ? 24 : 0;
    
    self.titleLbl.text = _titleText;
    
    catsItems = @[@"新书",@"热门",@"好评",@"完结"];
    catsItemPars = @[@"new",@"hot",@"reputation",@"over"];
    
    MBPiecewiseView *pV = [[MBPiecewiseView alloc] initWithFrame:CGRectMake(0, IS_iPhoneX ? 88 : 64, kScreenSize.width, 49)];
    pV.backgroundColor = [UIColor whiteColor];
    pV.type = PiecewiseInterfaceTypeMobileLin;
    pV.delegate = self;
    pV.textFont = [UIFont systemFontOfSize:16];
    pV.textNormalColor = [UIColor darkGrayColor];
    pV.textSeletedColor = YRGBColor(65, 176, 222);//[UIColor redColor];
    pV.linColor = YRGBColor(65, 176, 222);//[UIColor redColor];
    pV.linBackColor = YRGBColor(240, 240, 240);
    [pV loadTitleArray:catsItems];
    [self.view addSubview:pV];
    
    if ([_gender isEqualToString:@"press"]) {
        _topCons.constant = 0.0;
        [pV removeFromSuperview];
        _subCatsBtn.hidden = YES;
    }

    _tabView.delegate = self;
    _tabView.dataSource = self;
    [self.tabView registerNib:[UINib nibWithNibName:NSStringFromClass([YBookDetailCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YBookDetailCell class])];

    [self getBookListSourceWithType:@"new"];
    _selectedIdx = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (IBAction)subCatsAction:(id)sender {

}

- (void)getBookListSourceWithType:(NSString *)type {
    [YProgressHUD showLoadingHUD];
    __weak typeof(self) wself = self;
    YNetworkManager *netManager = [YNetworkManager shareManager];
    
    NSString *pars = [NSString stringWithFormat:@"gender=%@&type=%@&major=%@&minor=&start=0&limit=50",_gender,type,_model.major];//gender=male&type=new&major=%E7%8E%84%E5%B9%BB&minor=&start=0&limit=50
    [netManager getWithAPIType:YAPITypeCatsBookList parameter:pars success:^(id response) {
        wself.sourceArr = response;
        [wself.tabView reloadData];
        [YProgressHUD hideLoadingHUD];
    } failure:^(NSError *error) {
        [YProgressHUD showErrorHUDWith:error.localizedFailureReason];
    }];
}

#pragma mark - delegate & datasource.
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

// ----

- (void)piecewiseView:(MBPiecewiseView *)piecewiseView index:(NSInteger)index {
    
    if (_selectedIdx != index) {
        _selectedIdx = index;
        [_tabView setContentOffset:CGPointMake(0, 0) animated:NO];
        [self getBookListSourceWithType:catsItemPars[index]];
    }

}

- (IBAction)popVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
