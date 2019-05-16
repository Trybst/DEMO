//
//  YBookCatsBookListViewController.h
//  Reader
//
//  Created by Bing Ma on 7/7/17.
//  Copyright © 2017 SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBookCatsSubModel.h"

@interface YBookCatsBookListViewController : UIViewController

@property (nonatomic, strong) YBookCatsSubModel *model;
@property (nonatomic, copy)   NSString          *gender;
@property (nonatomic, copy)   NSString          *titleText;

@end
