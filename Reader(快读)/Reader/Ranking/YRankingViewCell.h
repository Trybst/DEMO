//
//  YRankingViewCell.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/19.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRankingModel;

@interface YRankingViewCell : UITableViewCell

@property (assign, nonatomic) BOOL expand;
@property (strong, nonatomic) YRankingModel *rankingM;

@end
