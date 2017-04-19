//
//  GraphQLResult.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphQLError.h"
#import "GraphQLTypes.h"

@interface GraphQLResult : NSObject

@property (nonatomic, strong) id<GraphQLMappable> data;
@property (nonatomic, strong) NSArray <GraphQLError *> *errors;
@property (nonatomic, strong) NSSet <NSString *> *dependentKeys;

- (instancetype)initWithData:(id<GraphQLMappable>)data errors:(NSArray <GraphQLError *> *)errors dependentKeys:(NSSet <NSString *> *)dependentKeys;

@end


