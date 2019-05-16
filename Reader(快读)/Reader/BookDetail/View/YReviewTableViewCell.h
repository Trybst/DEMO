//
//  YReviewTableViewCell.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/10.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YBookReviewModel;

@interface YReviewTableViewCell : UITableViewCell

@property (strong, nonatomic) YBookReviewModel *reviewModel;

@end
