//
//  Field.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/18/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "Field.h"
#import "NSDictionary+JSONEncodable.h"

@implementation Field

- (instancetype)initWithResponseName:(NSString *)responseName fieldName:(NSString *)fieldName arguments:(NSDictionary <NSString *, id<JSONEncodable>>*)arguments {
  self = [super init];
  if (self) {
    self.responseName = responseName;
    self.fieldName = fieldName ?: responseName;
    self.arguments = arguments;
    NSDictionary <NSString *, id>*aArguments = self.arguments ? self.arguments.jsonObject : nil;
    if (aArguments && aArguments.allKeys.count > 0) {
      NSString *argumentsKey = [self orderIndependentKeyForObject:aArguments];
      self.cacheKey = [NSString stringWithFormat:@"%@(%@)", self.fieldName, argumentsKey];
    } else {
      self.cacheKey = self.fieldName;
    }
  }
  return self;
}

- (NSString *)orderIndependentKeyForObject:(NSDictionary <NSString *, id>*)object {
  NSArray *sortedKeys = [object keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
    return [obj1 compare:obj2];
  }];
  NSMutableArray *tmpArray = [NSMutableArray array];
  for (NSString *key in sortedKeys) {
    id value = object[key];
    NSString *str = @"";
    if ([value isKindOfClass:[NSDictionary class]]) {
      str = [NSString stringWithFormat:@"%@:%@", key, [self orderIndependentKeyForObject:value]];
    } else {
      str = [NSString stringWithFormat:@"%@:%@", key, value];
    }
    [tmpArray addObject:str];
  }
  return [tmpArray componentsJoinedByString:@","];
}

@end
