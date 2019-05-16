//
//  MBAlphaImageView.m
//  Reader
//
//  Created by Bing Ma on 6/22/17.
//  Copyright © 2017 SF. All rights reserved.
//

#import "MBAlphaImageView.h"

@implementation MBAlphaImageView

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/


/**
 *  iOS中的pointInside:withEvent:方法是用来判断当前的点击或者触摸事件的点是否在当前的view中，
 它被hitTest:withEvent:调用，通过对每个子视图调用pointInside:withEvent:决定最终哪个视图来响应此事件。
 如果一个子视图的pointInside:withEvent:返回NO，说明这个子视图不会响应点击事件，
 然后就去寻找更深层的子视图来找到最终响应触摸事件；
 返回YES就说明子视图能响应点击事件（但不一定是子视图本身响应，若子视图还有子视图的话，还会继续循环去找最终响应事件的子子视图）。
 *
 *  @param point 点击的位置
 *
 *  @return 是否往下传递
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    CGFloat alpha = [self getImageAlphaWithPointInside:point];
    NSLog(@"alpha%f",alpha);
    /*  那么pixel数组中唯一元素的值就是手指触摸点那一个像素的alpha值，
     *  做归一化为与0.01比较，如果小于0.01就表明手指触摸点是透明的，
     *  这时候返回NO就能够实现穿透效果，相反大于0.01就不会穿透
     *  BOOL transparent = alpha < 0.01f;
     *
     */
    BOOL transparent = alpha < 0.01f;
    
    return !transparent;
}

/**
 *  获取图片的一个像素点的Alpha值
 *
 *  @param point 图片的位置
 *
 *  @return 对于像素点的Alpha值
 */
- (CGFloat)getImageAlphaWithPointInside:(CGPoint)point{
    
    unsigned char pixel[1] = {0};
    CGContextRef context = CGBitmapContextCreate(pixel,
                                                 1, 1, 8, 1, NULL,
                                                 kCGImageAlphaOnly);
    UIGraphicsPushContext(context);
    [self.image drawAtPoint:CGPointMake(-point.x, -point.y)];
    UIGraphicsPopContext();
    CGContextRelease(context);
    CGFloat alpha = pixel[0]/255.0f;
    
    
    
    return alpha;
}

@end
