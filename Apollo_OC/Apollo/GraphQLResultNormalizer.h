//
//  GraphQLResultNormalizer.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/13/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "RecordSet.h"
#import "CacheKeyForObject.h"
#import "GraphQLResultReader.h"

@class Field;
@class GraphQLResolveInfo;
@interface GraphQLResultNormalizer : NSObject <GraphQLResultReaderDelegate>
@property (nonatomic, strong) RecordSet *records;
@property (nonatomic, strong) NSMutableSet <NSString *> *dependentKeys;
@property (nonatomic, strong) CacheKeyForObject cacheKeyForObject;

- (instancetype)initWithRootKey:(NSString *)rootKey;

//- (void)willResolve:(Field *)field info:(GraphQLResolveInfo *)info;
//- (void)didResolve:(Field *)field info:(GraphQLResolveInfo *)info;
//- (void)didParse:(id)value;
//- (void)didParseNull;
//- (void)willParse:(NSDictionary <NSString *, id> *)object;
//- (void)didParseJSONObject:(NSDictionary <NSString *, id> *)object;
//- (void)willParseElements:(NSArray *)array;
//- (void)willParseElementAtIndex:(NSInteger)index;
//- (void)didParseElementAtIndex:(NSInteger)index;
//- (void)didParseElements:(NSArray *)array;

@end
