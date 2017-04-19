//
//  NSMutableArray+Concat.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/13/17.
//  Copyright © 2017 demo. All rights reserved.
//

#import "NSMutableArray+Concat.h"

@implementation NSMutableArray (Concat)
- (void)concat:(NSArray *)array {
  [self addObjectsFromArray:array];
}
@end
