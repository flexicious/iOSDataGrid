#import "FLXSVersion.h"
@class FLXSClassFactory;
@protocol FLXSIExtendedDataGrid;
@protocol FLXSIPersistable;
@class FLXSFlexDataGrid;

@interface FLXSUserSettingsOptions : NSObject
{

}

@property (nonatomic, assign) BOOL silentFailure;
@property (nonatomic, assign) BOOL allowClearOnCorruption;
@property (nonatomic, strong) NSString* showErrorMessageWhenCorrupt;
@property (nonatomic, assign) BOOL useCompactPreferences;
@property (nonatomic, strong) NSString* prefDelimiter;
@property (nonatomic, strong) NSString* prefColDelimiter;
@property (nonatomic, strong) NSString* prefColPrefDelimiter;
@property (nonatomic, strong) NSString* prefCustomDataDelimiter;
@property (nonatomic, strong) NSString* multiPrefDelimiter;
@property (nonatomic, strong) NSString* multiPrefGridPrefPropDelimiter;
@property (nonatomic, strong) NSString* multiPrefPrefPropDelimiter;
@property (nonatomic, strong) UIView<FLXSIPersistable>* persistable;
@property (nonatomic, strong) FLXSClassFactory* saveSettingsPopupRenderer;
@property (nonatomic, strong) FLXSClassFactory* openSettingsPopupRenderer;
@property (nonatomic, strong) FLXSClassFactory* settingsPopupRenderer;
@property (nonatomic, assign) BOOL userWidthsOverrideFitToContent;
@property (nonatomic, assign) BOOL persistLockModes;


+(FLXSUserSettingsOptions*)create:(UIView<FLXSIPersistable>*)grid;
-(FLXSFlexDataGrid*)grid;

@end

