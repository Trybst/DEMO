//
//  YRecommendBookModel.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/10.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseModel.h"

@interface YRecommendBookModel : YBaseModel

@property (nonatomic, strong) NSString * author;
@property (nonatomic, strong) NSString * cat;
@property (nonatomic, strong) NSString * lastChapter;
@property (nonatomic, assign) NSInteger latelyFollower;
@property (nonatomic, strong) NSString * majorCate;
@property (nonatomic, strong) NSString * minorCate;
@property (nonatomic, assign) double retentionRatio;
@property (nonatomic, strong) NSString * shortIntro;
@property (nonatomic, strong) NSString * site;
@property (nonatomic, strong) NSString * title;

@end
