//
//  GQClient.m
//  Apollo_OC
//
//  Created by Travel Chu on 3/30/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "GQClient.h"
#import "HTTPNetworkTransport.h"
#import "FetchQueryOperation.h"
#import "GraphQLQueryWatcher.h"

@implementation GQClient

- (instancetype)initWithNetworkTransport:(id<NetworkTransport>)networkTransport store:(ApolloStore *)store {
  self = [super init];
  if (self) {
    self.networkTransport = networkTransport;
    self.store = store ?: [[ApolloStore alloc] init];
    self.queue = dispatch_queue_create("com.apollographql.ApolloClient", DISPATCH_CURRENT_QUEUE_LABEL);
    self.operationQueue = [[NSOperationQueue alloc] init];
  }
  return self;
}

- (instancetype)initWithUrl:(NSURL *)url {
  return [self initWithNetworkTransport:[[HTTPNetworkTransport alloc] initWithUrl:url configuration:nil] store:self.store];
}


/// Fetches a query from the server or from the local cache, depending on the current contents of the cache and the specified cache policy.
///
/// - Parameters:
///   - query: The query to fetch.
///   - cachePolicy: A cache policy that specifies when results should be fetched from the server and when data should be loaded from the local cache.
///   - queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.
///   - resultHandler: An optional closure that is called when query results are available or when an error occurs.
///   - result: The result of the fetched query, or `nil` if an error occurred.
///   - error: An error that indicates why the fetch failed, or `nil` if the fetch was succesful.
/// - Returns: An object that can be used to cancel an in progress fetch.
- (id<Cancellable>)fetch:(GraphQLQuery *)query resultHandler:(OperationResultHandler)resultHandler {
  return [self _fetch:query cachePolicy:CachePolicyReturnCacheDataElseFetch context:-1 queue:dispatch_get_main_queue() resultHandler:resultHandler];
}

- (id<Cancellable>)_fetch:(GraphQLQuery *)query cachePolicy:(CachePolicy)cachePolicy context:(NSInteger)context queue:(dispatch_queue_t)queue resultHandler:(OperationResultHandler)resultHandler {
  // If we don't have to go through the cache, there is no need to create an operation
  // and we can return a network task directly
  if (cachePolicy == CachePolicyFetchIgnoringCacheData) {
    return [self send:query context:context handlerQueue:queue resultHandler:resultHandler];
  } else {
    FetchQueryOperation *operation = [[FetchQueryOperation alloc] initWithClient:self query:query cachePolicy:cachePolicy context:context handlerQueue:queue resultHandler:resultHandler];
    [self.operationQueue addOperation:operation];
    return operation;
  }
}

/// Watches a query by first fetching an initial result from the server or from the local cache, depending on the current contents of the cache and the specified cache policy. After the initial fetch, the returned query watcher object will get notified whenever any of the data the query result depends on changes in the local cache, and calls the result handler again with the new result.
///
/// - Parameters:
///   - query: The query to fetch.
///   - cachePolicy: A cache policy that specifies when results should be fetched from the server or from the local cache.
///   - queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.
///   - resultHandler: An optional closure that is called when query results are available or when an error occurs.
///   - result: The result of the fetched query, or `nil` if an error occurred.
///   - error: An error that indicates why the fetch failed, or `nil` if the fetch was succesful.
/// - Returns: A query watcher object that can be used to control the watching behavior.
- (GraphQLQueryWatcher *)watch:(GraphQLQuery *)query resultHandler:(OperationResultHandler)resultHandler {
  GraphQLQueryWatcher *watcher = [[GraphQLQueryWatcher alloc] initWithClient:self query:query handlerQueue:dispatch_get_main_queue() resultHandler:resultHandler];
  [watcher fetch:CachePolicyReturnCacheDataElseFetch];
  return watcher;
}


/// Performs a mutation by sending it to the server.
///
/// - Parameters:
///   - mutation: The mutation to perform.
///   - queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.
///   - resultHandler: An optional closure that is called when mutation results are available or when an error occurs.
///   - result: The result of the performed mutation, or `nil` if an error occurred.
///   - error: An error that indicates why the mutation failed, or `nil` if the mutation was succesful.
/// - Returns: An object that can be used to cancel an in progress mutation.
- (id<Cancellable>)perform:(GraphQLMutation *)mutation queue:(dispatch_queue_t)queue resultHandler:(OperationResultHandler)resultHandler {
  if (!queue) {
    queue = dispatch_get_main_queue();
  }
  return [self _perform:mutation context:-1 queue:queue resultHandler:resultHandler];
}

- (id<Cancellable>)_perform:(GraphQLMutation *)mutation context:(NSInteger)context queue:(dispatch_queue_t)queue resultHandler:(OperationResultHandler)resultHandler {
  return [self send:mutation context:context handlerQueue:queue resultHandler:resultHandler];
}

- (id<Cancellable>)send:(GraphQLOperation *)Operation context:(NSInteger)context handlerQueue:(dispatch_queue_t)handlerQueue resultHandler:(OperationResultHandler)resultHandler {
  return [self.networkTransport send:Operation completionHandler:^(GraphQLResponse *response, NSError *error) {
    if (!response) {
      [self notifyResultHandler:nil error:error handlerQueue:handlerQueue resultHandler:resultHandler];
      return;
    }
    dispatch_async(self.queue, ^{
      @try {
        GQTuple *tuple = [response parseResult:self.cacheKeyForObject];
        GraphQLResult *result = tuple.first;
        RecordSet *records = tuple.second;
        [self notifyResultHandler:result error:nil handlerQueue:handlerQueue resultHandler:resultHandler];
        if (records) {
          [self.store publish:records context:context];
        }
      } @catch (NSException *exception) {
        [self notifyResultHandler:nil error:[NSError errorWithDomain:@"" code:0 userInfo:exception.userInfo] handlerQueue:handlerQueue resultHandler:resultHandler];
      }
    });
  }];
}

- (void)notifyResultHandler:(GraphQLResult *)result error:(NSError *)error handlerQueue:(dispatch_queue_t)handlerQueue resultHandler:(OperationResultHandler)resultHandler {
  if (!resultHandler) {
    return;
  }
  
  dispatch_async(handlerQueue, ^{
    resultHandler(result, error);
  });
}

@end
