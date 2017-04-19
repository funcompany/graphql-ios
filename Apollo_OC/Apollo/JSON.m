//
//  GQJSON.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/7/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "JSON.h"
#import "Record.h"

@implementation JSON

- (JSONValue)optional:(JSONValue)optionalValue {
  if (!optionalValue) {
    @throw [NSException exceptionWithName:@"JSONDecodingError.missingValue" reason:@"JSONDecodingError.missingValue" userInfo:nil];
  }
  
  if ([optionalValue isKindOfClass:[NSNull class]]) {
    return nil;
  }
  
  return optionalValue;
}

- (JSONValue)required:(JSONValue)optionalValue {
  if (!optionalValue) {
    @throw [NSException exceptionWithName:@"JSONDecodingError.missingValue" reason:@"JSONDecodingError.missingValue" userInfo:nil];
  }
  
  if ([optionalValue isKindOfClass:[NSNull class]]) {
    @throw [NSException exceptionWithName:@"JSONDecodingError.nullValue" reason:@"JSONDecodingError.nullValue" userInfo:nil];
  }
  
  return optionalValue;
}

- (JSONValue)cast:(JSONValue)value toKind:(Class)clazz {
  if (![value isKindOfClass:clazz]) {
    NSString *info = [NSString stringWithFormat:@"JSONDecodingError.couldNotConvert(value: %@, to: %@)", value, NSStringFromClass(clazz)];
    @throw [NSException exceptionWithName:info reason:info userInfo:nil];
  }
  return value;
}

- (BOOL)equals:(id)lhs rhs:(id)rhs {
  return [lhs isEqual:rhs];
}

@end

@implementation JSONDecodable

- (instancetype)init:(id)value {
  self = [super init];
  NSAssert(NO, @"");
  return self;
}

@end


@implementation JSONEncodable


@end
