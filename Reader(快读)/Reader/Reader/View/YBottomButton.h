//
//  YBottomButton.h
//  YReader
//
//  Created by Bing Ma on 2016/12/12.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBottomButton : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageView;

@property (copy, nonatomic) void(^tapAction)(NSInteger);

+ (instancetype)bottonWith:(NSString *)title imageName:(NSString *)imageName tag:(NSInteger)tag;

- (void)setTitle:(NSString *)title imageName:(NSString *)imageName;

@end
