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
@property (nonatomic, strong) NSMutableDictionary <NSString *, Record *> *storage;
- (instancetype)init:(NSArray <Record *> *)records;
- (BOOL)isEmpty;
- (void)insert:(Record *)record;
- (void)insertContentsOf:(NSArray <Record *> *)records;
- (Record *)recordForKey:(NSString *)key;
- (NSSet <NSString *> *)mergeRecords:(RecordSet *)records;
- (NSSet <NSString *> *)mergeRecord:(Record *)record;
@end
