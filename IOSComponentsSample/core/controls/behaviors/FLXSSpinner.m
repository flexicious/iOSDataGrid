

#import "FLXSSpinner.h"
#import "UIView+UIViewAdditions.h"


@implementation FLXSSpinner {

@private
    NSString *_label;
    float _startX;
    float _startY;
    UIActivityIndicatorView *_activityIndicator;
    UILabel *_spinnerLabel;
    BOOL _labelShowBackground;
    UIColor *_labelBackgroundColor;
    UIColor *_labelColor;
    UIColor *_spinnerColor;
}
@synthesize label = _label;
@synthesize startX = _startX;
@synthesize startY = _startY;

@synthesize activityIndicator = _activityIndicator;
@synthesize spinnerLabel = _spinnerLabel;

@synthesize labelShowBackground = _labelShowBackground;
@synthesize labelBackgroundColor = _labelBackgroundColor;
@synthesize labelColor = _labelColor;

@synthesize spinnerColor = _spinnerColor;

- (void)startSpin {
    if(!self.activityIndicator){
        self.activityIndicator  = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator.center = self.superview.center;
        self.activityIndicator.color =  self.spinnerColor;
        [self.superview addSubview: self.activityIndicator];
        //self.self.activityIndicator.transform = CGAffineTransformMakeScale(2, 2);
        [self.activityIndicator startAnimating];

        self.spinnerLabel = [[UILabel alloc] init];
        self.spinnerLabel.text = self.label;
        [self.spinnerLabel sizeToFit];
        self.spinnerLabel.center= CGPointMake(self.superview.center.x, self.superview.center.y+self.activityIndicator.size.height+6);
        [self.superview addSubview: self.spinnerLabel];

        if(self.labelShowBackground){
            if(self.labelBackgroundColor!=nil)
                self.spinnerLabel.backgroundColor = self.labelBackgroundColor;
        }
        if(self.labelColor!=nil)
            self.spinnerLabel.textColor    = self.labelColor;
    }
}

-(void)removeFromSuperview {
    [self stopSpin];
    [super removeFromSuperview];
}
- (void)stopSpin {
    if(self.activityIndicator){
        [self.activityIndicator stopAnimating];
        [self.activityIndicator removeFromSuperview];
        self.activityIndicator=nil;

        [self.spinnerLabel removeFromSuperview];
        self.spinnerLabel=nil;

    }
}

- (UIView *)spinner {
    return self.activityIndicator;
}

- (void)validateNow {

}

@end