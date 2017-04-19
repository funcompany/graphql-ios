//
//  GraphQLTypes.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/18/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "GraphQLTypes.h"
#import "NSDictionary+JSONEncodable.h"

@implementation GraphQLMapConvertible
@dynamic jsonValue;

- (id)jsonValue {
  return self.graphQLMap.jsonValue;
}

@end
