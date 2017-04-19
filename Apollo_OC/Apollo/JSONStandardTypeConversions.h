//
//  JSONStandardTypeConversions.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/19/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

@interface NSString (JSON)<JSONEncodable, JSONDecodable>
@property (nonatomic, strong) id jsonValue;
- (instancetype)init:(id)value;
@end
