//
//  CWStarRateView.h
//  StarRate 
//
//  Created by Bing Ma on 14/11/4.
//  Copyright (c) 2014年 Bing Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CWStarRateView;
@protocol CWStarRateViewDelegate <NSObject>
@optional
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface CWStarRateView : UIView

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO

@property (nonatomic, assign) BOOL hiddenUncheckStar;
//@property (nonatomic, assign) NSInteger 

@property (nonatomic, weak) id<CWStarRateViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

@end
