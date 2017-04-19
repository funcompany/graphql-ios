//
//  ApolloStore.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "ApolloStore.h"
#import "GraphQLResult.h"
#import "ApolloClient.h"
#import "CacheKeyForObject.h"
#import "GraphQLResultReader.h"
#import "GraphQLResultNormalizer.h"
#import "NSArray+Map.h"

@implementation ApolloStore

- (instancetype)init {
  self = [super init];
  if (self) {
    self.queue = dispatch_queue_create("com.apollographql.ApolloStore", DISPATCH_CURRENT_QUEUE_LABEL);
    self.subscribers = [NSMutableArray array];
    self.records = [[RecordSet alloc] init];
  }
  return self;
}

- (instancetype)initWithRecords:(RecordSet *)records {
  self = [self init];
  self.records = records;
  return self;
}

+ (NSString *)rootKeyForOperation:(GraphQLOperation *)operation {
  if ([operation isKindOfClass:[GraphQLQuery class]]) {
    return @"QUERY_ROOT";
  } else if ([operation isKindOfClass:[GraphQLMutation class]]) {
    return @"MUTATION_ROOT";
  }
  NSAssert(NO, @"Unknown operation type");
  return nil;
}

- (void)publish:(RecordSet *)records context:(NSInteger)context {
  dispatch_barrier_async(self.queue, ^{
    NSSet <NSString *> *changedKeys = [self.records mergeRecords:records];
    for (ApolloStoreSubscriber *subscriber in self.subscribers) {
      [subscriber store:self didChangeKeys:changedKeys context:context];
    }
  });
}

- (void)subscribe:(ApolloStoreSubscriber *)subscriber {
  dispatch_barrier_async(self.queue, ^{
    [self.subscribers addObject:subscriber];
  });
}

- (void)unsubscribe:(ApolloStoreSubscriber *)subscriber {
  dispatch_barrier_async(self.queue, ^{
    [self.subscribers removeObject:subscriber];
  });
}

- (void)loadQuery:(GraphQLQuery *)query cacheKeyForObject:(CacheKeyForObject)cacheKeyForObject resultHandler:(OperationResultHandler)resultHandler {
  dispatch_async(self.queue, ^{
    @try {
      NSString *rootKey = [ApolloStore rootKeyForOperation:query];
      Record *rootRecord = [self.records recordForKey:rootKey];
      NSDictionary <NSString *, id> *rootObject = rootRecord ? rootRecord.fields : nil;
      GraphQLResultReader *reader = [[GraphQLResultReader alloc] initWithVariables:query.variables resolver:^id(Field *field, NSDictionary<NSString *,id> *object, GraphQLResolveInfo *info) {
        id goodObject = object ?: rootObject;
        NSDictionary <NSString *, id> *value = goodObject[field.cacheKey];
        return [self complete:value];
      }];
      GraphQLResultNormalizer *normalizer = [[GraphQLResultNormalizer alloc] initWithRootKey:rootKey];
      normalizer.cacheKeyForObject = cacheKeyForObject;
      
      reader.delegate = normalizer;
      
      Class ResponseDataClass = [query responseDataClass];
      
      id data = [[ResponseDataClass alloc] initWithReader:reader];
      NSSet <NSString *> *dependentKeys = normalizer.dependentKeys;
      GraphQLResult *result = [[GraphQLResult alloc] initWithData:data errors:nil dependentKeys:dependentKeys];
      resultHandler(result, nil);
    } @catch (NSException *exception) {
      resultHandler(nil, [NSError errorWithDomain:exception.name code:0 userInfo:exception.userInfo]);
    }
  });
}

- (id)complete:(id)value {
  if ([value isKindOfClass:[Reference class]]) {
    Reference *reference = value;
    Record *record = [self.records recordForKey:reference.key];
    return record ? record.fields : nil;
  } else if ([value isKindOfClass:[NSArray class]]) {
    NSArray *array = value;
    NSArray *completedValues = [array map:^id(id obj, NSUInteger idx) {
      return [self complete:obj];
    }];
    return completedValues;
  } else {
    return value;
  }
}

@end


@implementation ApolloStoreSubscriber

- (void)store:(ApolloStore *)store didChangeKeys:(NSSet <NSString *>*)changedKeys context:(NSInteger)context {
  NSAssert(NO, @"Should not get here");
}

@end
