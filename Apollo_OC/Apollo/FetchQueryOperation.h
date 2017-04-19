//
//  FetchQueryOperation.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/14/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "AsynchronousOperation.h"
#import "ApolloClient.h"

@interface FetchQueryOperation : AsynchronousOperation <Cancellable>

@property (nonatomic, strong) ApolloClient *client;
@property (nonatomic, strong) GraphQLQuery *query;
@property (nonatomic,) CachePolicy cachePolicy;
@property (nonatomic) NSInteger context;
@property (nonatomic) dispatch_queue_t handlerQueue;
@property (nonatomic) OperationResultHandler resultHandler;
@property (nonatomic, strong) id<Cancellable>networkTask;

- (instancetype)initWithClient:(ApolloClient *)client query:(GraphQLQuery *)query cachePolicy:(CachePolicy)cachePolicy context:(NSInteger)context handlerQueue:(dispatch_queue_t)handlerQueue resultHandler:(OperationResultHandler)resultHandler;
- (void)cancel;

@end
