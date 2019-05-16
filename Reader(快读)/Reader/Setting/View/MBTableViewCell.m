//
//  MBTableViewCell.m
//  MoneyEasy
//
//  Created by Bing Ma on 15/11/2.
//  Copyright © 2015 Bing Ma. All rights reserved.
//

#import "MBTableViewCell.h"

@interface MBTableViewCell ()

@property (nonatomic, strong)UIImageView *arrowAccessoryView;
@property (nonatomic, strong)UISwitch *switchAccessoryView;
@property (nonatomic, strong)UILabel *labbelAccessoryView;

// custom accessory view.
@property (nonatomic, strong)UIView *customAccessoryView;
@end

@implementation MBTableViewCell

+ (instancetype)cellWithTablewview:(UITableView *)tableView {
    static NSString *identifier = @"customCell";
    MBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MBTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setItem:(MBSettingItem *)item {
    _item = item;
    
    // 1. init the data.
    self.imageView.image = item.image;
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    self.detailTextLabel.textColor = [UIColor redColor];
    
    // 2. init the model setting data.
    [self setupRightView];
}

/**
 *  setting the cell's reight accessory view.
 */
- (void)setupRightView {
    // judge: is current cell --> model's type.
    if ([self.item isKindOfClass:[MBSettingArrowItem class]]) {
        
        self.accessoryView = self.arrowAccessoryView;
//        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    } else if ([self.item isKindOfClass:[MBSettingSwitchItem class]]) {
        
        MBSettingSwitchItem *swItem = (MBSettingSwitchItem *)self.item;
        self.switchAccessoryView.on = NO;
        self.switchAccessoryView.on = swItem.open;
        self.accessoryView = self.switchAccessoryView;
        
    } else if ([self.item isKindOfClass:[MBSettingLabelItem class]]) {
        
        MBSettingLabelItem *lblItem = (MBSettingLabelItem *)self.item;
        self.labbelAccessoryView.text = lblItem.labelInfo;
        self.labbelAccessoryView.textColor = kMBColor(200, 200, 200, 1);
        [self.labbelAccessoryView sizeToFit];
        self.accessoryView = self.labbelAccessoryView;

    } else if ([self.item isKindOfClass:[MBSettingCustomItem class]]) {
        
        MBSettingCustomItem *customItem = (MBSettingCustomItem *)self.item;
        self.customAccessoryView = customItem.customView;
        [self.customAccessoryView sizeToFit];
        self.accessoryView = self.customAccessoryView;
        
    } else {
        self.accessoryView = nil;
    }
}

#pragma mark - lazy
- (UIImageView *)arrowAccessoryView {
    if (!_arrowAccessoryView) {
        _arrowAccessoryView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _arrowAccessoryView;
}

- (UISwitch *)switchAccessoryView {
    if (!_switchAccessoryView) {
        _switchAccessoryView =  [[UISwitch alloc] init];
    }
    return _switchAccessoryView;
}

- (UILabel *)labbelAccessoryView {
    if (!_labbelAccessoryView) {
        _labbelAccessoryView =  [[UILabel alloc] init];
    }
    return _labbelAccessoryView;
}

- (UIView *)customAccessoryView {
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    }
    return _customAccessoryView;
}

@end
