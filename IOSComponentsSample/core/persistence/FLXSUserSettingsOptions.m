#import "FLXSUserSettingsOptions.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSUserSettingsController.h"
#import "FLXSSavePreferenceViewController.h"


@implementation FLXSUserSettingsOptions

@synthesize silentFailure;
@synthesize allowClearOnCorruption;
@synthesize showErrorMessageWhenCorrupt;
@synthesize useCompactPreferences;
@synthesize prefDelimiter;
@synthesize prefColDelimiter;
@synthesize prefColPrefDelimiter;
@synthesize prefCustomDataDelimiter;
@synthesize multiPrefDelimiter;
@synthesize multiPrefGridPrefPropDelimiter;
@synthesize multiPrefPrefPropDelimiter;
@synthesize persistable;
@synthesize saveSettingsPopupRenderer;
@synthesize openSettingsPopupRenderer;
@synthesize settingsPopupRenderer;
@synthesize userWidthsOverrideFitToContent;
@synthesize persistLockModes;

-(id)init
{
	self = [super init];
	if (self)
	{
		silentFailure = NO;
		allowClearOnCorruption = YES;//#import "FLXSClassFactory.h"
		showErrorMessageWhenCorrupt = @"Error occurred while applying preferences: __ERRORMESSAGE__. Do you wish to clear preferences?";
		useCompactPreferences = YES;
		prefDelimiter = @"~|";
		prefColDelimiter = @"@|";
		prefColPrefDelimiter = @"&|";
		prefCustomDataDelimiter = @"#|";
		multiPrefDelimiter = @"$|";
		multiPrefGridPrefPropDelimiter = @"*|";
		multiPrefPrefPropDelimiter = @"%|";
 		saveSettingsPopupRenderer = [[FLXSClassFactory alloc] initWithNibName:@"FLXSSavePreferenceViewController"
                                                           andControllerClass:[FLXSSavePreferenceViewController class]
                                                               withProperties:nil];
		//openSettingsPopupRenderer = [[FLXSClassFactory alloc] init:OpenSettingsPopup];
		settingsPopupRenderer = [[FLXSClassFactory alloc] initWithNibName:@"FLXSUserSettingsController"
                                                       andControllerClass:[FLXSUserSettingsController class]
                                                           withProperties:nil];
		userWidthsOverrideFitToContent = NO;
		persistLockModes = NO;

	}
	return self;
}


+(FLXSUserSettingsOptions*)create:(UIView<FLXSIPersistable>*)grid
{
    FLXSUserSettingsOptions* options = [[FLXSUserSettingsOptions alloc] init];
	options.persistable=grid;
	options.useCompactPreferences = YES;
	//utimate
	return options;
}

-(FLXSFlexDataGrid*)grid
{
    return (FLXSFlexDataGrid*)self.persistable;
}

@end

