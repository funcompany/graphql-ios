//
//  FetchQueryOperation.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/14/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "FetchQueryOperation.h"

@implementation FetchQueryOperation

- (instancetype)initWithClient:(GQClient *)client query:(GraphQLQuery *)query cachePolicy:(CachePolicy)cachePolicy context:(NSInteger)context handlerQueue:(dispatch_queue_t)handlerQueue resultHandler:(OperationResultHandler)resultHandler {
  self = [super init];
  if (self) {
    self.client = client;
    self.query = query;
    self.cachePolicy = cachePolicy;
    self.context = context;
    self.handlerQueue = handlerQueue;
    self.resultHandler = resultHandler;
  }
  return self;
}

- (void)start {
  if (self.isCancelled) {
    self.state = StateFinished;
    return;
  }
  self.state = StateExecuting;
  
  if (self.cachePolicy == CachePolicyFetchIgnoringCacheData) {
    [self fetchFromNetwork];
    return;
  }
  
  [self.client.store loadQuery:self.query cacheKeyForObject:self.client.cacheKeyForObject resultHandler:^(GraphQLResult *result, NSError *error) {
    if (error) {
      [self notifyResultHandlerWithResult:result error:error];
      self.state = StateFinished;
      return;
    }
    if (self.isCancelled) {
      self.state = StateFinished;
      return;
    }
    if (self.cachePolicy == CachePolicyReturnCacheDataDontFetch) {
      [self notifyResultHandlerWithResult:nil error:nil];
      self.state = StateFinished;
      return;
    }
    [self fetchFromNetwork];
  }];
}

- (void)fetchFromNetwork {
  self.networkTask = [self.client send:self.query context:self.context handlerQueue:self.handlerQueue resultHandler:^(GraphQLResult *result, NSError *error) {
    [self notifyResultHandlerWithResult:result error:error];
    self.state = StateFinished;
  }];
}

- (void)cancel {
  [super cancel];
  [self.networkTask cancel];
}

- (void)notifyResultHandlerWithResult:(GraphQLResult *)result error:(NSError *)error {
  if (self.resultHandler) {
    dispatch_async(self.handlerQueue, ^{
      self.resultHandler(result, error);
    });
  }
}

@end
