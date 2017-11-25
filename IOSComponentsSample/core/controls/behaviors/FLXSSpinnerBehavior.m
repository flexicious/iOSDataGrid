#import "FLXSSpinnerBehavior.h"
#import "FLXSFlexDataGridEvent.h"
#import "FLXSISpinnerOwner.h"
#import "FLXSSpinner.h"
#import "UIView+UIViewAdditions.h"

@implementation FLXSSpinnerBehavior

@synthesize ownerComponent;

-(id)initWithGrid:(UIView<FLXSISpinnerOwner>*)ownerComponentIn
{
    self = [super init];
    if (self)
    {
        self.ownerComponent=ownerComponentIn;
//        [ownerComponent addEventListenerOfType:[FLXSFlexDataGridEvent CREATION_COMPLETE] usingTarget:self withHandler:@selector(onOwnerCreationComplete:)];
    }
    return self;
}
//
//-(void)onOwnerCreationComplete:(NSNotification*)ns
//{
////    FLXSEvent *event = (FLXSEvent *)[ns.userInfo objectForKey:@"event"];
////    UIView<FLXSISpinnerOwner>* isp=((UIView<FLXSISpinnerOwner>*)event.target);
////	if(isp.showSpinnerOnCreationComplete)
////	{
////		[isp showSpinner : @""];
////	}
//}

-(void)showSpinner:(NSString*)msg
{
    if(!ownerComponent.spinner)
    {
        if(!ownerComponent.spinnerFactory)ownerComponent.spinnerFactory= [[FLXSClassFactory alloc] initWithClass:[FLXSSpinner class] andProperties:nil];
        ownerComponent.spinner = [ownerComponent.spinnerFactory generateInstance];
    }
    UIView<FLXSISpinner>* spinner=ownerComponent.spinner ;
    if(!spinner.superview)
    {
        [ownerComponent.spinnerParent addChild:spinner];
        [ownerComponent.spinnerParent bringSubviewToFront:spinner];
    }

    spinner.hidden=NO;
    for(UIView* child in ownerComponent.elementsToBlur)
        child.alpha=[ownerComponent getStyle:(@"spinnerGridAlpha")]!=nil? [[ownerComponent getStyle:(@"spinnerGridAlpha")] floatValue] :0.1;
    float rad=[ownerComponent getStyle:(@"spinnerRadius")]||10;
    [spinner setStyle:(@"spinnerRadius") value:([ownerComponent getStyle:(@"spinnerRadius")])];
    spinner.startX=(ownerComponent.elementToCenter.width/2)-rad;
    spinner.startY=ownerComponent.elementToCenter.height/2;
    spinner.center = ownerComponent.center;
    [spinner setStyle:(@"spinnerColor") value:([ownerComponent getStyle:(@"spinnerColor")])];
    [spinner setStyle:(@"labelShowBackground") value:([ownerComponent getStyle:(@"spinnerLabelShowBackground")])];
    [spinner setStyle:(@"labelBackgroundColor") value:([ownerComponent getStyle:(@"spinnerLabelBackgroundColor")])];
    [spinner setStyle:(@"spinnerThickness") value:([ownerComponent getStyle:(@"spinnerThickness")])];
    [spinner setStyle:(@"labelColor") value:([ownerComponent getStyle:(@"spinnerLabelColor")])];
    [spinner setStyle:(@"fontWeight") value:([ownerComponent getStyle:(@"spinnerLabelfontWeight")])];
    [spinner setStyle:(@"fontThickness") value:([ownerComponent getStyle:(@"spinnerLabelfontThickness")])];
    [spinner setStyle:(@"fontStyle") value:([ownerComponent getStyle:(@"spinnerLabelfontStyle")])];
    [spinner setStyle:(@"pointSize") value:([ownerComponent getStyle:(@"spinnerLabelfontSize")])];
    [spinner setStyle:(@"fontFamily") value:([ownerComponent getStyle:(@"spinnerLabelfontFamily")])];
    if([msg isEqual:@""])
        spinner.label=ownerComponent.spinnerLabel;
    else
        spinner.label=msg;
    [spinner startSpin];
}

-(void)hideSpinner
{
    if(ownerComponent.spinner)
    {
        [ownerComponent.spinner stopSpin];
        if(ownerComponent.spinner.superview)
        {
            [ownerComponent.spinner removeFromSuperview];
        }
        ownerComponent.spinner=nil;
    }
    for(UIView* child in ownerComponent.elementsToBlur)
        child.alpha=1;
}
-(void) dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver: self];

}

@end

