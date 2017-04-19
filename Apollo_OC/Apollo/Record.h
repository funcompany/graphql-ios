//
//  Record.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/7/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Record : NSObject

@property (nonatomic, strong) CacheKey * _Nonnull key;
@property (nonatomic, strong) NSMutableDictionary <JSONObject> * _Nonnull fields;

- (instancetype _Nonnull)initWithKey:(CacheKey * _Nonnull)key fields:(NSMutableDictionary <JSONObject> *_Nullable)fields;
- (JSONValue _Nonnull)valueForKey:(CacheKey * _Nonnull)key;
- (void)setRecordValue:(JSONValue _Nonnull)value forKey:(CacheKey * _Nonnull)key;

- (NSString * _Nonnull)description;

@end


@interface Reference : NSObject

@property (nonatomic, strong) CacheKey * _Nonnull key;

- (instancetype _Nonnull)initWithKey:(CacheKey * _Nonnull)key;
- (BOOL)isEqual:(Reference *_Nonnull)object;
- (NSString * _Nonnull)description;

@end
