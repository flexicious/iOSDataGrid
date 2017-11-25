#import "FLXSPreferencePersistenceEvent.h"

static NSString * PREFERENCES_LOADING = @"preferencesLoading";
static NSString * LOAD_PREFERENCES = @"loadPreferences";
static NSString * PERSIST_PREFERENCES = @"persistPreferences";
static NSString * CLEAR_PREFERENCES = @"clearPreferences";

@implementation FLXSPreferencePersistenceEvent

@synthesize preferenceKey;
@synthesize preferenceXml;
@synthesize customData;
@synthesize preferenceName;
@synthesize isDefault;

- (id)initWithType:(NSString *)type andPreferenceKey:(NSString *)preferenceKeyIn andPreferenceXML:(NSString *)preferenceXmlIn andBubbles:(BOOL)bubblesIn andCancelable:(BOOL)cancelableIn {
	self = [super initWithType:type
                 andCancelable:cancelableIn
                    andBubbles:bubblesIn];
	if (self)
	{
		self.preferenceKey=preferenceKeyIn;
		self.preferenceXml=preferenceXmlIn;
	}
	return self;
}


+ (NSString *)PREFERENCES_LOADING
{
	return PREFERENCES_LOADING;
}

+ (NSString *)LOAD_PREFERENCES
{
	return LOAD_PREFERENCES;
}


+ (NSString *)PERSIST_PREFERENCES
{
	return PERSIST_PREFERENCES;
}


+ (NSString *)CLEAR_PREFERENCES
{
	return CLEAR_PREFERENCES;
}
@end

