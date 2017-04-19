#import "GraphQLOperation.h"
#import "GraphQLTypes.h"

@interface StarshipQuery : GraphQLQuery
- (nonnull instancetype)initWith;
- (nonnull Class)responseDataClass;
@end

@interface StarshipDataStarship : NSObject<GraphQLMappable, YYModel>

@property (nonatomic, copy, nonnull, readonly) NSString *name;
@property (nonatomic, copy, nonnull, readonly) NSArray<NSArray<NSNumber *> *> *coordinates;

- (nonnull instancetype)initWithReader:(GraphQLResultReader *_Nullable)reader;
@end

@interface StarshipData : NSObject<GraphQLMappable, YYModel>

@property (nonatomic, strong, nullable, readonly) StarshipDataStarship *starship;

- (nonnull instancetype)initWithReader:(GraphQLResultReader *_Nullable)reader;
@end
