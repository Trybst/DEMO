//
//  YSummaryViewController.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/18.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseViewController.h"
@class YBookSummaryModel,YBookDetailModel;

@interface YSummaryViewController : YBaseViewController

@property (strong, nonatomic) YBookSummaryModel *summaryM;
@property (strong, nonatomic) YBookDetailModel *bookM;
@property (copy, nonatomic) void(^updateSelectSummary)(YBookSummaryModel *);

@end
