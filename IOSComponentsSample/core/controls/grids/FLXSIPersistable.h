#import "FLXSPreferenceInfo.h"
#import "FLXSVersion.h"

@class FLXSGridPreferencesInfo;

/**
	 * An object that can persist it's state into a serializable string and can
	 * load itself back from that serializable string.
	 */
@protocol FLXSIPersistable

@property (nonatomic, strong) NSString* preferencesToPersist;
@property (nonatomic, assign) BOOL enablePreferencePersistence;
@property (nonatomic, strong) NSString* preferencePersistenceMode;
@property (nonatomic, strong) NSString* preferencePersistenceKey;
@property (nonatomic, strong) NSString* preferences;

@property (nonatomic, assign) BOOL preferencesSet;
@property (nonatomic, assign) BOOL userPersistedColumnWidths;
@property (nonatomic, assign) BOOL useCompactPreferences;
@property (nonatomic, assign) BOOL preferencesLoaded;
@property (nonatomic, strong) NSString* userSettingsOptionsFunction;
@property (nonatomic, assign) BOOL enableMultiplePreferences;
@property (nonatomic, strong) FLXSGridPreferencesInfo* gridPreferencesInfo;
@property (nonatomic, strong) FLXSPreferenceInfo* currentPreference;
/**
 * By default, when the grid's creation complete event is dispatched, the grid will go
 * in and load the saved preference. This works well in most cases, but in some cases, where
 * the data needed to build selection comboboxes (for filters) is built from the dataprovider,
 * it makes sense to wait until the dataprovider is loaded to parse and set the preferences, otherwise
 * the grid will end up ignoring saved preferences for filters that have dropdown based UI. In this case
 * set autoLoadPreferences to true, and manually call loadPreferences when the data is received from
 * the server and the dataprovider is set.<br/>
 *
 * grid:FlexDataGrid autoLoadPreferences=”false” <br/>
 * And then, when you set the dataprovider: <br/>
 * dgReport.dataProviderFLXS=dp;<br/>
 * if(!dgReport.preferencesLoaded){<br/>
 * 		dgReport.loadPreferences();<br/>
 * }<br/>
 */
@property (nonatomic, assign) BOOL autoLoadPreferences;
@end

