#import "FLXSPopupUIViewControllerBase.h"
#import "FLXSUIUtils.h"
#import "FLXSCloseEvent.h"
#import "UIViewController+UIViewControllerAdditions.h"

@implementation FLXSPopupUIViewControllerBase {

}

-(void)initializeToolBar{
 
}

- (void) closePopup{
    FLXSCloseEvent* evt = [[FLXSCloseEvent alloc] initWithType:[FLXSCloseEvent CLOSE]
                                                 andCancelable:NO
                                                    andBubbles:NO];
    evt.detail = [FLXSCloseEvent CANCEL] ;
    [self dispatchEvent:evt];

    if([FLXSUIUtils isIPad]){
       // [self.parentViewController dismissModalViewControllerAnimated:YES];
        [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self performSelector:@selector(removeViewFromUIWindow) withObject: nil     afterDelay:0.5];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }

}


-(void)removeViewFromUIWindow{
    
    self.containerViewController = nil;
}

@end