// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.m instead.

#import "_Venue.h"

const struct VenueAttributes VenueAttributes = {
	.myVenueRating = @"myVenueRating",
	.venueCity = @"venueCity",
	.venueLat = @"venueLat",
	.venueLng = @"venueLng",
	.venueName = @"venueName",
	.venueState = @"venueState",
	.venueStreet = @"venueStreet",
	.venueZipCode = @"venueZipCode",
};

@implementation VenueID
@end

@implementation _Venue

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Venue";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:moc_];
}

- (VenueID*)objectID {
	return (VenueID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"myVenueRatingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"myVenueRating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"venueLatValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"venueLat"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"venueLngValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"venueLng"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic myVenueRating;

- (int16_t)myVenueRatingValue {
	NSNumber *result = [self myVenueRating];
	return [result shortValue];
}

- (void)setMyVenueRatingValue:(int16_t)value_ {
	[self setMyVenueRating:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveMyVenueRatingValue {
	NSNumber *result = [self primitiveMyVenueRating];
	return [result shortValue];
}

- (void)setPrimitiveMyVenueRatingValue:(int16_t)value_ {
	[self setPrimitiveMyVenueRating:[NSNumber numberWithShort:value_]];
}

@dynamic venueCity;

@dynamic venueLat;

- (double)venueLatValue {
	NSNumber *result = [self venueLat];
	return [result doubleValue];
}

- (void)setVenueLatValue:(double)value_ {
	[self setVenueLat:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveVenueLatValue {
	NSNumber *result = [self primitiveVenueLat];
	return [result doubleValue];
}

- (void)setPrimitiveVenueLatValue:(double)value_ {
	[self setPrimitiveVenueLat:[NSNumber numberWithDouble:value_]];
}

@dynamic venueLng;

- (double)venueLngValue {
	NSNumber *result = [self venueLng];
	return [result doubleValue];
}

- (void)setVenueLngValue:(double)value_ {
	[self setVenueLng:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveVenueLngValue {
	NSNumber *result = [self primitiveVenueLng];
	return [result doubleValue];
}

- (void)setPrimitiveVenueLngValue:(double)value_ {
	[self setPrimitiveVenueLng:[NSNumber numberWithDouble:value_]];
}

@dynamic venueName;

@dynamic venueState;

@dynamic venueStreet;

@dynamic venueZipCode;

@end

