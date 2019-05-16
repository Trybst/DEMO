//
//  MBHTTPManager.m
//  Reader
//
//  Created by Bing Ma on 6/20/17.
//  Copyright © 2017 SF. All rights reserved.
//

#import "MBHTTPManager.h"

@implementation MBHTTPManager

static MBHTTPManager *_instance;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[MBHTTPManager alloc] initWithBaseURL:[NSURL URLWithString:PL_LOAN_BASE_URL] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
        [_instance.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        
        // add those -> json -> fragments.
        _instance.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        _instance.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    
    return _instance;
}


- (void)getIsOpen:(void (^)(BOOL isOpen))successBlock  failure:(failureBlock)failureBlock {
    NSString *kPATH = [NSString stringWithFormat:@"%@/terminal/ios/source_app/%@/",PL_LOAN_ISOPEN, [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleIdentifier"] ];
    [self GET:kPATH parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        NSLog(@"status code = %ld", (long)httpResponse.statusCode);
        
        if (successBlock != nil && httpResponse.statusCode == 200) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            BOOL isOpen = [[dic objectForKey:@"data"] boolValue];
            
            successBlock(isOpen);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@", error);
        
        NSDictionary *dic = [NSDictionary dictionary];
        NSData *data = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
        if (data.length > 0) {
            dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@", dic);
        }
        
        failureBlock(error);
    }];
}



@end
