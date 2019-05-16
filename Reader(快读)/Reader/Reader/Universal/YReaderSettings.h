//
//  YReaderSettings.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/12.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseModel.h"
#import "YReaderUniversal.h"

@interface YReaderSettings : YBaseModel

+ (instancetype)shareReaderSettings;

@property (assign, nonatomic) double brightness;
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) BOOL isTraditional;
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) YReaderTheme theme;
@property (assign, nonatomic) YTurnPageStyle pageStyle;
@property (assign, nonatomic) BOOL isNightMode;
@property (assign, nonatomic) CGFloat fontSize;

@property (copy, nonatomic) void(^refreshReaderView)(void);
@property (copy, nonatomic) void(^refreshPageStyle)(void);

@property (strong, nonatomic, readonly) UIColor *textColor;
@property (strong, nonatomic, readonly) UIColor *otherTextColor;//其他如标题,电池,时间等
@property (strong, nonatomic, readonly) NSDictionary *readerAttributes;
@property (strong, nonatomic, readonly) UIImage *themeImage;
@property (strong, nonatomic, readonly) NSArray *themeImageArr;

- (NSString *)transformToTraditionalWith:(NSString *)string;

- (void)updateFontFormat;

@end
