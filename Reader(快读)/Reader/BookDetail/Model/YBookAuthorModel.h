//
//  YBookAuthorModel.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/10.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseModel.h"

@interface YBookAuthorModel : YBaseModel

@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * gender;
@property (nonatomic, assign) NSInteger lv;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * type;

@end
