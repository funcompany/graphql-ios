//
//  GraphQLTypes.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/18/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphQLResultReader.h"

@protocol GraphQLMappable <NSObject>

- (instancetype)initWithReader:(GraphQLResultReader *)reader;

@end

@protocol GraphQLMapConvertible <JSONEncodable>

@property (nonatomic, strong) NSMutableDictionary <GraphQLMap> *graphQLMap;

@end

@interface GraphQLMapConvertible : NSObject <GraphQLMapConvertible>

@property (nonatomic, strong) NSMutableDictionary <GraphQLMap> *graphQLMap;

- (JSONValue)jsonValue;

@end
