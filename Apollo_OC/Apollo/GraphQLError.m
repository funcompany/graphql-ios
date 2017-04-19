//
//  GraphQLError.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/12/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "GraphQLError.h"

static NSString *const MessageKey = @"message";
static NSString *const LocationsKey = @"locations";

@implementation Location

- (instancetype)initWithObject:(NSDictionary <NSString *, id>*)object {
  self = [super init];
  if (self) {
    self.line = [(id)object[@"line"] integerValue];
    self.column = [(id)object[@"column"] integerValue];
  }
  return self;
}

@end


@interface GraphQLError ()
@property (nonatomic, strong) NSDictionary <NSString *, id> *object;
@end

@implementation GraphQLError

- (instancetype)initWithObject:(NSDictionary <NSString *, id> *)object {
  self = [super init];
  if (self) {
    self.object = object;
  }
  return self;
}

- (instancetype)initWithMessage:(NSString *)message {
  return [self initWithObject:@{MessageKey : message}];
}

- (id)infoForKey:(NSString *)key{
  return self.object[key];
}

- (NSString *)message {
  return (NSString *)self.object[MessageKey];
}

- (NSArray <Location *> *)locations {
  NSMutableArray *tmpArray = [NSMutableArray array];
  for (NSDictionary <NSString *, id>*obj in (NSDictionary *)self.object[LocationsKey]) {
    [tmpArray addObject:[[Location alloc] initWithObject:obj]];
  }
  return tmpArray;
}

- (NSString *)description {
  return self.message;
}

- (NSString *)errorDescription {
  return [self description];
}

@end
