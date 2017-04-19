//
//  Fragments.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/18/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "Fragments.h"

@implementation GraphQLConditionalFragment

- (instancetype)init {
  self = [super init];
  if (self && !self.possibleTypes) {
    self.possibleTypes = [NSMutableArray array];
  }
  return self;
}

- (instancetype)initWithReader:(GraphQLResultReader *)reader {
  self = [self init];
  return self;
}

- (instancetype)initWithReader:(GraphQLResultReader *)reader ifTypeMatches:(NSString *)typeName {
  if (![self.possibleTypes containsObject:typeName]) {
    return nil;
  }
  self = [self initWithReader:reader];
  return self;
}

@end
