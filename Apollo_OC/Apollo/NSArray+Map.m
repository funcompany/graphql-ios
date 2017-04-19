//
//  NSArray+Map.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/13/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "NSArray+Map.h"
#import "NSMutableArray+Concat.h"

@implementation NSArray (Map)

- (NSArray *)map:(id (^)(id obj, NSUInteger idx))block {
  NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [result addObject:block(obj, idx) ?: [NSNull null]];
  }];
  return result;
}

- (NSArray *)flatMap:(id (^)(id obj, NSUInteger idx))block {
  NSArray *flattenArray = [self flatten];
  NSMutableArray *result = [NSMutableArray arrayWithCapacity:[flattenArray count]];
  [flattenArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [result addObject:block(obj, idx) ?: [NSNull null]];
  }];
  return result;
}

- (NSArray *)flatten {
  NSMutableArray *array = [NSMutableArray array];
  
  for (id object in self) {
    if ([object isKindOfClass:NSArray.class]) {
      [array concat:[object flatten]];
    } else {
      [array addObject:object];
    }
  }
  
  return array;
}

@end
