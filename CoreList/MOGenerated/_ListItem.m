// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ListItem.m instead.

#import "_ListItem.h"

const struct ListItemAttributes ListItemAttributes = {
	.name = @"name",
};

@implementation ListItemID
@end

@implementation _ListItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ListItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ListItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ListItem" inManagedObjectContext:moc_];
}

- (ListItemID*)objectID {
	return (ListItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@end

