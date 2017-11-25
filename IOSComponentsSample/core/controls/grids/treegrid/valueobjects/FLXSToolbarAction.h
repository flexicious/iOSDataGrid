#import "FLXSVersion.h"
@class FLXSEvent;

/**
	 * A class that represents a tool bar action that will appear in the toolbar of the datagrid.
	 * Please ensure to wire up the toolbarActionExecutedFunction and toolbarActionValidFunction function
	 * on the datagrid control.
	 */
@interface FLXSToolbarAction : NSObject
{

}
/**
      * The actual button associated with the toolbar action.
      */
@property (nonatomic, strong) NSObject* trigger;
/**
		 * To support runtime enable/disable of toolbar actions.
		 */
@property (nonatomic, assign) BOOL enabled;
/**
		 * Flag to control whether or not to draw a seperator before the action icon.
		 * Deperecated. Please use the code='separator' instead
		 */
@property (nonatomic, assign) BOOL separatorBefore;
/**
		 * Flag to control whether or not to draw a seperator after the action icon
		 * Deperecated. Please use the code='separator' instead
		 */
@property (nonatomic, assign) BOOL separatorAfter;
/**
		 * Name of the action
		 */
@property (nonatomic, strong) NSString* name;
/**
		 * Code of the action, if not specified, defaults to the name
		 */
@property (nonatomic, strong) NSString* code;
/**
		 * Tooltip for the icon. If not specified, defaults to the name
		 */
@property (nonatomic, strong) NSString* tooltip;
/**
		 * Icon for the image button. If not specified, defaults to the custom action icon.
		 */
@property (nonatomic, strong) NSObject* iconUrl;
/**
		 * Icon for the image button. If not specified, defaults to the custom action icon.
		 */
@property (nonatomic, strong) NSObject* disabledIconUrl;
/**
		 * This action will be disabled if a selection is required and there is nothing selected in the grid.
		 */
@property (nonatomic, assign) BOOL requiresSelection;
/**
		 * This action will be disabled if a more than one item or no items are selected in the grid.
		 */
@property (nonatomic, assign) BOOL requiresSingleSelection;
/**
		 * Level at which the action is to be applied.
		 * If not specified, defaults to 1. If you set this to -1, the action will appear in the tool bar at all levels.
		 * Defaults to -1
		 */
@property (nonatomic, assign) int level;
/**
		 * A list of ToolbarAction objects that get converted into dropdown menu buttons.
		 */
@property (nonatomic, strong) NSArray* subActions;
/**
		 * This means the action itself is only a container for subactions, clicking on it does nothing.
		 */
@property (nonatomic, assign) BOOL dropDownOnly;
/**
		 * A callback that lets you control if this toolbar action is currently valid.
		 */
@property (nonatomic, strong) NSString* isEnabledFunction;
/**
		 * A callback that lets you control what this toolbar action bridge.
		 */
@property (nonatomic, strong) NSString* executedFunction;
@property (nonatomic, assign) id delegate;


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
               andDelegate:(id)delegate;


//FLXSIEventDispatcher methods
-(void)dispatchEvent:(FLXSEvent *)event;

- (void)addEventListener:(NSString *)type target:(NSObject *)target handler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
//End FLXSIEventDispatcher methods
//IDelayChange

-(BOOL)isRegularAction;
-(BOOL)isDropDownAction;
-(BOOL)isSeparator;
-(NSArray*)children;
-(NSString*)label;

+ (NSString*)DEFAULT_ICON;
@end

