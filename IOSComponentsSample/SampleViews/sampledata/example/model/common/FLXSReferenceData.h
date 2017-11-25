#import "FLXSBaseEntity.h"
#import "FLXSReferenceData.h"

@interface FLXSReferenceData : FLXSBaseEntity
{
}

@property (nonatomic, strong) NSString* code;
@property (nonatomic, strong) NSString* name;

- (id)initWithId:(float)id andCode:(NSString *)code andName:(NSString *)name;
-(FLXSReferenceData *)cloneSpecial;
-(FLXSBaseEntity *)createNew;

@end

