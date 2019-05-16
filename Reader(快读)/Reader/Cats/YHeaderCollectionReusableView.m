//
//  YHeaderCollectionReusableView.m
//  Reader
//
//  Created by Bing Ma on 7/7/17.
//  Copyright © 2017 SF. All rights reserved.
//

#import "YHeaderCollectionReusableView.h"

@implementation YHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    
    if (self) {
        
//        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 2, 22)];
//        imgV.image = [UIImage imageNamed:@"line"];
//        [self addSubview:imgV];
        
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 1)];
//        line.backgroundColor = [UIColor lightGrayColor];//graycolor_back;
//        [self addSubview:line];
        
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, kScreenSize.width - 100, 34)];
        _titleLbl.textColor = [UIColor darkGrayColor];
        _titleLbl.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_titleLbl];
        
//        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 49, kScreenSize.width, 1)];
//        lineV.backgroundColor = [UIColor lightGrayColor];//graycolor_back;
//        [self addSubview:lineV];
    }
    return self;
}


- (void)setHeaderTitle:(NSString *)title {
    _titleLbl.text = title;
}

@end
