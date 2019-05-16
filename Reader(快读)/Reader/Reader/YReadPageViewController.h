//
//  YReadPageViewController.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/12.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseViewController.h"

@interface YReadPageViewController : YBaseViewController

@property (strong, nonatomic) NSString *booktitle;
@property (strong, nonatomic) NSAttributedString *pageContent;
@property (assign, nonatomic) NSUInteger page;
@property (assign, nonatomic) NSUInteger totalPage;
@property (assign, nonatomic) NSUInteger chapter;

@end
