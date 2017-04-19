//
//  JSONStandardTypeConversions.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/19/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "JSONStandardTypeConversions.h"

@implementation NSString (JSON)
@dynamic jsonValue;

- (instancetype)init:(JSONValue)value {
  if (![value isKindOfClass:[NSString class]]) {
    NSString *info = [NSString stringWithFormat:@"JSONDecodingError.couldNotConvert(value: %@, to: %@)", value, NSStringFromClass([NSString class])];
    @throw [NSException exceptionWithName:info reason:info userInfo:nil];
  }
  self = value;
  return self;
}

- (JSONValue)jsonValue {
  return self;
}

@end
