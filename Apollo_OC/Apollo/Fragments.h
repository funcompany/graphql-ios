//
//  Fragments.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/18/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphQLTypes.h"

@interface GraphQLConditionalFragment : NSObject <GraphQLMappable>
@property (nonatomic, strong) NSMutableArray <NSString *> *possibleTypes;
@end

@interface GraphQLNamedFragment : GraphQLConditionalFragment
@property (nonatomic, strong) NSString *fragmentDefinition;
@end
