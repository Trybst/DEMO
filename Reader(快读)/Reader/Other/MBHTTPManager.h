//
//  MBHTTPManager.h
//  Reader
//
//  Created by Bing Ma on 6/20/17.
//  Copyright © 2017 SF. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#define PL_LOAN_BASE_URL      @"http://loan.v1.guangjuhuizhan.cn"
#define PL_LOAN_ISOPEN        @"/v1/assistant"

typedef void(^successBlock)(id *obj);
typedef void(^failureBlock)(NSError *error);

@interface MBHTTPManager : AFHTTPSessionManager

+ (instancetype)shareManager;

- (void)getIsOpen:(void (^)(BOOL isOpen))successBlock  failure:(failureBlock)failureBlock;

@end
