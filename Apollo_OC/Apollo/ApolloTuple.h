//
//  ApolloTuple.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/17/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApolloTuple : NSObject

@property (nonatomic, strong) id first;
@property (nonatomic, strong) id second;
@property (nonatomic, strong) id third;
@property (nonatomic, strong) id fouth;

+ (instancetype)withFirst:(id)first second:(id)second;
+ (instancetype)withFirst:(id)first second:(id)second third:(id)third;
+ (instancetype)withFirst:(id)first second:(id)second third:(id)third fouth:(id)fouth;

@end
