//
//  MBSettingItem.h
//  MoneyEasy
//
//  Created by Bing Ma on 15/11/2.
//  Copyright © 2015 Bing Ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^myOption) (void);

@interface MBSettingItem : NSObject
/**
 *  图标
 */
@property (nonatomic, strong)UIImage *image;
/**
 *  标题
 */
@property (nonatomic, copy)NSString *title;
/**
 *  子标题
 */
@property (nonatomic, copy)NSString *subTitle;

/**
 *  保存将来需要执行的代码
 */
@property (nonatomic, copy)myOption option;

/**
 *  快速创建item
 *
 *  @param image 图片
 *  @param title 标题
 *
 *  @return item对象
 */
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title;
@end
