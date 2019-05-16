//
//  YBookReviewModel.m
//  YReader 
//
//  Created by Bing Ma on 2016/12/10.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBookReviewModel.h"
#import "YDateModel.h"

@implementation YBookReviewModel

+ (NSArray *)modelPropertyBlacklist {
    return @[@"created"];
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *time = dic[@"created"];
    if (![time isKindOfClass:[NSString class]]) return NO;
    _created = [[YDateModel shareDateModel] dateWithCustomDateFormat:time];
    return YES;
}

@end
