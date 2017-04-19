//
//  HTTPNetworkTransport.h
//  Apollo_OC
//
//  Created by Travel Chu on 4/14/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "NetworkTransport.h"
#import "JSONSerializationFormat.h"

@interface HTTPNetworkTransport : NetworkTransport <NetworkTransport>

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) JSONSerializationFormat *serializationFormat;


/// Creates a network transport with the specified server URL and session configuration.
///
/// - Parameters:
///   - url: The URL of a GraphQL server to connect to.
///   - configuration: A session configuration used to configure the session. Defaults to `URLSessionConfiguration.default`.
- (instancetype)initWithUrl:(NSURL *)url configuration:(NSURLSessionConfiguration *)configuration;

/// Send a GraphQL operation to a server and return a response.
///
/// - Parameters:
///   - operation: The operation to send.
///   - completionHandler: A closure to call when a request completes.
///   - response: The response received from the server, or `nil` if an error occurred.
///   - error: An error that indicates why a request failed, or `nil` if the request was succesful.
/// - Returns: An object that can be used to cancel an in progress request.
- (id<Cancellable>)send:(GraphQLOperation *)operation completionHandler:(void(^)(GraphQLResponse *response, NSError *error))completionHandlerl;

@end
