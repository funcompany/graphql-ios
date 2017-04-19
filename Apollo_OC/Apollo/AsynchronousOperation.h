//
//  AsynchronousOperation.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/14/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, State) {
  StateInitialized,
  StateReady,
  StateExecuting,
  StateFinished
};

@interface AsynchronousOperation : NSOperation

@property (nonatomic) State state;

+ (NSSet <NSString *>*)keyPathsForValuesAffectingIsExecuting;
+ (NSSet <NSString *>*)keyPathsForValuesAffectingIsFinished;
- (BOOL)isAsynchronous;
- (BOOL)isReady;
- (BOOL)isExecuting;
- (BOOL)isFinished;

@end
