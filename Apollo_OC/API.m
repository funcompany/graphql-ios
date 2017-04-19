//  This file was automatically generated and should not be edited.
#import "API.h"

@implementation StarshipQuery
- (NSString *)operationDefinition {
  return [NSString stringWithFormat:
          @"query Starship {"
          "  starship(id: 3000) {"
          "    name"
          "    coordinates"
          "  }"
          "}"
          ];
}
- (nonnull Class)responseDataClass {
  return NSClassFromString(@"StarshipData");
}
- (nonnull instancetype)initWith; {
  if (self = [super init]) {
  }
  return self;
}
@end

@interface StarshipDataStarship ()<GraphQLMappable>
@end

@implementation StarshipDataStarship


- (nonnull instancetype)initWithReader:(GraphQLResultReader *_Nullable)reader {
  if (self = [super init]) { {
    _name = [reader valueForField:[[Field alloc] initWithResponseName:@"name" fieldName:nil arguments:nil]];
    _coordinates = [reader listForField:[[Field alloc] initWithResponseName:@"coordinates" fieldName:nil arguments:nil]];
  }
  }
  return self;
}
@end

@interface StarshipData ()<GraphQLMappable>
@end

@implementation StarshipData


- (nonnull instancetype)initWithReader:(GraphQLResultReader *_Nullable)reader {
  if (self = [super init]) {
    NSDictionary *data = [reader valueForField:[[Field alloc] initWithResponseName:@"starship" fieldName:nil arguments:nil]];
    NSLog(@"1111111%@",data);
  }
  return self;
}
@end
