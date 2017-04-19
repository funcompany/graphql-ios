//
//  GraphQLError.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
@property (nonatomic) NSInteger line;
@property (nonatomic) NSInteger column;
- (instancetype)initWithObject:(NSDictionary <JSONObject>*)object;
@end


@interface GraphQLError : NSError

- (instancetype)initWithObject:(NSDictionary <JSONObject> *)object;
- (instancetype)initWithMessage:(NSString *)message;
- (id)infoForKey:(NSString *)key;
- (NSString *)message;
- (NSArray <Location *> *)locations;
- (NSString *)description;
- (NSString *)errorDescription;

@end
