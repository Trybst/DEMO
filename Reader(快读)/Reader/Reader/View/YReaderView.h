//
//  YReaderView.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/13.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YReaderView : UIView

@property (strong, nonatomic) NSAttributedString *content;
@property (assign, nonatomic) CTFrameRef contentFrame;

@end
