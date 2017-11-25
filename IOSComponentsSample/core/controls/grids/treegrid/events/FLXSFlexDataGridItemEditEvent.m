#import "FLXSFlexDataGridItemEditEvent.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGridColumn.h"


@implementation FLXSFlexDataGridItemEditEvent

@synthesize itemEditor;
@synthesize changedValue;

- (id)initWithType:(NSString *)type andGrid:(FLXSFlexDataGrid *)grid andLevel:(FLXSFlexDataGridColumnLevel *)level andColumn:(FLXSFlexDataGridColumn *)column andCell:(UIView <FLXSIFlexDataGridCell> *)cell andItem:(NSObject *)item andTriggerEvent:(FLXSEvent *)triggerEvent andBubbles:(BOOL)bubbles andCancelable:(BOOL)cancelable {
	self = [super initWithType:type andGrid:grid andLevel:level andColumn:column andCell:cell andItem:item andTriggerEvent:triggerEvent andBubbles:bubbles andCancelable:cancelable];
	if (self)
	{
	}
	return self;
}

@end

