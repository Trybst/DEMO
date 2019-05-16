//
//  MBTableViewCell.h
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
#import "MBSettingCustomItem.h"

@interface MBTableViewCell : UITableViewCell

// custom create the cell.
+ (instancetype)cellWithTablewview:(UITableView *)tableView;

// receive the model's data, from the other place.
@property (nonatomic, strong)MBSettingItem *item;

@end
