//
//  GraphQLResponse.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "GraphQLResponse.h"
#import "GraphQLError.h"
#import "GraphQLResultNormalizer.h"
#import "ApolloStore.h"
#import "GraphQLResult.h"
#import "NSArray+Map.h"

@implementation GraphQLResponse

- (instancetype)initWithOperation:(GraphQLOperation *)operation body:(NSDictionary <NSString *, id> *)body {
  self = [super init];
  if (self) {
    self.operation = operation;
    self.body = body;
  }
  return self;
}

- (ApolloTuple *)parseResult:(CacheKeyForObject)cacheKeyForObject {
  GraphQLOperation *data = nil;
  NSSet <NSString *> *dependentKeys = nil;
  RecordSet *records = nil;
  
  NSDictionary <NSString *, id> *dataEntry = (NSDictionary *)self.body[@"data"];
  if (dataEntry) {
    GraphQLResultReader *reader = [[GraphQLResultReader alloc] initWithVariables:self.operation.variables resolver:^id(Field *field, NSDictionary<NSString *,id> *object, GraphQLResolveInfo *info) {
      return (object ?: dataEntry)[field.responseName];
    }];
    
    reader.dataEntry = dataEntry;
    
    GraphQLResultNormalizer *normalizer = [[GraphQLResultNormalizer alloc] initWithRootKey:[ApolloStore rootKeyForOperation:self.operation]];
    normalizer.cacheKeyForObject = cacheKeyForObject;
    reader.delegate = normalizer;
    
    data = [[[self.operation responseDataClass] alloc] initWithReader:reader];
    
    records = normalizer.records;
    dependentKeys = normalizer.dependentKeys;
  }
  
  NSArray *errors = nil;
  NSArray <NSDictionary <NSString *, id>*> *errorsEntry = self.body[@"errors"];
  if (errorsEntry) {
    errors = [errorsEntry map:^id(id obj, NSUInteger idx) {
      return [[GraphQLError alloc] initWithObject:obj];
    }];
  }
  GraphQLResult *result = [[GraphQLResult alloc] initWithData:data errors:errors dependentKeys:dependentKeys];
  return [ApolloTuple withFirst:result second:records];
}

@end
