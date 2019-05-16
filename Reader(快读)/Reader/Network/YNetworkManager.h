//
//  YNetworkManager.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/9.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YURLManager.h"

@interface YNetworkManager : NSObject

+ (instancetype)shareManager;

- (NSURLSessionTask *)getWithAPIType:(YAPIType)type parameter:(id)parameter success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

@end
