#import "FLXSTriStateCheckBox.h"
#import "UIView+UIViewAdditions.h"
#import "FLXSTouchEvent.h"

static NSString *STATE_CHECKED = @"checked";
static NSString *STATE_UNCHECKED = @"unchecked";
static NSString *STATE_MIDDLE = @"middle";


@implementation FLXSTriStateCheckBox {

    NSTimer *timerInstance;
    BOOL _selectedSet;
@private
    NSString *_label;
    NSString *_radioButtonGroupName;
    NSString *_radioButtonGroupSelectedLabel;
    BOOL _radioButtonMode;
    BOOL _checked;
    BOOL _middle;
    NSString * _selectedState;
}


 @synthesize checked = _checked;
 @synthesize allowUserToSelectMiddle = _allowUserToSelectMiddle;
 @synthesize delayDuration = _delayDuration;
@synthesize enableDelayChange = _enableDelayChange;


@synthesize label = _label;

@synthesize radioButtonGroupName = _radioButtonGroupName;
@synthesize radioButtonGroupSelectedLabel = _radioButtonGroupSelectedLabel;

@synthesize imageView = _imageView;

@synthesize titleLabel = _titleLabel;

@synthesize labelGap = _labelGap;

@synthesize checkedCheckBox = _checkedCheckBox;
@synthesize unCheckedCheckBox = _unCheckedCheckBox;
@synthesize partiallySelectedCheckBox = _partiallySelectedCheckBox;
@synthesize radioButtonSelected = _radioButtonSelected;
@synthesize radioButtonUnselected = _radioButtonUnselected;

- (id)init {
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;

}

- (void)_init {
// Initialization code
    _middle = NO;
    _checked = NO;
    _allowUserToSelectMiddle = NO;
    _radioButtonMode = NO;
    _delayDuration = 1;
    _selectedState = [FLXSTriStateCheckBox STATE_UNCHECKED];
    self.checkedCheckBox = [UIImage imageNamed:@"FLXSAPPLE_checked_checkbox.png"];
    self.unCheckedCheckBox = [UIImage imageNamed:@"FLXSAPPLE_unchecked_checkbox.png"];
    self.partiallySelectedCheckBox = [UIImage imageNamed:@"FLXSAPPLE_partially_selected_checkbox.png"];
    self.radioButtonSelected = [UIImage imageNamed:@"FLXSAPPLE_radio_button_selected.png"];
    self.radioButtonUnselected = [UIImage imageNamed:@"FLXSAPPLE_button_unselected.png"];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.labelGap = 6;

    UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, MAX(0,(self.height-self.checkedCheckBox.size.height)/2),
            self.checkedCheckBox.size.width, self.checkedCheckBox.size.height)];
    [self addSubview:view];
    self.imageView = view;



    self.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
    self.allowUserToSelectMiddle=NO;
     [self updateImage];



}
-(NSString *)title{
    return self.titleLabel.text;
}
-(void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    self.titleLabel.size = [title sizeWithFont:self.titleLabel.font];
     [self.titleLabel moveToX:self.imageView.image.size.width + self.labelGap y:(self.height-self.titleLabel.size.height)/2];
}
- (BOOL)middle {
    return _middle;
}


-(void)setMiddle:(BOOL)value
{
    _selectedSet = YES;
    if (_middle != value)
    {
        _checked = NO;
        _middle = value;
        [self updateImage];
        [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSTriStateCheckBox EVENT_CHANGE]
                                              andCancelable:false
                                                 andBubbles:false] ];
    }
}




-(void)setChecked:(BOOL)value
{
    _selectedSet = YES;
    if (_checked != value)
    {
        _checked = value;
        [self updateImage];
        [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSTriStateCheckBox EVENT_CHANGE]
                                              andCancelable:false
                                                 andBubbles:false] ];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {


    UITouch *touch;
    touch = [touches anyObject];

    if ([[touch view] isEqual: self]) {
        if(self.allowUserToSelectMiddle)
        {
            if(!self.middle)
            {
                if(!self.checked)
                {
                    self.middle = YES;
                }
                else
                {
                    self.checked = NO;
                }
            }
            else
            {
                if(!self.checked)
                {
                    _middle=NO;
                    self.checked = YES;
                }
                else
                {
                    self.middle = NO;
                }
            }
        }
        else
        {
            _middle=NO;
            self.checked = !self.checked;
        }

    }

    FLXSTouchEvent* evt = [[FLXSTouchEvent alloc] init];
    evt.target = self;
    evt.type = [FLXSTouchEvent TAP];
    [self dispatchEvent:evt];

}

