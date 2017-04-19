//
//  NSDictionary+JSONEncodable.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/10/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

@interface NSDictionary (JSONEncodable) <JSONEncodable>

- (JSONValue)jsonValue;
- (NSDictionary <JSONObject> *)jsonObject;

@end
