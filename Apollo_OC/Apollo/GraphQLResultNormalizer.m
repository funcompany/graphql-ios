//
//  GraphQLResultNormalizer.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/13/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "GraphQLResultNormalizer.h"
#import "GraphQLResultReader.h"

@interface GraphQLResultNormalizer ()
@property (nonatomic, strong) NSMutableArray <Record *> *recordStack;
@property (nonatomic, strong) Record *currentRecord;
@property (nonatomic, strong) NSMutableArray <NSArray <NSString *> *> *pathStack;
@property (nonatomic, strong) NSMutableArray <NSString *> *path;
@property (nonatomic, strong) NSMutableArray <JSONValue> *valueStack;
@end

@implementation GraphQLResultNormalizer

- (instancetype)init {
  self = [super init];
  if (self) {
    self.dependentKeys = [NSMutableSet set];
    self.pathStack = [NSMutableArray array];
    self.path = [NSMutableArray array];
    self.valueStack = [NSMutableArray array];
  }
  return self;
}

- (instancetype)initWithRootKey:(CacheKey *)rootKey {
  self = [self init];
  self.records = [[RecordSet alloc] init:nil];
  self.recordStack = [NSMutableArray array];
  self.currentRecord = [[Record alloc] initWithKey:rootKey fields:nil];
  return self;
}

- (void)willResolve:(Field *)field info:(GraphQLResolveInfo *)info {
  [self.path addObject:field.cacheKey];
}

- (void)didResolve:(Field *)field info:(GraphQLResolveInfo *)info {
  [self.path removeLastObject];
  
  id value = self.valueStack.lastObject;
  [self.valueStack removeObject:value];
  
  NSString *dependentKey = [@[self.currentRecord.key, field.cacheKey] componentsJoinedByString:@"."];
  [self.dependentKeys addObject:dependentKey];
  
  [self.currentRecord setRecordValue:value forKey:field.cacheKey];
  
  if (self.recordStack.count <= 0) {
    [self.records mergeRecord:self.currentRecord];
  }
}

- (void)didParse:(JSONValue)value {
  [self.valueStack addObject:value];
}

- (void)didParseNull {
  [self.valueStack addObject:[NSNull null]];
}

- (void)willParse:(NSDictionary <JSONObject> *)object {
  [self.pathStack addObject:self.path];
  
  CacheKey *cacheKey;
  if (self.cacheKeyForObject && self.cacheKeyForObject(object)) {
    JSONValue value = self.cacheKeyForObject(object);
//    cacheKey = String(describing: value)
    cacheKey = [value description];
    self.path = [NSMutableArray arrayWithObject:cacheKey];
  } else {
    cacheKey = [self.path componentsJoinedByString:@"."];
  }
  [self.recordStack addObject:self.currentRecord];
  self.currentRecord = [[Record alloc] initWithKey:cacheKey fields:nil];
}

- (void)didParseJSONObject:(NSDictionary <JSONObject> *)object {
  self.path = self.pathStack.lastObject.mutableCopy;
  [self.pathStack removeObject:self.path];
  
  Reference *reference = [[Reference alloc] initWithKey:self.currentRecord.key];
  [self.valueStack addObject:reference];
  [self.dependentKeys addObject:self.currentRecord.key];
  [self.records mergeRecord:self.currentRecord];
  self.currentRecord = self.recordStack.lastObject;
  [self.recordStack removeObject:self.currentRecord];
}

- (void)willParseElements:(NSArray *)array {
//  valueStack.reserveCapacity(valueStack.count + array.count)
}

- (void)willParseElementAtIndex:(NSInteger)index {
  [self.path addObject:[@(index) stringValue]];
}

- (void)didParseElementAtIndex:(NSInteger)index {
  [self.path removeLastObject];
}

- (void)didParseElements:(NSArray *)array {
  NSInteger location = 0;
  if (array.count < self.valueStack.count) {
    location = self.valueStack.count - array.count;
  }
  NSArray *parsedArray = [NSArray arrayWithArray:[self.valueStack subarrayWithRange:NSMakeRange(location, array.count)]];
  [self.valueStack removeObjectsInRange:NSMakeRange(location, array.count)];
  [self.valueStack addObject:parsedArray];
}

@end
