//
//  MBAboutView.m
//  MoneyEasy
//
//  Created by Bing Ma on 11/9/15.
//  Copyright © 2015 Bing Ma. All rights reserved.
//

#import "MBAboutView.h"

@interface MBAboutView ()
@property (weak, nonatomic) IBOutlet UILabel *appVersionLbl;

@end

@implementation MBAboutView

-(void)awakeFromNib {
    [super awakeFromNib];

    self.appVersionLbl.text = [NSString stringWithFormat:@"%@ v%@", @"快·读", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
}

@end
