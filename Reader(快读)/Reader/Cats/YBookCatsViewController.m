//
//  YBookCatsViewController.m
//  Reader
//
//  Created by Bing Ma on 7/7/17.
//  Copyright © 2017 SF. All rights reserved.
//

#import "YBookCatsViewController.h"
#import "YHeaderCollectionReusableView.h"
#import "YCatsCollectionViewCell.h"
#import "YNetworkManager.h"
#import "YBookCatsModel.h"
#import "YBookCatsSubModel.h"
#import "YBookCatsBookListViewController.h"
#import "YBookDetailCell.h"

#define BgColor YRGBColor(240, 240, 240)
@interface YBookCatsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    UICollectionView *_mCollectionView;
    NSArray *_genderArr;
}

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSMutableArray *subCatsArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stateCons;

@end

@implementation YBookCatsViewController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _stateCons.constant = IS_iPhoneX ? 24 : 0;
    
    _titleArr = @[@"· 男神", @"· 女神", @"· 推荐"];
    _genderArr = @[@"male",@"female",@"press"];
    
    [self loadDatas];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, IS_iPhoneX ? 88 : 64, kScreenSize.width, kScreenSize.height-64) collectionViewLayout:layout];
    [self.view addSubview:_mCollectionView];
    
    [_mCollectionView registerClass:[YCatsCollectionViewCell class] forCellWithReuseIdentifier:@"cats_cell"];
    [_mCollectionView registerClass:[YHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cats_header"];
    
    _mCollectionView.backgroundColor = [UIColor whiteColor];//[UIColor grayColor];
    
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
}

- (void)loadDatas {
    [YProgressHUD showLoadingHUD];
    __weak typeof(self) wself = self;
    YNetworkManager *netManager = [YNetworkManager shareManager];
    [netManager getWithAPIType:YAPITypeCatsList parameter:@"statistics" success:^(id response) {
        wself.dataArr = response;
        [_mCollectionView reloadData];
        [YProgressHUD hideLoadingHUD];
    } failure:^(NSError *error) {
        [YProgressHUD showErrorHUDWith:error.localizedFailureReason];
    }];
    
    [netManager getWithAPIType:YAPITypeCatsSubList parameter:@"lv2" success:^(id response) {
        wself.subCatsArr = response;
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - collection view delegate & datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *arr = self.dataArr[section];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YCatsCollectionViewCell *cell = (YCatsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cats_cell" forIndexPath:indexPath];
    YBookCatsModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.nameLbl.text = model.name;
    cell.bookCountLbl.text = [NSString stringWithFormat:@"%@ 本", model.bookCount];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    int w = kScreenSize.width/4;
    return CGSizeMake(w, w*0.618);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(2, 20, 20, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader) {
        YHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cats_header" forIndexPath:indexPath];
        
        [headerView setHeaderTitle:_titleArr[indexPath.section]];
        reusableview = headerView;
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenSize.width, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        YBookCatsSubModel *model;
        NSArray *arr = _subCatsArr[indexPath.section];
        YBookCatsModel *m = self.dataArr[indexPath.section][indexPath.row];
        NSString *t = m.name;
        for (YBookCatsSubModel *m in arr) {
            if ([m.major isEqualToString:t]) {
                model = m;
            }
        }
        
        YBookCatsBookListViewController *vc = [[YBookCatsBookListViewController alloc] init];
        vc.titleText = model.major;
        vc.model = model;
        vc.gender = _genderArr[indexPath.section];
        
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        YBookCatsSubModel *model = _subCatsArr[indexPath.section][indexPath.row];
        YBookCatsBookListViewController *vc = [[YBookCatsBookListViewController alloc] init];
        vc.titleText = model.major;
        vc.model = model;
        vc.gender = _genderArr[indexPath.section];
        
        [self.navigationController pushViewController:vc animated:YES];
    }

}

// ----
- (IBAction)popVC:(id)sender {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
