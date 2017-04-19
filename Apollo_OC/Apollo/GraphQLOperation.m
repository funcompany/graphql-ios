//
//  GraphQLOperation.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "GraphQLOperation.h"

@implementation GraphQLOperation

- (instancetype)init {
  self = [super init];
  if (self) {
    self.variables = [NSMutableDictionary dictionary];
  }
  return self;
}

- (NSString *)queryDocument {
  return self.operationDefinition;
}

- (instancetype)initWithReader:(GraphQLResultReader *)reader {
  self = [self init];
  NSAssert(NO, @"Should not get here, sub class should overwrite this method");
  return self;
}

- (Class)responseDataClass {
  return [self class];
}

@end


@implementation GraphQLQuery

@end

@implementation GraphQLMutation

@end

//@implementation GraphQLFragment
//
//- (instancetype)init {
//  self = [super init];
//  if (self) {
//    self.possibleTypes = [NSMutableArray array];
//  }
//  return self;
//}
//
//@end
