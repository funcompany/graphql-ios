//
//  JSONSerializationFormat.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/14/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

@interface JSONSerializationFormat : NSObject
- (NSData *)serialize:(id<JSONEncodable>)value;
- (JSONValue)deserialize:(NSData *)data;
@end
