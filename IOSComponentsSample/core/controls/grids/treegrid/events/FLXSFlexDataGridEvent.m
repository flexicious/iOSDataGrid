#import "FLXSFlexDataGridEvent.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGridColumn.h"

static NSString* CREATION_COMPLETE = @"creationComplete";

static NSString* CHANGE = @"change";
static NSString* AUTO_REFRESH = @"autoRefresh";
static NSString* DATA_PROVIDER_CHANGE = @"dataProviderChange";
static NSString* COLUMNS_RESIZED = @"columnsResized";
static NSString* COLUMN_STRETCH = @"columnsStretch";

static NSString* SCROLL = @"scroll";

static NSString* COLUMNS_SHIFT = @"columnsShift";
static NSString* COMPONENTS_CREATED = @"componentsCreated";
static NSString* COLUMN_RESIZED = @"columnResized";
static NSString* COLUMN_X_CHANGED = @"columnXChanged";
static NSString* HEADER_CLICKED = @"headerClicked";
static NSString* SELECT_ALL_CHECKBOX_CHANGED = @"selectAllCheckBoxChanged";
static NSString* ITEM_OPEN = @"itemOpen";
static NSString* ITEM_OPENING = @"itemOpening";
static NSString* ITEM_CLOSE = @"itemClose";
static NSString* ITEM_CLOSING = @"itemClosing";
static NSString* ITEM_EDIT_CANCEL = @"itemEditCancel";
static NSString* ITEM_EDIT_VALUE_COMMIT = @"itemEditValueCommit";
static NSString* ITEM_EDIT_END = @"itemEditEnd";
static NSString* ITEM_EDIT_BEGINNING = @"itemEditBeginning";
static NSString* ITEM_EDIT_BEGIN = @"itemEditBegin";
static NSString* ITEM_EDITOR_CREATED = @"itemEditorCreated";
static NSString* ITEM_FOCUS_IN = @"itemFocusIn";
static NSString* ITEM_ROLL_OVER = @"itemRollOver";
static NSString* ITEM_ROLL_OUT = @"itemRollOut";
static NSString* ITEM_CLICK = @"itemClick";
static NSString* ITEM_RIGHT_CLICK = @"itemRightClick";
static NSString* ITEM_DOUBLE_CLICK = @"itemDoubleClick";

static NSString* DYNAMIC_LEVEL_CREATED = @"dynamicLevelCreated";
static NSString* DYNAMIC_ALL_LEVELS_CREATED = @"dynamicAllLevelsCreated";
static NSString* ICON_MOUSE_OVER = @"iconMouseOver";
static NSString* ICON_CLICK = @"iconClick";
static NSString* ICON_MOUSE_OUT = @"iconMouseOut";
static NSString* PREBUILT_FILTER_RUN = @"prebuiltFilterRun";
static NSString* RENDERER_INITIALIZED = @"rendererInitialized";
static NSString* CELL_RENDERED = @"cellRendered";
static NSString* CELL_CREATED = @"cellCreated";
static NSString* PLACING_SECTIONS = @"placingSections";



@implementation FLXSFlexDataGridEvent

@synthesize columnFLXS;
@synthesize level;
@synthesize grid;
@synthesize cellFLXS;
@synthesize item;
@synthesize isItemSelected;
@synthesize triggerEvent;

- (id)initWithType:(NSString *)type
           andGrid:(FLXSFlexDataGrid *)gridIn
          andLevel:(FLXSFlexDataGridColumnLevel *)levelIn
         andColumn:(FLXSFlexDataGridColumn *)columnIn
           andCell:(UIView <FLXSIFlexDataGridCell> *)cellIn
           andItem:(NSObject *)itemIn
   andTriggerEvent:(FLXSEvent *)triggerEventIn
        andBubbles:(BOOL)bubblesIn
     andCancelable:(BOOL)cancelableIn {
	self = [super initWithType:type
                 andCancelable:cancelableIn
                    andBubbles:bubblesIn
            ];
	if (self)
	{
		self.grid=gridIn;
		self.level=levelIn;
		self.columnFLXS = columnIn;
		self.cellFLXS =cellIn;
		self.item = itemIn;
		self.triggerEvent=triggerEventIn;
	}
	return self;
}


-(FLXSEvent*)clone
{
	return [[FLXSFlexDataGridEvent alloc] initWithType:self.type andGrid:self.grid andLevel:self.level andColumn:self.columnFLXS andCell:self.cellFLXS andItem:self.item andTriggerEvent:self.triggerEvent andBubbles:self.bubbles andCancelable:self.cancelable];
}

