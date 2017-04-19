//
//  NSHTTPURLResponse+Utilities.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/17/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "NSHTTPURLResponse+Utilities.h"

@implementation NSHTTPURLResponse (Utilities)

- (BOOL)isSuccessful {
  return (self.statusCode >= 200 && self.statusCode < 300);
}

@end
