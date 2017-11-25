#import "FLXSToolbarAction.h"
#import "FLXSEvent.h"
#import "FLXSUIUtils.h"

static const NSString* DEFAULT_ICON = @"../assets/images/customAction.png";

@implementation FLXSToolbarAction {
@private
    NSObject *_trigger;
    BOOL _enabled;
    BOOL _separatorBefore;
    BOOL _separatorAfter;
    NSString *_name;
    NSString *_code;
    NSString *_tooltip;
    NSObject *_iconUrl;
    NSObject *_disabledIconUrl;
    BOOL _requiresSelection;
    BOOL _requiresSingleSelection;
    int _level;
    NSArray *_subActions;
    BOOL _dropDownOnly;
    NSString* _isEnabledFunction;
    NSString* _executedFunction;
}

@synthesize trigger = _trigger;
@synthesize enabled = _enabled;
@synthesize separatorBefore = _separatorBefore;
@synthesize separatorAfter = _separatorAfter;
@synthesize name = _name;
@synthesize code = _code;
@synthesize tooltip = _tooltip;
@synthesize iconUrl = _iconUrl;
@synthesize disabledIconUrl = _disabledIconUrl;
@synthesize requiresSelection = _requiresSelection;
@synthesize requiresSingleSelection = _requiresSingleSelection;
@synthesize level = _level;
@synthesize subActions = _subActions;
@synthesize dropDownOnly = _dropDownOnly;
@synthesize isEnabledFunction = _isEnabledFunction;
@synthesize executedFunction = _executedFunction;

-(id)initWithName:(NSString *)name
         andLevel:(int)level
          andCode:(NSString *)code
       andToolTip:(NSString *)tooltip
           andIcon:(NSObject *)iconUrl
andSeparatorBefore:(BOOL)separatorBefore
 andSeparatorAfter:(BOOL)separatorAfter
       andSubActions:(NSArray *)subActions
      andRequiresSelection:(BOOL)requiresSelection
andRequiresSingleSelection:(BOOL)requiresSingleSelection
        andDisabledIconUrl:(NSObject *)disableIconUrl
        andEnabledFunction:(NSString *)isEnabledFunction
       andExecutedFunction:(NSString *)executedFunction
               andDelegate:(id)delegate
{

	self = [super init];
	if (self)
	{
		_enabled = YES;
		_separatorBefore = separatorBefore;
		_separatorAfter = separatorAfter;
		level = -1;
		_subActions = [[NSMutableArray alloc] init];
		_dropDownOnly = NO;
		_isEnabledFunction = isEnabledFunction;
		_executedFunction = executedFunction;

		self.name=name;
		if(!code)code=name  ;
			self.code=code;
		if(!tooltip)tooltip=name;
			self.tooltip=tooltip;
		//if(!iconUrl)iconUrl=DEFAULT_ICON;
		self.iconUrl=iconUrl;
		self.level=level;
		self.separatorBefore=separatorBefore;
		self.separatorAfter=separatorAfter;
		if(subActions)
		{
			self.subActions=subActions;
		}
		self.requiresSelection=requiresSelection;
		self.requiresSingleSelection=requiresSingleSelection;
		self.disabledIconUrl = disableIconUrl;
		self.isEnabledFunction=isEnabledFunction;
		self.executedFunction=executedFunction;
        self.delegate=delegate;
		[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"initialize")])];
	}
	return self;
}


-(void)setName:(NSString*)value
{
	_name = value;
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:@"init"])];
}

-(BOOL)isRegularAction
{
    return (![self.name isEqual:@"separator"]) && (self.subActions.count==0);

}

-(BOOL)isDropDownAction
{
    return (![self.name isEqual:@"separator"]) && (self.subActions.count>0);


}


//Start FLXSIEventDispatcher methods

- (void)addEventListener:(NSString *)type target:(NSObject *)target handler:(SEL)handler {
    [FLXSUIUtils addEventListenerOfType:type
                       withTarget:target
                       andHandler:handler
                        andSender:self];
}
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler {
    [FLXSUIUtils removeEventListener:type
                          withTarget:target
                          andHandler:handler
                           andSender:self];
}
-(void)dispatchEvent:(FLXSEvent*)event
{

    [FLXSUIUtils dispatchEvent:event
                    withSender:self];
}

//End FLXSIEventDispatcher methods


-(BOOL)isSeparator
{
    return ([self.name isEqualToString: @"separator"]);
}

-(NSArray*)children
{
	return [_subActions count] >0?_subActions:nil;
}

-(NSString*)label
{
	return self.name;
}

+ (NSString*)DEFAULT_ICON
{
	return [DEFAULT_ICON description];
}
@end

