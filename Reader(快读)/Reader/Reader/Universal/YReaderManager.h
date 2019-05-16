//
//  YReaderManager.h
//  YReader 
//
//  Created by Bing Ma on 2016/12/13.
//  Copyright © 2016年 Hannb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBookSummaryModel.h"
#import "YChapterContentModel.h"
#import "YChaptersLinkModel.h"
#import "YBookDetailModel.h"
#import "YReaderRecord.h"

@interface YReaderManager : NSObject

@property (strong, nonatomic, readonly) NSMutableArray *chaptersArr;
@property (strong, nonatomic, readonly) YBookDetailModel *readingBook;
@property (strong, nonatomic, readonly) YBookSummaryModel *selectSummary;
@property (strong, nonatomic, readonly) YReaderRecord *record;
@property (assign, nonatomic, readonly) NSUInteger chaptersCount;
@property (copy, nonatomic) void(^cancelLoadingCompletion)(void);
@property (copy, nonatomic) void(^cancelGetChapterCompletion)(void);

+ (instancetype)shareReaderManager;
- (void)updateReadingBook:(YBookDetailModel *)bookM completion:(void(^)(void))completion failure:(void (^)(NSString *msg))failure;
- (void)updateBookSummary:(YBookSummaryModel *)summaryM completion:(void(^)(void))completion failure:(void (^)(NSString *msg))failure;
- (void)updateReadingBookChaptersContent;
- (void)updateBookChaptersLink;
- (void)autoLoadNextChapters:(NSUInteger)index;
- (void)updateReadingChapter:(NSUInteger)chapter page:(NSUInteger)page;
- (void)closeReadingBook;
- (void)cancelLoadReadingBook;
- (void)getChapterContentWith:(NSUInteger)chapter completion:(void(^)(void))completion failure:(void (^)(NSString *msg))failure;
- (void)cancelGetChapterContent;
@end



