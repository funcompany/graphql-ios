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

typedef id (^GraphQLResolver)(Field *field, NSDictionary <NSString *, id> *object, GraphQLResolveInfo *info);

@protocol GraphQLResultReaderDelegate <NSObject>

- (void)willResolve:(Field *)field info:(GraphQLResolveInfo *)info;
- (void)didResolve:(Field *)field info:(GraphQLResolveInfo *)info;
- (void)didParse:(id)value;
- (void)didParseNull;
- (void)willParse:(NSDictionary <NSString *, id> *)object;
- (void)didParseJSONObject:(NSDictionary <NSString *, id> *)object;
- (void)willParseElements:(NSArray *)array;
- (void)willParseElementAtIndex:(NSInteger)index;
- (void)didParseElementAtIndex:(NSInteger)index;
- (void)didParseElements:(NSArray *)array;

@end

@interface GraphQLResultReader : NSObject
@property (nonatomic, strong) NSDictionary <NSString *, id> *dataEntry;
@property (nonatomic, strong) NSDictionary <NSString *, id<JSONEncodable>> *variables;
@property (nonatomic, strong) GraphQLResolver resolver;
@property (nonatomic, weak) id<GraphQLResultReaderDelegate> delegate;
@property (nonatomic, strong) NSMutableArray <NSDictionary <NSString *, id> *> *objectStack;

@property (nonatomic, strong) GraphQLResolveInfo *resolveInfo;

- (NSDictionary <NSString *, id> *)currentObject;
- (instancetype)initWithVariables:(NSDictionary <NSString *, id<JSONEncodable>> *)variables resolver:(GraphQLResolver)resolver;
- (instancetype)initWithRootObject:(NSDictionary <NSString *, id> *)rootObject;
- (id)valueForField:(Field *)field;
- (id)listForField:(Field *)field;

@end
