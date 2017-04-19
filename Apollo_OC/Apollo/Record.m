//
//  Record.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/7/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "Record.h"

@implementation Record

- (instancetype)initWithKey:(NSString *)key fields:(NSMutableDictionary <NSString *, id> *)fields {
  self = [super init];
  if (self) {
    self.key = key;
    self.fields = fields ?: [NSMutableDictionary dictionary];
  }
  return self;
}

- (id)valueForKey:(NSString *)key {
  return self.fields[key];
}

- (void)setRecordValue:(id)value forKey:(NSString *)key{
  self.fields[key] = value;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"#%@ -> %@", self.key, self.fields];
}

@end

@implementation Reference

- (instancetype _Nonnull)initWithKey:(NSString * _Nonnull)key {
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
