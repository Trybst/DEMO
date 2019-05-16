//
//  YCollectionViewLayout.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/8.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YLayoutStyle) {
    YLayoutStyleTag,
    YLayoutStyleRecommend,
};

@interface YCollectionViewLayout : UICollectionViewFlowLayout

@property (strong, nonatomic) NSArray *dataArr;

- (instancetype)initWithStyle:(YLayoutStyle)style;

@end
