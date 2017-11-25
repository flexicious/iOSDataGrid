@class FLXSSystemUser;

@interface FLXSBaseEntity : NSObject 
{
}

@property (nonatomic, assign) FLXSSystemUser* addedBy;
@property (nonatomic, strong) NSDate* addedDate;
@property (nonatomic, weak) FLXSSystemUser* updatedBy;
@property (nonatomic, strong) NSDate* updatedDate;
@property (nonatomic, assign) float id;

@property (nonatomic, strong) NSDate* generatedDate;


-(FLXSBaseEntity *)clone:(BOOL)deepClone;
-(FLXSBaseEntity *)createNew;

@end

