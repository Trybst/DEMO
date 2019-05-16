//
//  MBPiecewiseView.m
//  Loan
//
//  Created by Bing Ma on 5/5/17.
//  Copyright © 2017 CQ (Hannb). All rights reserved.
//

#import "MBPiecewiseView.h"

@implementation MBPiecewiseView {
    CGRect _fram;
    UIView *_linView;
    NSArray *_normalImages;
    NSArray *_seletedImages;
    UIView *_linBackView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _fram = frame;
        _normalImages = [NSArray array];
        _seletedImages = [NSArray array];
    }
    return self;
}

- (void)loadTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    [self loadMainView];
}

- (void)loadNormalImage:(NSArray *)normalImages seletedImage:(NSArray *)seletedImage {
    _normalImages = normalImages;
    for (int i = 0; i< normalImages.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(_fram.size.width/normalImages.count), 0, _fram.size.width/normalImages.count, _fram.size.height-2);
        button.tag = 10 + i;
        [button setImage:[UIImage imageNamed:normalImages[i]] forState:UIControlStateNormal];
        if (seletedImage != nil) {
            [button setImage:[UIImage imageNamed:seletedImage[i]] forState:UIControlStateSelected];
        }
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)loadMainView {
    switch (_type) {
        case PiecewiseInterfaceTypeMobileLin:
        {
            [self loadMobileLinView];
        }
            break;
        case PiecewiseInterfaceTypeBackgroundChange:
        {
            [self loadBackgroundChangeView];
        }
            break;
        case PiecewiseInterfaceTypeCustomImage:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)loadMobileLinView {
    if (!_textSeletedColor) {
        _textSeletedColor = _textNormalColor;
    }
    _linBackView = [[UIView alloc]initWithFrame:CGRectMake(0, _fram.size.height-1, _fram.size.width, 1)];
    _linBackView.backgroundColor = _linBackColor;
    [self addSubview:_linBackView];
    _linView = [[UIView alloc]initWithFrame:CGRectMake(0, _fram.size.height-1.5, _fram.size.width/_titleArray.count, 1.5)];
    _linView.backgroundColor = _linColor;
    [self addSubview:_linView];
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i*(_fram.size.width/_titleArray.count), 0, _fram.size.width/_titleArray.count, _fram.size.height-2);
        button.tag = 10 + i;
        button.titleLabel.font = _textFont;
        i == 0?([button setTitleColor:_textSeletedColor forState:UIControlStateNormal]):([button setTitleColor:_textNormalColor forState:UIControlStateNormal]);
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)loadBackgroundChangeView {
    if (!_textSeletedColor) {
        _textSeletedColor = _textNormalColor;
    }
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i*(_fram.size.width/_titleArray.count), 0, _fram.size.width/_titleArray.count, _fram.size.height);
        button.tag = 10 + i;
        button.titleLabel.font = _textFont;
        i == 0?(button.backgroundColor = _backgroundSeletedColor):(button.backgroundColor = _backgroundNormalColor);
        i == 0?([button setTitleColor:_textSeletedColor forState:UIControlStateNormal]):([button setTitleColor:_textNormalColor forState:UIControlStateNormal]);
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}



- (void)buttonPressed:(UIButton *)sender {
    
    switch (_type) {
        case PiecewiseInterfaceTypeMobileLin:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _linView.frame = CGRectMake(sender.frame.origin.x, _linView.frame.origin.y, _linView.frame.size.width, 1.5);
                
            } completion:nil];
            for (int i = 0; i<_titleArray.count; i++) {
                UIButton *button = (UIButton *)[self viewWithTag:i + 10];
                sender.tag == (i+10)?([button setTitleColor:_textSeletedColor forState:UIControlStateNormal]):([button setTitleColor:_textNormalColor forState:UIControlStateNormal]);
            }
        }
            break;
        case PiecewiseInterfaceTypeBackgroundChange:
        {
            for (int i = 0; i<_titleArray.count; i++) {
                UIButton *button = (UIButton *)[self viewWithTag:i + 10];
                sender.tag == (i+10)?(button.backgroundColor = _backgroundSeletedColor):(button.backgroundColor = _backgroundNormalColor);
                sender.tag == (i+10)?([button setTitleColor:_textSeletedColor forState:UIControlStateNormal]):([button setTitleColor:_textNormalColor forState:UIControlStateNormal]);
            }
            
        }
            break;
        case PiecewiseInterfaceTypeCustomImage:
        {
            for (int i = 0; i<_normalImages.count; i++) {
                UIButton *button = (UIButton *)[self viewWithTag:i + 10];
                sender.tag == (i+10)?(button.selected = YES):(button.selected = NO);
            }
        }
            break;
            
        default:
            break;
    }
    
    if (_delegate &&[_delegate respondsToSelector:@selector(piecewiseView:index:)]){
        [self.delegate piecewiseView:self index:sender.tag - 10];
    }
}
@end