- (void)updateImage {
    if (_middle) {
        self.imageView.image =  self.radioButtonMode?nil:self.partiallySelectedCheckBox;
    }
    else if (_checked) {
        self.imageView.image = self.radioButtonMode?self.radioButtonSelected:self.checkedCheckBox;
    }
    else {
        self.imageView.image = self.radioButtonMode?self.radioButtonUnselected:self.unCheckedCheckBox;

    }
}


- (NSString *)selectedState {
    if (self.middle)return STATE_MIDDLE;
    return (self.checked ? STATE_CHECKED : STATE_UNCHECKED);
}

- (void)setSelectedState:(NSString *)value {
    _selectedSet = YES;
    if ([value isEqual: STATE_MIDDLE]) {
        _middle = YES;
        _checked = NO;
    }
    else if ([value isEqual: STATE_CHECKED]) {
        _checked = YES;
        _middle = NO;
    }
    else if ([value isEqual: STATE_UNCHECKED]) {
        _checked = NO;
        _middle = NO;
    }
    [self updateImage];
}

-(void)clear
{
    self.selectedState =  STATE_MIDDLE;
}

-(NSObject*)getValue
{
    return self.selectedState;
}

-(void)setValue:(NSObject*)val
{
    self.selectedState= [val description];
}


- (BOOL)radioButtonMode {
    return _radioButtonMode;
}

- (void)setRadioButtonMode:(BOOL)value {
    if (_radioButtonMode != value) {

    }
    _radioButtonMode = value;
    [self updateImage];
}
//Start FLXSIEventDispatcher methods

- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler {
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
-(void)dispatchEvent:(FLXSEvent *)event {

    if(event.type == [FLXSTriStateCheckBox EVENT_CHANGE])
    {
        if(self.radioButtonMode && (![FLXSUIUtils nullOrEmpty:self.radioButtonGroupName]) && self.checked){
            //this means we have to unselect other radios with the same group name
            for (UIView *otherView in self.superview.subviews){
                if([otherView isKindOfClass:[FLXSTriStateCheckBox class]]){
                    FLXSTriStateCheckBox *otherCheckbox = (FLXSTriStateCheckBox *) otherView;
                    if(otherCheckbox!=self&&[otherCheckbox.radioButtonGroupName isEqualToString:self.radioButtonGroupName]){
                        otherCheckbox.checked = NO;
                        otherCheckbox.radioButtonGroupSelectedLabel = self.title;
                    }
                }
            }
            self.radioButtonGroupSelectedLabel = self.title;
        }
        if(self.enableDelayChange)
        {
            // if change event, intercept
            if (timerInstance != nil){
                [timerInstance invalidate];
                timerInstance =nil;//we don't want timer instance to fire.
            }

            if (timerInstance == nil)
            {
                timerInstance = [NSTimer scheduledTimerWithTimeInterval:self.delayDuration
                                                                 target:self
                                                               selector:@selector(onTimerComplete:)
                                                               userInfo:nil
                                                                repeats:NO];
            }
        }

    }
    [FLXSUIUtils dispatchEvent:event
                    withSender:self];
}
-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
    [super setUserInteractionEnabled:userInteractionEnabled];
    self.alpha = userInteractionEnabled?1:0.6;

}
-(UILabel *)titleLabel {
    if(!_titleLabel){
        UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.checkedCheckBox.size.width+2, 0, 0, self.checkedCheckBox.size.height)];
        [self addSubview:lbl];
        _titleLabel = lbl;
    }
    return _titleLabel;
}
-(void)onTimerComplete:(NSTimer*)timer
{
    [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSTriStateCheckBox EVENT_DELAYED_CHANGE]
                                          andCancelable:false
                                             andBubbles:false]];
    timerInstance=nil;
}
//End FLXSIEventDispatcher methods
+ (NSString *)STATE_CHECKED {
    return STATE_CHECKED;
}

+ (NSString *)STATE_UNCHECKED {
    return STATE_UNCHECKED;
}

+ (NSString *)STATE_MIDDLE {
    return STATE_MIDDLE;
}
+ (NSString *)EVENT_DELAYED_CHANGE
{
    return [FLXSEvent EVENT_DELAYED_CHANGE];
}
+ (NSString *)EVENT_CHANGE
{
    return [FLXSEvent EVENT_CHANGE];
}
- (void)setActualSizeWithWidth:(float)width andHeight:(float)height {
    [super setActualSizeWithWidth:width andHeight:height];

}
@end

