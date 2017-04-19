//
//  NetworkTransport.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "NetworkTransport.h"

@implementation NetworkTransport

- (id<Cancellable>)send:(GraphQLOperation *)operation completionHandler:(void(^)(GraphQLResponse *response, NSError *error))completionHandler {
  NSAssert(NO, @"Should not get here");
  return nil;
}

@end
