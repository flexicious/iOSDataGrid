#import "FLXSExportOptions.h"
#import "FLXSEvent.h"
#import "FLXSVersion.h"

@interface FLXSExportEvent : FLXSEvent
{

}

@property (nonatomic, weak) FLXSExportOptions* exportOptions;
@property (nonatomic, strong) NSString* textWritten;


+ (NSString*)BEFORE_EXPORT;
+ (NSString*)AFTER_EXPORT;
@end

