#import "FLXSVersion.h"
@class FLXSUserSettingsOptions;

@interface FLXSUserSettingsController : NSObject
{
}


+(FLXSUserSettingsController*)instance;

-(void)clearPreferences:(FLXSUserSettingsOptions*)userSettingsOptions;
-(void)loadPreferences:(FLXSUserSettingsOptions*)userSettingsOptions;

- (void)persistPreferences:(FLXSUserSettingsOptions *)userSettingsOptions name:(NSString *)name isDefault:(BOOL)isDefault;
-(NSString*)getPreferencesString:(FLXSUserSettingsOptions*)userSettingsOptions;

- (NSMutableArray *)parsePreferences:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSString *)val;

- (NSMutableArray *)parseCompactPreferencesString:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSString *)val;
-(NSString*)getCompactPreferencesString:(FLXSUserSettingsOptions*)userSettingsOptions;
 -(NSMutableArray*)getColumnOrder:(FLXSUserSettingsOptions*)userSettingsOptions;

- (NSMutableArray *)getPropertyValues:(FLXSUserSettingsOptions *)userSettingsOptions property:(NSString *)property;
-(NSMutableArray*)getColumnVisibility:(FLXSUserSettingsOptions*)userSettingsOptions;
-(NSMutableArray*)getColumnWidths:(FLXSUserSettingsOptions*)userSettingsOptions;

- (void)applyPreferences:(FLXSUserSettingsOptions *)userSettingsOptions nsMutableArray:(NSMutableArray *)nsMutableArray;

- (void)setColumnOrder:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSMutableArray *)val;

- (void)rearrangeColumns:(NSObject *)col value:(NSMutableArray *)val userSettingsOptions:(FLXSUserSettingsOptions *)userSettingsOptions;
-(BOOL)getIsColumnOnly:(NSObject*)col;
-(NSMutableArray*)removeUndefined:(NSMutableArray*)source;
-(NSObject*)getFirstColumn:(NSObject*)col;

- (void)setPropertyValues:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSMutableArray *)val property:(NSString *)property;

- (void)setColumnVisibility:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSMutableArray *)val;

- (void)setColumnWidths:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSMutableArray *)val;

@end

