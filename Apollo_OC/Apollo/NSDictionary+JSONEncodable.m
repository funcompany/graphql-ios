//
//  NSDictionary+JSONEncodable.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/10/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "NSDictionary+JSONEncodable.h"

@implementation NSDictionary (JSONEncodable)
@dynamic jsonValue;

- (JSONValue)jsonValue {
  return self.jsonObject;
}

- (NSDictionary <JSONObject> *)jsonObject {
  NSMutableDictionary *jsonObject = [NSMutableDictionary dictionary];
  for (NSString *key in self.allKeys) {
    id value = self[key];
    if (value && [value conformsToProtocol:@protocol(JSONEncodable)]) {
      jsonObject[key] = [(id<JSONEncodable>)value jsonValue];
    }
  }
  return jsonObject;
}

@end
