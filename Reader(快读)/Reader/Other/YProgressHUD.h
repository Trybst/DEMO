//
//  YProgressHUD.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/18.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YProgressHUD : NSObject

@property (copy, nonatomic) void(^cancelAction)(void);
+ (instancetype)shareProgressHUD;
+ (void)showLoadingHUD;
+ (void)hideLoadingHUD;
+ (void)showErrorHUDWith:(NSString *)msg;

@end
