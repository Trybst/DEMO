//
//  YCenterViewController.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/8.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YShowState) {
    YShowStateLeft,
    YShowStateRight,
    YShowStateMenu
};

@interface YCenterViewController : YBaseViewController

@property (copy, nonatomic) void(^tapBarButton)(YShowState);
-(void)autoRefreshbooks;

@end
