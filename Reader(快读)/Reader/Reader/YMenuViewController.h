//
//  YMenuViewController.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/13.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseViewController.h"

@interface YMenuViewController : YBaseViewController

@property (copy, nonatomic) void(^menuTapAction)(NSInteger);
- (void)showMenuView;

@end
