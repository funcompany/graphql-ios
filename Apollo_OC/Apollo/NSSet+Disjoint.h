//
//  NSSet+Disjoint.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/17/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (Disjoint)

- (BOOL)isDisjointWithSet:(NSSet *)other;

@end
