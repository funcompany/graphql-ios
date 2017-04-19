//
//  Record.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/7/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Record : NSObject

@property (nonatomic, strong) NSString * _Nonnull key;
@property (nonatomic, strong) NSMutableDictionary <NSString *, id> * _Nonnull fields;

- (instancetype _Nonnull)initWithKey:(NSString * _Nonnull)key fields:(NSMutableDictionary <NSString *, id> *_Nullable)fields;
- (id _Nonnull)valueForKey:(NSString * _Nonnull)key;
- (void)setRecordValue:(id _Nonnull)value forKey:(NSString * _Nonnull)key;

- (NSString * _Nonnull)description;

@end


@interface Reference : NSObject

@property (nonatomic, strong) NSString * _Nonnull key;

- (instancetype _Nonnull)initWithKey:(NSString * _Nonnull)key;
- (BOOL)isEqual:(Reference *_Nonnull)object;
- (NSString * _Nonnull)description;

@end
