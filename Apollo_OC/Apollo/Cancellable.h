//
//  Cancellable.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/13/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Cancellable <NSObject>

- (void)cancel;

@end

@interface Cancellable : NSObject <Cancellable>
- (void)cancel;
@end
