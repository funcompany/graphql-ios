//
//  GraphQLQueryWatcher.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "GQClient.h"

@interface GraphQLQueryWatcher : ApolloStoreSubscriber <Cancellable>

@property (nonatomic, weak) GQClient *client;
@property (nonatomic, strong) GraphQLQuery *query;
@property (nonatomic) dispatch_queue_t handlerQueue;
@property (nonatomic) OperationResultHandler resultHandler;

@property (nonatomic) NSInteger context;
@property (nonatomic, weak) id<Cancellable>fetching;
@property (nonatomic, strong) NSMutableSet <NSString *> *dependentKeys;

- (instancetype)initWithClient:(GQClient *)client query:(GraphQLQuery *)query handlerQueue:(dispatch_queue_t)handlerQueue resultHandler:(OperationResultHandler)resultHandler;
- (void)refetch;
- (void)fetch:(CachePolicy)cachePolicy;
- (void)cancel;

@end
