//
//  OperationResultHandler.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/17/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//
#import "GraphQLResult.h"

#ifndef OperationResultHandler_h
#define OperationResultHandler_h

typedef void(^OperationResultHandler)(GraphQLResult *result, NSError *error);

#endif /* OperationResultHandler_h */
