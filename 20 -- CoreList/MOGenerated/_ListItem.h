// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ListItem.h instead.

#import <CoreData/CoreData.h>

extern const struct ListItemAttributes {
	__unsafe_unretained NSString *name;
} ListItemAttributes;

@interface ListItemID : NSManagedObjectID {}
@end

@interface _ListItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ListItemID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@end

@interface _ListItem (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end
