//
//  GraphQLQueryWatcher.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "GraphQLQueryWatcher.h"
#import "NSSet+Disjoint.h"

@implementation GraphQLQueryWatcher

- (instancetype)initWithClient:(GQClient *)client query:(GraphQLQuery *)query handlerQueue:(dispatch_queue_t)handlerQueue resultHandler:(OperationResultHandler)resultHandler {
  self = [super init];
  if (self) {
    self.client = client;
    self.query = query;
    self.handlerQueue = handlerQueue;
    self.resultHandler = resultHandler;
    self.context = 0;
    self.dependentKeys = [NSMutableSet set];
  }
  return self;
}

- (void)refetch {
  [self fetch:CachePolicyFetchIgnoringCacheData];
}

- (void)fetch:(CachePolicy)cachePolicy {
  if (self.client) {
    self.fetching = [self.client _fetch:self.query cachePolicy:cachePolicy context:self.context queue:self.handlerQueue resultHandler:^(GraphQLResult *result, NSError *error) {
      if (result) {
        self.dependentKeys = result.dependentKeys.mutableCopy;
      }
      self.resultHandler(result, error);
    }];
  }
}

- (void)cancel {
  if (self.fetching) {
    [self.fetching cancel];
  }
  if (self.client) {
    [self.client.store unsubscribe:self];
  }
}

- (void)store:(ApolloStore *)store didChangeKeys:(NSSet <NSString *>*)changedKeys context:(NSInteger)context {
  if (context == self.context) {
    return;
  }
  if (!self.dependentKeys) {
    return;
  }
  if (![self.dependentKeys isDisjointWithSet:changedKeys]) {
    [self fetch:CachePolicyReturnCacheDataElseFetch];
  }
}

@end
