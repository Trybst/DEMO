//
//  YBookDetailViewController.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/10.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseViewController.h"

@class YBookModel,YRecommendBookModel;

@interface YBookDetailViewController : YBaseViewController

@property (strong, nonatomic) YBookModel *selectBook;
@property (strong, nonatomic) YRecommendBookModel *recommendBook;

@end
