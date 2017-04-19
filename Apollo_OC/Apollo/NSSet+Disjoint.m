//
//  NSSet+Disjoint.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/17/17.
//  Copyright © 2017 demo. All rights reserved.
//

#import "NSSet+Disjoint.h"

@implementation NSSet (Disjoint)

- (BOOL)isDisjointWithSet:(NSSet *)other {
  BOOL isDisjoint = NO;
  for (id object in other) {
    if ([self containsObject:object]) {
      isDisjoint = YES;
      break;
    }
  }
  return isDisjoint;
}

@end
