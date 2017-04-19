//
//  ApolloTuple.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/17/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "ApolloTuple.h"

@implementation ApolloTuple

- (instancetype)initWithFirst:(id)first second:(id)second third:(id)third fouth:(id)fouth {
  self = [super init];
  if (self) {
    self.first = first;
    self.second = second;
    self.third = third;
    self.fouth = fouth;
  }
  return self;
}

+ (instancetype)withFirst:(id)first second:(id)second {
  return [[self alloc] initWithFirst:first second:second third:nil fouth:nil];
}

+ (instancetype)withFirst:(id)first second:(id)second third:(id)third {
  return [[self alloc] initWithFirst:first second:second third:third fouth:nil];
}

+ (instancetype)withFirst:(id)first second:(id)second third:(id)third fouth:(id)fouth {
  return [[self alloc] initWithFirst:first second:second third:third fouth:fouth];
}

@end
