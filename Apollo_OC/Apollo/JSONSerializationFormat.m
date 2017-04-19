//
//  JSONSerializationFormat.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/14/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "JSONSerializationFormat.h"

@implementation JSONSerializationFormat

- (NSData *)serialize:(id<JSONEncodable>)value {
  return [NSJSONSerialization dataWithJSONObject:value options:0 error:nil];
}

- (JSONValue)deserialize:(NSData *)data {
  return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

@end
