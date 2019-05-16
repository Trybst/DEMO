//
//  YDirectoryViewCell.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/16.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YChapterContentModel.h"

@interface YDirectoryViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberLabelWidth;

@property (assign, nonatomic) BOOL isReadingChapter;
@property (assign, nonatomic) NSUInteger count;
@property (strong, nonatomic) YChapterContentModel *chapterM;

@end
