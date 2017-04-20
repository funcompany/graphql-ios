//
//  HTTPNetworkTransport.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/14/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "HTTPNetworkTransport.h"
#import "NSHTTPURLResponse+Utilities.h"

@implementation HTTPNetworkTransport

- (instancetype)initWithUrl:(NSURL *)url configuration:(NSURLSessionConfiguration *)configuration {
  self = [super init];
  if (self) {
    self.url = url;
    if (configuration) {
      self.session = [NSURLSession sessionWithConfiguration:configuration];
    } else {
      self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    self.serializationFormat = [[JSONSerializationFormat alloc] init];
  }
  return self;
}

- (id<Cancellable>)send:(GraphQLOperation *)operation completionHandler:(void(^)(GraphQLResponse *response, NSError *error))completionHandler {
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
  request.HTTPMethod = @"POST";
  [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  NSDictionary <NSString *, id<JSONEncodable>>*body = @{@"query" : operation.queryDocument,
                                     @"variables" : operation.variables
                                     };
  request.HTTPBody = [self.serializationFormat serialize:(id<JSONEncodable>)body];
  NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (error) {
      completionHandler(nil, error);
      return;
    }
    if (![response isKindOfClass:[NSHTTPURLResponse class]]) {
      NSAssert(NO, @"Response should be an HTTPURLResponse");
      return;
    }
    if (![(NSHTTPURLResponse *)response isSuccessful] && !data) {
      completionHandler (nil, error);
      return;
    }
    if (!data) {
      completionHandler (nil, error);
      return;
    }
    NSDictionary <NSString *, id>*responseObject = [self.serializationFormat deserialize:data];
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
      NSAssert(NO, @"invalidResponse");
      return;
    }
    GraphQLResponse *graphQLResponse = [[GraphQLResponse alloc] initWithOperation:operation body:responseObject];
    completionHandler(graphQLResponse, error);
  }];
  
  [task resume];
  
  return (id<Cancellable>)task;
}

@end
