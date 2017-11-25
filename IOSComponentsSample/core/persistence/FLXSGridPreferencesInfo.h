@class FLXSUserSettingsOptions;
#import "FLXSVersion.h"

@interface FLXSGridPreferencesInfo : NSObject
{

}

@property (nonatomic, assign) BOOL loadDefaultPreferenceOnCreationComplete;
@property (nonatomic, strong) NSString* defaultPreferenceName;
@property (nonatomic, strong) NSMutableArray* savedPreferences;


-(NSString*)toPreferenceString:(FLXSUserSettingsOptions*)uso;

- (FLXSGridPreferencesInfo *)fromPreferenceString:(FLXSUserSettingsOptions *)uso string:(NSString *)str;

@end

