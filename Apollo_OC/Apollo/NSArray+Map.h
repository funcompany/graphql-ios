//
//  NSArray+Map.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/13/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^FUNCTION1)(id);

@interface NSArray (Map)
- (NSArray *)flatten;
- (NSArray *)map:(id (^)(id obj, NSUInteger idx))block;
- (NSArray *)flatMap:(id (^)(id obj, NSUInteger idx))block;
@end
