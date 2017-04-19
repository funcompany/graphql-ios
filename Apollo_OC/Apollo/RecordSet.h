//
//  RecordSet.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/13/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Record.h"

@interface RecordSet : NSObject
@property (nonatomic, strong) NSMutableDictionary <CacheKey *, Record *> *storage;
- (instancetype)init:(NSArray <Record *> *)records;
- (BOOL)isEmpty;
- (void)insert:(Record *)record;
- (void)insertContentsOf:(NSArray <Record *> *)records;
- (Record *)recordForKey:(CacheKey *)key;
- (NSSet <CacheKey *> *)mergeRecords:(RecordSet *)records;
- (NSSet <CacheKey *> *)mergeRecord:(Record *)record;
@end
