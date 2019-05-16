//
//  YReaderViewController.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/11.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseViewController.h"
@class YBookDetailModel;

@interface YReaderViewController : YBaseViewController

@property (assign, nonatomic) BOOL isFirstRead;
@property (strong, nonatomic) YBookDetailModel *readingBook;

@end
