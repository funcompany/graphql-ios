//
//  GQJSON.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/7/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JSONDecodingError) {
  JSONDecodingErrorMissingValue,
  JSONDecodingErrorNullValue,
  JSONDecodingErrorWrongType,
  JSONDecodingErrorCounldNotConvert
};

#pragma mark - JSONDecodable

@protocol JSONDecodable <NSObject>

- (instancetype)init:(JSONValue)value;

@end

@interface JSONDecodable : NSObject

- (instancetype)init:(JSONValue)value;

@end

#pragma mark - JSONEncodable

@protocol JSONEncodable <NSObject>

@property (nonatomic, strong) JSONValue jsonValue;

@end

@interface JSONEncodable : NSObject <JSONEncodable>

@property (nonatomic, strong) JSONValue jsonValue;

@end

#pragma mark - JSON

@interface JSON : NSObject

- (JSONValue)optional:(JSONValue)optionalValue;
- (JSONValue)required:(JSONValue)optionalValue;
- (JSONValue)cast:(JSONValue)value toKind:(Class)clazz;
- (BOOL)equals:(id)lhs rhs:(id)rhs;

@end
