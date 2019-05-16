//
//  YBookUpdateModel.m
//  YReader 
//
//  Created by Bing Ma on 2016/12/18.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBookUpdateModel.h"
#import "YDateModel.h"

@implementation YBookUpdateModel

+ (NSArray *)modelPropertyBlacklist {
    return @[@"updated"];
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *time = dic[@"updated"];
    if (![time isKindOfClass:[NSString class]]) return NO;
    _updated = [[YDateModel shareDateModel] dateWithCustomDateFormat:time];
    return YES;
}

@end
