//
//  YRecommendBookListModel.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/10.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseModel.h"

@interface YRecommendBookListModel : YBaseModel

@property (nonatomic, strong) NSString * author;
@property (nonatomic, assign) NSInteger bookCount;
@property (nonatomic, assign) NSInteger collectorCount;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * title;

@end
