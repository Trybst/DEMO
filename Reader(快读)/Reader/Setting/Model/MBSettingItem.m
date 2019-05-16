//
//  MBSettingItem.m
//  MoneyEasy
//
//  Created by Bing Ma on 15/11/2.
//  Copyright © 2015 Bing Ma. All rights reserved.
//

#import "MBSettingItem.h"

@implementation MBSettingItem

+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title {
    MBSettingItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    return item;
}

@end
