//
//  Field.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/18/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

@interface Field : NSObject
@property (nonatomic, strong) NSString *responseName;
@property (nonatomic, strong) NSString *fieldName;
@property (nonatomic, strong) NSDictionary <NSString *, id<JSONEncodable>> *arguments;
@property (nonatomic, strong) NSString *cacheKey;

- (instancetype)initWithResponseName:(NSString *)responseName fieldName:(NSString *)fieldName arguments:(NSDictionary <NSString *, id<JSONEncodable>>*)arguments;
- (NSString *)orderIndependentKeyForObject:(NSDictionary <NSString *, id>*)object;
@end
