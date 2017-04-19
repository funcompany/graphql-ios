//
//  GQClient.h
//  Apollo_OC
//
//  Created by Travel Chu on 3/30/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphQLOperation.h"
#import "GraphQLResult.h"
#import "NetworkTransport.h"
#import "ApolloStore.h"
#import "OperationResultHandler.h"

typedef NS_ENUM(NSUInteger, CachePolicy) {
  // Return data from the cache if available, else fetch results from the server.
  CachePolicyReturnCacheDataElseFetch,
  //  Always fetch results from the server.
  CachePolicyFetchIgnoringCacheData,
  // Return data from the cache if available, else return nil.
  CachePolicyReturnCacheDataDontFetch,
};

@class FetchQueryOperation;
@class GraphQLQueryWatcher;
@interface GQClient : NSObject
@property (nonatomic, strong) id<NetworkTransport> networkTransport;
@property (nonatomic, strong) ApolloStore *store;
@property (nonatomic) CacheKeyForObject cacheKeyForObject;
@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

- (instancetype)initWithNetworkTransport:(id<NetworkTransport>)networkTransport store:(ApolloStore *)store;
- (instancetype)initWithUrl:(NSURL *)url;

- (id<Cancellable>)fetch:(GraphQLQuery *)query resultHandler:(OperationResultHandler)resultHandler;
- (GraphQLQueryWatcher *)watch:(GraphQLQuery *)query resultHandler:(OperationResultHandler)resultHandler;
- (id<Cancellable>)_fetch:(GraphQLQuery *)query cachePolicy:(CachePolicy)cachePolicy context:(NSInteger)context queue:(dispatch_queue_t)queue resultHandler:(OperationResultHandler)resultHandler;
- (id<Cancellable>)send:(GraphQLOperation *)Operation context:(NSInteger)context handlerQueue:(dispatch_queue_t)handlerQueue resultHandler:(OperationResultHandler)resultHandler;

@end
