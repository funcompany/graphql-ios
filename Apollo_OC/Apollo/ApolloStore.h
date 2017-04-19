//
//  ApolloStore.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordSet.h"
#import "Record.h"
#import "GraphQLOperation.h"
#import "CacheKeyForObject.h"
#import "OperationResultHandler.h"

@class ApolloStoreSubscriber;
@class ReadWriteTransaction;
@interface ApolloStore : NSObject
@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic, strong) RecordSet *records;
@property (nonatomic, strong) NSMutableArray <ApolloStoreSubscriber *> *subscribers;
//@property (nonatomic) CacheKeyForObject cacheKeyForObject;
//@property (nonatomic, strong) NormalizedCache *cache;


// We need a separate read/write lock for cache access because cache operations are
// asynchronous and we don't want to block the dispatch threads
//@property (nonatomic, strong) ReadWriteLock *cacheLock;

+ (CacheKey *)rootKeyForOperation:(GraphQLOperation *)operation;

- (void)publish:(RecordSet *)records context:(NSInteger)context;

- (void)subscribe:(ApolloStoreSubscriber *)subscriber;

- (void)unsubscribe:(ApolloStoreSubscriber *)subscriber;

- (void)loadQuery:(GraphQLQuery *)query cacheKeyForObject:(CacheKeyForObject)cacheKeyForObject resultHandler:(OperationResultHandler)resultHandler;

@end

@interface ApolloStoreSubscriber : NSObject
- (void)store:(ApolloStore *)store didChangeKeys:(NSSet <CacheKey *>*)changedKeys context:(NSInteger)context;
@end
