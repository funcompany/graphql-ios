//
//  AsynchronousOperation.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/14/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "AsynchronousOperation.h"
#import <Foundation/NSKeyValueObserving.h>

@implementation AsynchronousOperation

+ (NSSet <NSString *>*)keyPathsForValuesAffectingIsExecuting {
  return [NSSet setWithObject:@"state"];
}

+ (NSSet <NSString *>*)keyPathsForValuesAffectingIsFinished {
  return [NSSet setWithObject:@"state"];
}

- (void)setState:(State)state {
  if (_state != state) {
    [self willChangeValueForKey:@"state"];
    _state = state;
    [self didChangeValueForKey:@"state"];
  }
}

- (BOOL)isAsynchronous {
  return YES;
}

- (BOOL)isReady {
  BOOL ready = [super isReady];
  if (ready) {
    self.state = StateReady;
  }
  return YES;
}

- (BOOL)isExecuting {
  return self.state == StateExecuting;
}

- (BOOL)isFinished {
  return self.state == StateFinished;
}

@end
