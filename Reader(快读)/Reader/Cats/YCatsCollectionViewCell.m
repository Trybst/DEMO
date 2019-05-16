//
//  YCatsCollectionViewCell.m
//  Reader
//
//  Created by Bing Ma on 7/7/17.
//  Copyright © 2017 SF. All rights reserved.
//

#import "YCatsCollectionViewCell.h"

@implementation YCatsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        int w = frame.size.width;
        int h = frame.size.height;
        
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 30)];
        _nameLbl.center = CGPointMake(w/2, h/2 - 5);
        _nameLbl.textAlignment = NSTextAlignmentCenter;
        _nameLbl.textColor = [UIColor blackColor];
        _nameLbl.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:_nameLbl];
        
        _bookCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, _nameLbl.frame.origin.y + 15, w, 30)];
        _bookCountLbl.textAlignment = NSTextAlignmentCenter;
        _bookCountLbl.textColor = [UIColor darkGrayColor];
        _bookCountLbl.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_bookCountLbl];
        
        self.contentView.layer.cornerRadius = 4.0;
        self.contentView.clipsToBounds = YES;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = YRGBColor(65, 176, 222).CGColor;//[UIColor colorWithWhite:0.5f alpha:1.0f].CGColor;
    
    }
    
    return self;
}

@end
