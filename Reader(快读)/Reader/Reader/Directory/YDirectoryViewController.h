//
//  YDirectoryViewController.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/16.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseViewController.h"

@interface YDirectoryViewController : YBaseViewController

@property (assign, nonatomic) NSUInteger readingChapter;
@property (strong, nonatomic) NSArray *chaptersArr;
@property (copy, nonatomic)   NSString *bookTitle;
@property (copy, nonatomic)   void(^selectChapter)(NSUInteger);

@end
