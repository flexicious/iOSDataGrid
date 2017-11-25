#import "FLXSEvent.h"
#import "FLXSVersion.h"
/**
   * Dispatched when the grids' preferencePersistenceMode='server' and:
   * 1) The Grid needs to retrieve the preference data from the server
   * 2) The Grid needs to persist the  preference data to the server
   * 3) The Grid needs to clear out its preference data.
   *
   */
@interface FLXSPreferencePersistenceEvent : FLXSEvent
{

}
/**
*A key that uniquely identifies the grid whose preference data
* needs to be persisted on the server
*/
@property (nonatomic, strong) NSString* preferenceKey;
/**
		 *An xml string that contains all the preference data for this grid.
		 */
@property (nonatomic, strong) NSString* preferenceXml;
/**
		 * If you want to save any custom data into the preferences string, populate this property in the
		 * savePreferences event. (This event will be dispatched JUST before saving the preferences. And it
		 * will be available to you in the loadPreferences event. (This event is called right after the preferences
		 * are applied to the IPersistable)
		 */
@property (nonatomic, strong) NSString* customData;
/**
		 * Name of the preference to persist. Added in 2.9 to support multiple preferences
		 */
@property (nonatomic, strong) NSString* preferenceName;
/**
		 * Whether the preference to add is the default. Added in 2.9 to support multiple preferences
		 */
@property (nonatomic, assign) BOOL isDefault;

- (id)initWithType:(NSString *)type andPreferenceKey:(NSString *)preferenceKey andPreferenceXML:(NSString *)preferenceXml andBubbles:(BOOL)bubbles andCancelable:(BOOL)cancelable;
/**
* Fired In preferencePersistenceMode=server , when the grid needs to load its preferences.
* Fired In preferencePersistenceMode=client , when the grid has successfully loaded preferences.
* Event Type:com.flexicious.grids.events.PreferencePersistenceEvent
*/
+ (NSString*)PREFERENCES_LOADING;
/**
 * Fired right before preferences are being loaded and applied.
 * Event Type:com.flexicious.grids.events.PreferencePersistenceEvent
 */
+ (NSString*)LOAD_PREFERENCES;
/**
    * Fired when the grid needs to persist its preferences.
    * Event Type:com.flexicious.grids.events.PreferencePersistenceEvent
    */
+ (NSString*)PERSIST_PREFERENCES;
/**
     * Fired when the grid needs to clear its preferences.
     * Event Type:com.flexicious.grids.events.PreferencePersistenceEvent
     */
+ (NSString*)CLEAR_PREFERENCES;
@end

