//
//  NetworkTransport.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphQLResponse.h"
#import "Cancellable.h"

@protocol NetworkTransport <NSObject>

- (id<Cancellable>)send:(GraphQLOperation *)operation completionHandler:(void(^)(GraphQLResponse *response, NSError *error))completionHandler;

@end

@interface NetworkTransport : NSObject <NetworkTransport>

@end
