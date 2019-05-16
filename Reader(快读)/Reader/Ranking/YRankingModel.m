//
//  YRankingModel.m
//  YReader 
//
//  Created by Bing Ma on 2016/12/19.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YRankingModel.h"

@implementation YRankingModel

+ (instancetype)modelWithTitle:(NSString *)title {
    YRankingModel *model = [[YRankingModel alloc] init];
    model.title = title;
    return model;
}

@end
