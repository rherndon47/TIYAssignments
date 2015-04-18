// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.h instead.

#import <CoreData/CoreData.h>

extern const struct VenueAttributes {
	__unsafe_unretained NSString *myVenueRating;
	__unsafe_unretained NSString *venueCity;
	__unsafe_unretained NSString *venueLat;
	__unsafe_unretained NSString *venueLng;
	__unsafe_unretained NSString *venueName;
	__unsafe_unretained NSString *venueState;
	__unsafe_unretained NSString *venueStreet;
	__unsafe_unretained NSString *venueZipCode;
} VenueAttributes;

@interface VenueID : NSManagedObjectID {}
@end

@interface _Venue : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) VenueID* objectID;

@property (nonatomic, strong) NSNumber* myVenueRating;

@property (atomic) int16_t myVenueRatingValue;
- (int16_t)myVenueRatingValue;
- (void)setMyVenueRatingValue:(int16_t)value_;

//- (BOOL)validateMyVenueRating:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* venueCity;

//- (BOOL)validateVenueCity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* venueLat;

@property (atomic) double venueLatValue;
- (double)venueLatValue;
- (void)setVenueLatValue:(double)value_;

//- (BOOL)validateVenueLat:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* venueLng;

@property (atomic) double venueLngValue;
- (double)venueLngValue;
- (void)setVenueLngValue:(double)value_;

//- (BOOL)validateVenueLng:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* venueName;

//- (BOOL)validateVenueName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* venueState;

//- (BOOL)validateVenueState:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* venueStreet;

//- (BOOL)validateVenueStreet:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* venueZipCode;

//- (BOOL)validateVenueZipCode:(id*)value_ error:(NSError**)error_;

@end

@interface _Venue (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveMyVenueRating;
- (void)setPrimitiveMyVenueRating:(NSNumber*)value;

- (int16_t)primitiveMyVenueRatingValue;
- (void)setPrimitiveMyVenueRatingValue:(int16_t)value_;

- (NSString*)primitiveVenueCity;
- (void)setPrimitiveVenueCity:(NSString*)value;

- (NSNumber*)primitiveVenueLat;
- (void)setPrimitiveVenueLat:(NSNumber*)value;

- (double)primitiveVenueLatValue;
- (void)setPrimitiveVenueLatValue:(double)value_;

- (NSNumber*)primitiveVenueLng;
- (void)setPrimitiveVenueLng:(NSNumber*)value;

- (double)primitiveVenueLngValue;
- (void)setPrimitiveVenueLngValue:(double)value_;

- (NSString*)primitiveVenueName;
- (void)setPrimitiveVenueName:(NSString*)value;

- (NSString*)primitiveVenueState;
- (void)setPrimitiveVenueState:(NSString*)value;

- (NSString*)primitiveVenueStreet;
- (void)setPrimitiveVenueStreet:(NSString*)value;

- (NSString*)primitiveVenueZipCode;
- (void)setPrimitiveVenueZipCode:(NSString*)value;

@end
