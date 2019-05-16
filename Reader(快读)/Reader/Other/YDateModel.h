//
//  YDateModel.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/10.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDateModel : NSObject

+ (instancetype)shareDateModel;

- (NSDate *)dateWithCustomDateFormat:(NSString *)dateStr;
- (NSString *)getUpdateStringWith:(NSDate *)date;
- (NSString *)getTimeString;

@end
