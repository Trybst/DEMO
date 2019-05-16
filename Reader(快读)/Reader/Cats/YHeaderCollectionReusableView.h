//
//  YHeaderCollectionReusableView.h
//  Reader
//
//  Created by Bing Ma on 7/7/17.
//  Copyright © 2017 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHeaderCollectionReusableView : UICollectionReusableView

@property(nonatomic,strong)UILabel *titleLbl;

- (void)setHeaderTitle:(NSString *)title;

@end
