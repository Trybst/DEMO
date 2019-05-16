//
//  YBookUpdateModel.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/18.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import "YBaseModel.h"

@interface YBookUpdateModel : YBaseModel

@property (nonatomic, strong) NSString * author;
@property (nonatomic, assign) NSInteger chaptersCount;
@property (nonatomic, strong) NSString * lastChapter;
@property (nonatomic, strong) NSString * referenceSource;
@property (nonatomic, strong) NSDate * updated;

@end
