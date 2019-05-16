//
//  YSQLiteManager.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/10.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YBookDetailModel,YBookSummaryModel;

@interface YSQLiteManager : NSObject

@property (strong, nonatomic, readonly) YYCache *cache;
@property (copy, nonatomic, readonly) NSArray *userBooks;

+ (instancetype)shareManager;

- (NSArray *)getHistorySearchTextArray;
- (void)updateHistorySearchTextArrayWith:(NSArray *)array;

- (YBookDetailModel *)addUserBooksWith:(YBookDetailModel *)bookM;
- (void)removeUserBookWith:(YBookDetailModel *)bookM;
- (void)stickyUserBookWith:(YBookDetailModel *)bookM;
- (void)updateUserBooksStatus;


- (YBookSummaryModel *)getBookSummaryWith:(YBookDetailModel *)bookM;
- (void)updateBookSummaryWith:(YBookDetailModel *)bookM summaryM:(YBookSummaryModel *)summaryM;

- (void)deleteBookWith:(YBookDetailModel *)bookM;
- (BOOL)isAddedBookListWith:(YBookDetailModel *)bookM;

@end
