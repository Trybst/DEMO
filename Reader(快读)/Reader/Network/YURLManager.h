//
//  YURLManager.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/9.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,YAPIType) {
    YAPITypeFuzzySearch,
    YAPITypeAutoCompletion,
    YAPITypeBookCover,
    YAPITypeBookDetail,
    YAPITypeRecommendBook,
    YAPITypeRecommendBookList,
    YAPITypeBookReview,
    YAPITypeAuthorAvatar,
    YAPITypeBookSummary,
    YAPITypeChaptersLink,
    YAPITypeChapterContent,
    YAPITypeBookUpdate,
    YAPITypeRanking,
    YAPITypeRankingDetial,
    // add new type of book detial.
    YAPITypeTagBookList,
    YAPITypeAuthorBookList,
    // add new type for book category.
    YAPITypeCatsList,
    YAPITypeCatsSubList,
    YAPITypeCatsBookList,
};

@interface YURLManager : NSObject

+ (NSURL *)getURLWith:(YAPIType)type parameter:(id)parameter;

@end
