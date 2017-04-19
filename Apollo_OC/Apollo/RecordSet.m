//
//  RecordSet.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/13/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "RecordSet.h"
#import "NSArray+Map.h"

@implementation RecordSet

- (instancetype)init:(NSArray <Record *> *)records {
  self = [super init];
  if (self) {
    self.storage = [NSMutableDictionary dictionary];
    if (records) {
      [self insertContentsOf:records];
    }
  }
  return self;
}

- (BOOL)isEmpty {
  return self.storage.allKeys.count <= 0;
}

- (void)insert:(Record *)record {
  self.storage[record.key] = record;
}

- (void)insertContentsOf:(NSArray <Record *> *)records {
  for (Record *record in records) {
    [self insert:record];
  }
}

- (Record *)recordForKey:(NSString *)key {
  return self.storage[key];
}

- (NSSet <NSString *> *)mergeRecords:(RecordSet *)records {
  NSMutableSet *changedKeys = [NSMutableSet set];
  for (Record *record in records.storage.allValues) {
    [changedKeys unionSet:[self mergeRecord:record]];
  }
  return changedKeys;
}

- (NSSet <NSString *> *)mergeRecord:(Record *)record {
  Record *oldRecord = self.storage[record.key];
  if (oldRecord) {
    [self.storage removeObjectForKey:record.key];
    NSMutableSet *changedKeys = [NSMutableSet set];
    for (NSString *key in record.fields.allKeys) {
      id oldValue = oldRecord.fields[key];
      id value = record.fields[key];
      if ([oldValue isEqual:value]) {
        continue;
      }
      oldRecord.fields[key] = value;
      [changedKeys addObject:[@[record.key, key] componentsJoinedByString:@"."]];
    }
    self.storage[record.key] = oldRecord;
    return changedKeys;
  } else {
    self.storage[record.key] = record;
    return [NSSet setWithArray:[record.fields.allKeys map:^id(NSString *obj, NSUInteger idx) {
      return [@[record.key, obj] componentsJoinedByString:@"."];
    }]];
  };
}

@end
