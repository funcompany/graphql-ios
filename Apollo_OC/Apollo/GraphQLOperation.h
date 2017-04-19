//
//  GraphQLOperation.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "GraphQLResultReader.h"
#import "GraphQLTypes.h"

@interface GraphQLOperation : NSObject <GraphQLMappable>
@property (nonatomic, strong) NSString *operationDefinition;
@property (nonatomic, strong) NSString *queryDocument;
@property (nonatomic, strong) NSMutableDictionary <GraphQLMap> *variables;

- (NSString *)queryDocument;
- (instancetype)initWithReader:(GraphQLResultReader *)reader;
- (Class)responseDataClass;
@end

@interface GraphQLQuery : GraphQLOperation

@end

@interface GraphQLMutation : GraphQLOperation

@end

//@interface GraphQLFragment : GraphQLOperation
//@property (nonatomic, strong) NSArray <NSString *>*possibleTypes;
//@end
