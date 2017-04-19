//
//  GraphQLResponse.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphQLOperation.h"
#import "CacheKeyForObject.h"
#import "GQTuple.h"

@interface GraphQLResponse : GraphQLOperation
@property (nonatomic, strong) GraphQLOperation *operation;
@property (nonatomic, strong) NSDictionary <NSString *, id> *body;

- (instancetype)initWithOperation:(GraphQLOperation *)operation body:(NSDictionary <NSString *, id> *)body;
- (GQTuple *)parseResult:(CacheKeyForObject)cacheKeyForObject;
@end
