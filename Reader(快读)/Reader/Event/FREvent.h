//
//  FREvent.h
//  Reader
//
//  Created by Bing Ma on 2017/1/24.
//  Copyright © 2017年 Hannb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FREvent : NSObject

+ (instancetype)getInstance;
- (void)EventWithPage:(NSString *)page event:(NSString *)event param:(NSDictionary *)param;
@end
