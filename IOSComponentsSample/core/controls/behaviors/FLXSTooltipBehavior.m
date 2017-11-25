#import "FLXSTooltipBehavior.h"

@implementation FLXSTooltipBehavior {

}

@synthesize ownerComponent = _ownerComponent;
@synthesize currentTooltip = _currentTooltip;
@synthesize currentTooltipTrigger = _currentTooltipTrigger;
@synthesize tooltipWatcher = _tooltipWatcher;
@synthesize tooltipWatcherTimeout = _tooltipWatcherTimeout;

-(id)initWithGrid:(UIView*)ownerComponent
{
	self = [super init];
	if (self)
	{
		self.tooltipWatcherTimeout = 500;

		self.ownerComponent=ownerComponent;
	}
	return self;
}


- (void)showTooltip:(UIView *)relativeTo tooltip:(UIView *)tooltip dataContext:(NSObject *)dataContext point:(Point *)point leftOffset:(float)leftOffset topOffset:(float)topOffset offScreenMath:(BOOL)offScreenMath where:(NSString *)where container:(NSObject *)container {
    //next version
//	if(currentTooltip)[self hideTooltip];
//	if(tooltip is IExtendedTooltip)
//	{
//		(tooltip as IExtendedTooltip).tooltipOwner = ownerComponent;
//	}
//	currentTooltip=tooltip;
//	currentTooltipTrigger=relativeTo;
//	if(!container)
//		container=[UIUtils getTopLevelApplication];
//	[PopUpManager addPopUp:currentTooltip as IFlexDisplayObject :container as DisplayObject]
//if(point)
//	{
//		[currentTooltip move:point.x :point.y];
//		if(offScreenMath)
//			[UIUtils ensureWithinView:tooltip :container as IUIComponent]
//	}
//	else
//[UIUtils positionBelow:tooltip :relativeTo :leftOffset :topOffset :offScreenMath :where];
//	tooltipWatcher = [[Timer alloc] init:tooltipWatcherTimeout];
//	[tooltipWatcher addEventListener:[TimerEvent TIMER] :([self function:(event:TimerEvent)]:void{
//if(!ownerComponent.stage){
//[tooltipWatcher stop];
//tooltipWatcher=nil;
//return;
//}
//if(!currentTooltip ){[self hideTooltip];return;}
//BOOL shouldShow=NO;
//var pts:Array=[ownerComponent.stage getObjectsUnderPoint:(([[Point alloc] init:ownerComponent.stage.mouseX :ownerComponent.stage.mouseY]))];
//for(var pt:DisplayObject in pts){
//shouldShow=(
//([currentTooltip owns:pt]
//||[currentTooltipTrigger owns:pt]) )
//if(shouldShow){
//return;
//}
//}
//[self hideTooltip];
//})];
//	[tooltipWatcher start];
//	NSObject* tooltipObject=tooltip;
//	if([tooltipObject hasOwnProperty:(@"data")])
//		tooltipObject[@"data"]=dataContext;
//	if([tooltipObject hasOwnProperty:(@"grid")])
//		tooltipObject[@"grid"]=self;
}

-(void)toolTipMoveHandler:(FLXSEvent*)event
{
}

-(void)hideTooltip
{
    //next version
//	if(tooltipWatcher)
//	{
//		if(tooltipWatcher.running)
//			[tooltipWatcher stop]
//			tooltipWatcher=nil;
//	}
//	if(currentTooltip)
//	{
//		if(currentTooltip.parent)
//			[PopUpManager removePopUp:currentTooltip as IFlexDisplayObject]
//			if(@"destroy" in currentTooltip)currentTooltip[@"destroy"[] apply];
//		currentTooltipTrigger=nil
//currentTooltip=nil;
//	}
}

@end

