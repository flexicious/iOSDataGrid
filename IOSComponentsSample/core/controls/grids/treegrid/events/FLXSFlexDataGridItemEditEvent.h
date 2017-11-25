#import "FLXSVersion.h"
#import "FLXSFlexDataGridEvent.h"

/**
	 * This event is dispatched in relation to edit related events. It contains the reference
	 * to the item editor.
	 */
@interface FLXSFlexDataGridItemEditEvent : FLXSFlexDataGridEvent
{
}

@property (nonatomic, weak) UIView* itemEditor;
@property (nonatomic, weak) NSObject * changedValue;

- (id)initWithType:(NSString *)type andGrid:(FLXSFlexDataGrid *)grid andLevel:(FLXSFlexDataGridColumnLevel *)level andColumn:(FLXSFlexDataGridColumn *)column andCell:(UIView <FLXSIFlexDataGridCell> *)cell andItem:(NSObject *)item andTriggerEvent:(FLXSEvent *)triggerEvent andBubbles:(BOOL)bubbles andCancelable:(BOOL)cancelable;

@end

