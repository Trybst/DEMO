//
//  MBBaseTableViewController.m
//  MoneyEasy
//
//  Created by Bing Ma on 15/11/2.
//  Copyright © 2015 Bing Ma. All rights reserved.
//

#import "MBBaseTableViewController.h"
#import "MBSettingItem.h"
#import "MBTableViewCell.h"

@interface MBBaseTableViewController ()

@end

@implementation MBBaseTableViewController

- (instancetype)init {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {

    }
    return self;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *group = self.datas[section];
    return group.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MBTableViewCell *cell = [MBTableViewCell cellWithTablewview:tableView];
    // pass the current model data.
    NSArray *group = self.datas[indexPath.section];
    // get out the current row's item.
    MBSettingItem *item = group[indexPath.row];
    cell.item = item;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.take out the current section.
    NSArray *group = self.datas[indexPath.section];
    // 2.take out the current row.
    MBSettingItem *item  = group[indexPath.row];
    // 3.the block code, to do something.
    if (item.option != nil) {
        item.option();
    }
}

#pragma mark - lazy
- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
