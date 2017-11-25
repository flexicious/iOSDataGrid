

#import "FLXSSelectableTextField.h"
#import "FLXSFlexDataGridCell.h"


@implementation FLXSSelectableTextField {

}

- (id)init{
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self   _init];
    }
    return self;

}
-(void)_init{
    self.borderStyle = UITextBorderStyleNone;
    self.delegate = self;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.allowsEditingTextAttributes = NO;

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    FLXSFlexDataGridCell* parentCell = (FLXSFlexDataGridCell*)self.superview;
    [parentCell touchesBegan:touches withEvent:event];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}        // return NO to disallow editing
@end