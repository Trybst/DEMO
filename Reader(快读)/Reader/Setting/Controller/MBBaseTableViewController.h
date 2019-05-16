//
//  MBBaseTableViewController.h
//  MoneyEasy
//
//  Created by Bing Ma on 15/11/2.
//  Copyright © 2015 Bing Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBSettingItem.h"
#import "MBSettingLabelItem.h"
#import "MBSettingSwitchItem.h"
#import "MBSettingArrowItem.h"

@interface MBBaseTableViewController : UITableViewController
@property (nonatomic, strong)NSMutableArray *datas;
@end
