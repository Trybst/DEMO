//
//  YTableHeaderView.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/8.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTableHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *rightTitle;

@property (copy, nonatomic) void(^tapAction)(void);

@end
