//
//  YBaseModel.m
//  YReader 
//
//  Created by Bing Ma on 2016/12/9.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseModel.h"

@implementation YBaseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"idField" : @[@"_id",@"id"]};
}

- (void)setCover:(NSString *)cover {
//    if ([cover hasPrefix:@"/agent/"]) {
//        _cover = [cover stringByReplacingOccurrencesOfString:@"/agent/" withString:@""];
//    } else {
//        _cover = cover;
//    }
    _cover = cover;
//    _cover = [NSString stringWithFormat:@"http://statics.zhuishushenqi.com%@", cover];
}


- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }

@end
