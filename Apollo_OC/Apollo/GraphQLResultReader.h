//
//  GraphQLResultReader.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/18/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Field.h"

@interface GraphQLResolveInfo : NSObject
@property (nonatomic, strong) NSMutableArray <NSString *> *path;
@end

typedef JSONValue (^GraphQLResolver)(Field *field, NSDictionary <JSONObject> *object, GraphQLResolveInfo *info);

@protocol GraphQLResultReaderDelegate <NSObject>

- (void)willResolve:(Field *)field info:(GraphQLResolveInfo *)info;
- (void)didResolve:(Field *)field info:(GraphQLResolveInfo *)info;
- (void)didParse:(JSONValue)value;
- (void)didParseNull;
- (void)willParse:(NSDictionary <JSONObject> *)object;
- (void)didParseJSONObject:(NSDictionary <JSONObject> *)object;
- (void)willParseElements:(NSArray *)array;
- (void)willParseElementAtIndex:(NSInteger)index;
- (void)didParseElementAtIndex:(NSInteger)index;
- (void)didParseElements:(NSArray *)array;

@end

@interface GraphQLResultReader : NSObject
@property (nonatomic, strong) NSDictionary <GraphQLMap> *variables;
@property (nonatomic, strong) GraphQLResolver resolver;
@property (nonatomic, weak) id<GraphQLResultReaderDelegate> delegate;
@property (nonatomic, strong) NSMutableArray <NSDictionary <JSONObject> *> *objectStack;

@property (nonatomic, strong) GraphQLResolveInfo *resolveInfo;

- (NSDictionary <JSONObject> *)currentObject;
- (instancetype)initWithVariables:(NSDictionary <GraphQLMap> *)variables resolver:(GraphQLResolver)resolver;
- (instancetype)initWithRootObject:(NSDictionary <JSONObject> *)rootObject;
- (id)valueForField:(Field *)field;
- (id)listForField:(Field *)field;

@end
