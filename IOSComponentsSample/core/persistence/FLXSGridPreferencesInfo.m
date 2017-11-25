#import "FLXSGridPreferencesInfo.h"
#import "FLXSUserSettingsOptions.h"
#import "FLXSPreferenceInfo.h"
#import "FLXSUIUtils.h"

@implementation FLXSGridPreferencesInfo

@synthesize loadDefaultPreferenceOnCreationComplete;
@synthesize defaultPreferenceName;
@synthesize savedPreferences;
 

-(NSString*)toPreferenceString:(FLXSUserSettingsOptions*)uso{

    NSString * str =@"";
    str = [[str stringByAppendingString:(loadDefaultPreferenceOnCreationComplete?@"y":@"n")] stringByAppendingString:uso.multiPrefGridPrefPropDelimiter];
    str = [[str stringByAppendingString:defaultPreferenceName] stringByAppendingString:uso.multiPrefGridPrefPropDelimiter];

    for (FLXSPreferenceInfo* pref in savedPreferences){
        str = [[str stringByAppendingString:pref.name] stringByAppendingString:uso.multiPrefPrefPropDelimiter];
        str = [[str stringByAppendingString:pref.preferences] stringByAppendingString:uso.multiPrefPrefPropDelimiter];
        str = [str stringByAppendingString:uso.multiPrefDelimiter];
}
return str;
}

- (FLXSGridPreferencesInfo *)fromPreferenceString:(FLXSUserSettingsOptions *)uso string:(NSString *)str {
    FLXSGridPreferencesInfo* gpi = self;
    NSArray *thisProps= [str componentsSeparatedByString:uso.multiPrefGridPrefPropDelimiter];
    if(thisProps && [thisProps count]==1){
        //this means we are multi pref grid, but we have a single pref stored.
        gpi.loadDefaultPreferenceOnCreationComplete=true;
        FLXSPreferenceInfo *po1 = [FLXSPreferenceInfo new];
        po1.name=gpi.defaultPreferenceName;
        po1.preferences=[thisProps objectAtIndex:0];
        [gpi.savedPreferences insertObject:po1 atIndex:0];
        return gpi;
    }
    gpi.loadDefaultPreferenceOnCreationComplete = [[thisProps objectAtIndex:0] isEqual:@"y"];
    gpi.defaultPreferenceName = [thisProps objectAtIndex:1];
    NSArray *prefArr = [thisProps[2] componentsSeparatedByString:uso.multiPrefDelimiter];
    for (NSString* str in prefArr){
        if([FLXSUIUtils nullOrEmpty: str])continue;
        FLXSPreferenceInfo *po = [FLXSPreferenceInfo new];
        NSArray* prefPropArr = [str componentsSeparatedByString:uso.multiPrefPrefPropDelimiter];
        po.name = [prefPropArr objectAtIndex:0];
        po.preferences = [prefPropArr objectAtIndex:1];
        [gpi.savedPreferences insertObject:po atIndex:0];
    }
    return gpi;
}

@end