+ (NSString*)CREATION_COMPLETE
{
    return CREATION_COMPLETE;
}
+ (NSString*)CHANGE
{
	return CHANGE;
}
+ (NSString*)AUTO_REFRESH
{
	return AUTO_REFRESH;
}
+ (NSString*)DATA_PROVIDER_CHANGE
{
	return DATA_PROVIDER_CHANGE;
}
+ (NSString*)COLUMNS_RESIZED
{
	return COLUMNS_RESIZED;
}
+ (NSString*)COLUMN_STRETCH
{
    return COLUMN_STRETCH;
}

+ (NSString*)COLUMNS_SHIFT
{
	return COLUMNS_SHIFT;
}
/**
 * Dispatched when all the cells snap to the calculated column widths.
 * Event Type:com.flexicious.nestedtreedatagrid.events.FlexDataGridEvent
 */

+ (NSString*)COMPONENTS_CREATED
{
	return COMPONENTS_CREATED;
}
+ (NSString*)COLUMN_RESIZED
{
	return COLUMN_RESIZED;
}
+ (NSString*)COLUMN_X_CHANGED
{
	return COLUMN_X_CHANGED;
}
+ (NSString*)HEADER_CLICKED
{
	return HEADER_CLICKED;
}
+ (NSString*)SELECT_ALL_CHECKBOX_CHANGED
{
	return SELECT_ALL_CHECKBOX_CHANGED;
}
+ (NSString*)ITEM_OPEN
{
	return ITEM_OPEN;
}
+ (NSString*)ITEM_OPENING
{
	return ITEM_OPENING;
}
+ (NSString*)ITEM_CLOSE
{
	return ITEM_CLOSE;
}
+ (NSString*)ITEM_CLOSING
{
	return ITEM_CLOSING;
}
+ (NSString*)ITEM_EDIT_CANCEL
{
	return ITEM_EDIT_CANCEL;
}
+ (NSString*)ITEM_EDIT_VALUE_COMMIT
{
	return ITEM_EDIT_VALUE_COMMIT;
}
+ (NSString*)ITEM_EDIT_END
{
	return ITEM_EDIT_END;
}
+ (NSString*)ITEM_EDIT_BEGINNING
{
	return ITEM_EDIT_BEGINNING;
}
+ (NSString*)ITEM_EDIT_BEGIN
{
	return ITEM_EDIT_BEGIN;
}
+ (NSString*)ITEM_EDITOR_CREATED
{
	return ITEM_EDITOR_CREATED;
}
+ (NSString*)ITEM_FOCUS_IN
{
	return ITEM_FOCUS_IN;
}
+ (NSString*)ITEM_ROLL_OVER
{
	return ITEM_ROLL_OVER;
}
+ (NSString*)ITEM_ROLL_OUT
{
	return ITEM_ROLL_OUT;
}
+ (NSString*)ITEM_CLICK
{
	return ITEM_CLICK;
}
+ (NSString*)ITEM_RIGHT_CLICK
{
	return ITEM_RIGHT_CLICK;
}
+ (NSString*)ITEM_DOUBLE_CLICK
{
	return ITEM_DOUBLE_CLICK;
}
+ (NSString*)DYNAMIC_LEVEL_CREATED
{
	return DYNAMIC_LEVEL_CREATED;
}
+ (NSString*)DYNAMIC_ALL_LEVELS_CREATED
{
	return DYNAMIC_ALL_LEVELS_CREATED;
}
+ (NSString*)ICON_MOUSE_OVER
{
	return ICON_MOUSE_OVER;
}
+ (NSString*)ICON_CLICK
{
	return ICON_CLICK;
}
+ (NSString*)ICON_MOUSE_OUT
{
	return ICON_MOUSE_OUT;
}
+ (NSString*)PREBUILT_FILTER_RUN
{
	return PREBUILT_FILTER_RUN;
}
+ (NSString*)RENDERER_INITIALIZED
{
	return RENDERER_INITIALIZED;
}
+ (NSString*)CELL_RENDERED
{
	return CELL_RENDERED;
}
+ (NSString*)CELL_CREATED
{
	return CELL_CREATED;
}
+ (NSString*)PLACING_SECTIONS
{
	return PLACING_SECTIONS;
}

+ (NSString*)SCROLL
{
    return SCROLL;
}

@end

