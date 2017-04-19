//
//  GraphQLResultReader.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/18/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "GraphQLResultReader.h"

@implementation GraphQLResolveInfo

- (instancetype)init {
  self = [super init];
  if (self) {
    self.path = [NSMutableArray array];
  }
  return self;
}

@end

@implementation GraphQLResultReader

- (NSDictionary <NSString *, id> *)currentObject {
  return self.objectStack.lastObject;
}

- (instancetype)initWithVariables:(NSDictionary <NSString *, id<JSONEncodable>> *)variables resolver:(GraphQLResolver)resolver {
  self = [super init];
  if (self) {
    self.variables = variables ?: [NSMutableDictionary dictionary];
    self.resolver = resolver;
    self.resolveInfo = [[GraphQLResolveInfo alloc] init];
    self.objectStack = [NSMutableArray array];
  }
  return self;
}

- (instancetype)initWithRootObject:(NSDictionary <NSString *, id> *)rootObject {
  self = [self initWithVariables:nil resolver:^id(Field *field, NSDictionary<NSString *,id> *object, GraphQLResolveInfo *info) {
    NSDictionary *goodObj = object ?: rootObject;
    if (goodObj) {
      return goodObj[field.responseName];
    }
    return nil;
  }];
  return self;
}

#pragma mark - Helpers

- (id)resolve:(Field *)field parse:(SEL)parse {
  if (!parse) {
    NSAssert(NO, nil);
  }
  [self.resolveInfo.path addObject:field.responseName];
  if (self.delegate) {
    [self.delegate willResolve:field info:self.resolveInfo];
  }
  @try {
    id value = self.resolver(field, self.currentObject, self.resolveInfo);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    id parsedValue = [self performSelector:parse withObject:value];
#pragma clang diagnostic pop
    [self notifyIfNil:parsedValue];
    
    [self.resolveInfo.path removeLastObject];
    if (self.delegate) {
      [self.delegate didResolve:field info:self.resolveInfo];
    }
    
    return parsedValue;
  } @catch (NSException *exception) {
    @throw exception;
  }
}

- (NSArray *)map:(NSArray *)array parse:(SEL)parse {
  if (self.delegate) {
    [self.delegate willParseElements:array];
  }
  
  NSMutableArray *mappedList = [NSMutableArray arrayWithCapacity:array.count];
  
  [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [self.resolveInfo.path addObject:[@(idx) stringValue]];
    if (self.delegate) {
      [self.delegate willParseElementAtIndex:idx];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    id parsedValue = [self performSelector:parse withObject:obj];
#pragma clang diagnostic pop
    [self notifyIfNil:parsedValue];
    [mappedList addObject:parsedValue];
    if (self.delegate) {
      [self.delegate didParseElementAtIndex:idx];
    }
    [self.resolveInfo.path removeLastObject];
  }];
  
  if (self.delegate) {
    [self.delegate didParseElements:array];
  }
  
  return mappedList;
}

- (void)notifyIfNil:(id)value {
  if (value && self.delegate) {
    [self.delegate didParseNull];
  }
}

- (id)valueForField:(Field *)field {
  return [self resolve:field parse:@selector(parse:)];
}

- (id)listForField:(Field *)field {
  return [self resolve:field parse:@selector(parse:)];
}

- (id)parse:(id)value {
  return value;
}

@end
