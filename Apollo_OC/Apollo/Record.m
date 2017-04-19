//
//  Record.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/7/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "Record.h"

@implementation Record

- (instancetype)initWithKey:(CacheKey *)key fields:(NSMutableDictionary <JSONObject> *)fields {
  self = [super init];
  if (self) {
    self.key = key;
    self.fields = fields ?: [NSMutableDictionary dictionary];
  }
  return self;
}

- (JSONValue)valueForKey:(CacheKey *)key {
  return self.fields[key];
}

- (void)setRecordValue:(JSONValue)value forKey:(CacheKey *)key{
  self.fields[key] = value;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"#%@ -> %@", self.key, self.fields];
}

@end

@implementation Reference

- (instancetype _Nonnull)initWithKey:(CacheKey * _Nonnull)key {
  self = [super init];
  if (self) {
    self.key = key;
  }
  return self;
}

- (BOOL)isEqual:(Reference *_Nonnull)object {
  return [object.key isEqualToString:self.key];
}

- (NSString * _Nonnull)description {
  return [NSString stringWithFormat:@"-> #%@", self.key];
}

@end
