This is an objective-c port of the origins [apollo-ios](https://github.com/apollographql/apollo-ios) library.

Using with cocoapods
`pod 'graphql-ios', :git => 'git@github.com:funcompany/graphql-ios.git', :tag => '0.0.9'`

We haven't implement a codegen for api yet, and to get the response data, use `dataEntry` property of `GraphQLResultReader`, and convert to model with your faourite lib.
