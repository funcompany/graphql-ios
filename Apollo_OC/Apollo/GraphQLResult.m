//
//  GraphQLResult.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "GraphQLResult.h"

@implementation GraphQLResult

- (instancetype)initWithData:(id<GraphQLMappable>)data errors:(NSArray <GraphQLError *> *)errors dependentKeys:(NSSet <CacheKey *> *)dependentKeys {
  self = [super init];
  if (self) {
    self.data = data;
    self.errors = errors;
    self.dependentKeys = dependentKeys;
  }
  return self;
}

@end
