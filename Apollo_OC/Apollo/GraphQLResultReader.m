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

- (NSDictionary <JSONObject> *)currentObject {
  return self.objectStack.lastObject;
}

- (instancetype)initWithVariables:(NSDictionary <GraphQLMap> *)variables resolver:(GraphQLResolver)resolver {
  self = [super init];
  if (self) {
    self.variables = variables ?: [NSMutableDictionary dictionary];
    self.resolver = resolver;
    self.resolveInfo = [[GraphQLResolveInfo alloc] init];
    self.objectStack = [NSMutableArray array];
  }
  return self;
}

- (instancetype)initWithRootObject:(NSDictionary <JSONObject> *)rootObject {
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
    
    id parsedValue = [self performSelector:parse withObject:value];
    
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
    id parsedValue = [self performSelector:parse withObject:obj];
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

#pragma mark -

//- (id)valueForField:(Field *)field {
//  return [self resolve:field parse:<#(SEL)#>]
//  return try resolve(field: field) { try parse(value: $0) }
//}
//
//public func optionalValue<T: JSONDecodable>(for field: Field) throws -> T? {
//  return try resolve(field: field) { try parse(value: $0) }
//}
//
//public func value<T: GraphQLMappable>(for field: Field) throws -> T {
//  return try resolve(field: field) { try parse(object: $0) }
//}
//
//public func optionalValue<T: GraphQLMappable>(for field: Field) throws -> T? {
//  return try resolve(field: field) { try parse(object: $0) }
//}
//
//- (id)listForField:(Field *)field {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func list<T: JSONDecodable>(for field: Field) throws -> [T?] {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func list<T: JSONDecodable>(for field: Field) throws -> [[T]] {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func list<T: JSONDecodable>(for field: Field) throws -> [[T?]] {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func optionalList<T: JSONDecodable>(for field: Field) throws -> [T]? {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func optionalList<T: JSONDecodable>(for field: Field) throws -> [T?]? {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func optionalList<T: JSONDecodable>(for field: Field) throws -> [[T]]? {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func optionalList<T: JSONDecodable>(for field: Field) throws -> [[T?]]? {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func list<T: GraphQLMappable>(for field: Field) throws -> [T] {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func list<T: GraphQLMappable>(for field: Field) throws -> [T?] {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func list<T: GraphQLMappable>(for field: Field) throws -> [[T]] {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func list<T: GraphQLMappable>(for field: Field) throws -> [[T?]] {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func optionalList<T: GraphQLMappable>(for field: Field) throws -> [T]? {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func optionalList<T: GraphQLMappable>(for field: Field) throws -> [T?]? {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func optionalList<T: GraphQLMappable>(for field: Field) throws -> [[T]]? {
//  return try resolve(field: field) { try parse(array: $0) }
//}
//
//public func optionalList<T: GraphQLMappable>(for field: Field) throws -> [[T?]]? {
//  return try resolve(field: field) { try parse(array: $0) }
//}

#pragma mark - Parsing scalar values
//Let's treat "_" as value optional
//Let's treat "__" as return type optional
//Let's treat "___" as return collection element type optional
//Let's treat "____" as return type/return collection element type both optional

//- (id)parseValue:(JSONValue)value intoType:(Class)type {
//  if (<#condition#>) {
//    <#statements#>
//  }
//}
//
//- (id)parseValue__:(JSONValue)value intoType:(Class)type {
//  return try optional(value).map { try parse(value: $0) }
//}
//
//- (id)parseValue:(JSONValue)value intoType:(Class)type {
//  let decodedValue = try T.init(jsonValue: value)
//  delegate?.didParse(value: value)
//  return decodedValue
//}
//
//#pragma mark - Parsing objects
//
//- (id)parseObject_:(JSONValue)object intoType:(Class)type {
//  return try parse(object: cast(required(object)), intoType: type)
//}
//
//- (id)parseObject__:(JSONValue)object intoType:(Class)type {
//  return try optional(object).map { try parse(object: cast($0), intoType: type) }
//}
//
//- (id)parseObject:(JSONValue)object intoType:(Class)type {
//  objectStack.append(object)
//  
//  delegate?.willParse(object: object)
//  let mappedObject = try T.init(reader: self)
//  delegate?.didParse(object: object)
//  
//  objectStack.removeLast()
//  
//  return mappedObject
//}
//
//#pragma mark - scalar arrays
//
//- (NSArray *)parseArray_:(JSONValue)array elementType:(Class)type {
//  return try parse(array: cast(required(array)), elementType: elementType)
//}
//
//- (NSArray *)parseArray___:(JSONValue)array elementType:(Class)type {
//  return try parse(array: cast(required(array)), elementType: elementType)
//}
//
//- (NSArray *)parseArray__:(JSONValue)array elementType:(Class)type {
//  return try optional(array).map {
//    try parse(array: cast($0), elementType: elementType)
//  }
//}
//
//- (NSArray *)parseArray____:(JSONValue)array elementType:(Class)type {
//  return try optional(array).map {
//    try parse(array: cast($0), elementType: elementType)
//  }
//}
//
//- (NSArray <NSArray *>*)parseArrayArray_:(JSONValue)array elementType:(Class)type {
//  return try parse(array: cast(required(array)), elementType: elementType)
//}
//
//- (NSArray <NSArray *>*)parseArrayArray___:(JSONValue)array elementType:(Class)type {
//  return try parse(array: cast(required(array)), elementType: elementType)
//}
//
//- (NSArray <NSArray *>*)parseArrayArray__:(JSONValue)array elementType:(Class)type {
//  return try optional(array).map {
//    return try parse(array: cast(required($0)), elementType: elementType)
//  }
//}
//
//- (NSArray <NSArray *>*)parseArrayArray____:(JSONValue)array elementType:(Class)type {
//  return try optional(array).map {
//    return try parse(array: cast(required($0)), elementType: elementType)
//  }
//}
//
//- (NSArray *)parseArray:(JSONValue)array elementType:(Class)type {
//  return try map(array: array) {
//    try parse(value: $0, intoType: elementType)
//  }
//}
//
//private func parse<T: JSONDecodable>(array: [JSONValue], elementType: T.Type = T.self) throws -> [T?] {
//  return try map(array: array) {
//    try optional($0).map {
//      try parse(value: $0, intoType: elementType)
//    }
//  }
//}
//
//- (NSArray <NSArray *>*)parseArrayArray:(JSONValue)array elementType:(Class)type {
//  return try map(array: array) {
//    try map(array: cast(required($0))) {
//      try parse(value: required($0), intoType: elementType)
//    }
//  }
//}
//
//private func parse<T: JSONDecodable>(array: [JSONValue], elementType: T.Type = T.self) throws -> [[T?]] {
//  return try map(array: array) {
//    try map(array: cast(required($0))) {
//      try parse(value: optional($0), intoType: elementType)
//    }
//  }
//}
//
//// MARK: Parsing object arrays
//
//private func parse<T: GraphQLMappable>(array: JSONValue?, elementType: T.Type = T.self) throws -> [T] {
//  return try parse(array: cast(required(array)), elementType: elementType)
//}
//
//private func parse<T: GraphQLMappable>(array: JSONValue?, elementType: T.Type = T.self) throws -> [T?] {
//  return try parse(array: cast(required(array)), elementType: elementType)
//}
//
//private func parse<T: GraphQLMappable>(array: JSONValue?, elementType: T.Type = T.self) throws -> [T]? {
//  return try optional(array).map { try parse(array: cast($0), elementType: elementType) }
//}
//
//private func parse<T: GraphQLMappable>(array: JSONValue?, elementType: T.Type = T.self) throws -> [T?]? {
//  return try optional(array).map { try parse(array: cast($0), elementType: elementType) }
//}
//
//private func parse<T: GraphQLMappable>(array: JSONValue?, elementType: T.Type = T.self) throws -> [[T]] {
//  return try parse(array: cast(required(array)), elementType: elementType)
//}
//
//private func parse<T: GraphQLMappable>(array: JSONValue?, elementType: T.Type = T.self) throws -> [[T?]] {
//  return try parse(array: cast(required(array)), elementType: elementType)
//}
//
//private func parse<T: GraphQLMappable>(array: JSONValue?, elementType: T.Type = T.self) throws -> [[T]]? {
//  return try optional(array).map {
//    return try parse(array: cast(required($0)), elementType: elementType)
//  }
//}
//
//private func parse<T: GraphQLMappable>(array: JSONValue?, elementType: T.Type = T.self) throws -> [[T?]]? {
//  return try optional(array).map {
//    return try parse(array: cast(required($0)), elementType: elementType)
//  }
//}
//
//private func parse<T: GraphQLMappable>(array: [JSONObject], elementType: T.Type) throws -> [T] {
//  return try map(array: array) { try parse(object: $0, intoType: elementType) }
//}
//
//private func parse<T: GraphQLMappable>(array: [JSONObject], elementType: T.Type) throws -> [T?] {
//  return try map(array: array) {
//    try optional($0).map {
//      try parse(object: $0, intoType: elementType)
//    }
//  }
//}
//
//private func parse<T: GraphQLMappable>(array: [JSONObject], elementType: T.Type = T.self) throws -> [[T]] {
//  return try map(array: array) {
//    try map(array: cast(required($0))) {
//      try parse(object: required($0), intoType: elementType)
//    }
//  }
//}
//
//private func parse<T: GraphQLMappable>(array: [JSONObject], elementType: T.Type = T.self) throws -> [[T?]] {
//  return try map(array: array) {
//    try map(array: cast(required($0))) {
//      try parse(object: optional($0), intoType: elementType)
//    }
//  }
//}





@end
