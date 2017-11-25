#import <QuartzCore/QuartzCore.h>
#import "FLXSTextInput.h"


static NSString * INSIDE_ICON_CLICK = @"insideIconClick";
static NSString * OUTSIDE_ICON_CLICK = @"outsideIconClick";
static NSString * AUTO_COMPLETE_MATCH_TYPE_BEGINS_WITH = @"BeginsWith";
static NSString * AUTO_COMPLETE_MATCH_TYPE_ENDS_WITH = @"EndsWith";
static NSString * AUTO_COMPLETE_MATCH_TYPE_CONTAINS = @"Contains";




@interface FLXSTextInput ()
- (void)updateAutoCompleteList;


@end

@implementation FLXSTextInput {
 @protected
    UITableView *autoCompleteTable;
 @public
    NSMutableArray *autoCompleteList; // list that pops out

}

@synthesize timerInstance;
@synthesize delayDuration;
@synthesize enableDelayChange;
@synthesize toSet;
@synthesize clearTextOnIconClick;
@synthesize showIconWhenHasText;
@synthesize enableAutoComplete;
@synthesize autoCompleteRowCount;
@synthesize autoCompleteWidth;
@synthesize autoCompleteDropDownBorderWidth;
@synthesize autoCompleteDropDownBorderColor;
@synthesize autoCompleteSource;
@synthesize autoCompleteMatchType;
@synthesize autoCompleteDataField;
@synthesize autoCompleteLabelField;
@synthesize inputMask;
@synthesize inputMaskDelimiters;
@synthesize inputMaskForceLength;
@synthesize idValue;



- (void)_init {
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.autoCompleteRowCount = 4;
    self.delegate = self;
    [[NSNotificationCenter defaultCenter]
            addObserver:self
               selector:@selector(textDidChange:)
                   name:UITextFieldTextDidChangeNotification
                 object:self];


    self.borderStyle = UITextBorderStyleRoundedRect;
    self.rightViewMode = UITextFieldViewModeAlways;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.enableDelayChange=YES;
}
- (id)init {
    if ((self = [super init])) {
        [self _init];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self _init];
    }
    return self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]
            removeObserver:self
                      name:UITextFieldTextDidChangeNotification
                    object:self];
}
-(void) textDidChange:(NSNotification *)notification
{
    if(self.enableAutoComplete){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        int height = (int) cell.frame.size.height;

        CGRect dropDownTableFrame;
        dropDownTableFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width,self.autoCompleteRowCount*height);
        autoCompleteList = [[NSMutableArray alloc] init];
        if(autoCompleteTable == nil)
        {
            autoCompleteTable = [[UITableView alloc] initWithFrame:dropDownTableFrame style:UITableViewStylePlain];
            autoCompleteTable.delegate = self;
            autoCompleteTable.dataSource = self;
            autoCompleteTable.scrollEnabled = YES;
            [self.superview addSubview:autoCompleteTable];
            autoCompleteTable.layer.borderWidth = self.autoCompleteDropDownBorderWidth;
            autoCompleteTable.layer.borderColor = self.autoCompleteDropDownBorderColor;
        }
        else
        {
            autoCompleteTable.hidden = NO;
        }
        if([self.text length] == 0)
        {
            autoCompleteTable.hidden = YES;
        }
        [self updateAutoCompleteList];
        [autoCompleteTable reloadData];
    }
    [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSEvent EVENT_CHANGE]
                                          andCancelable:false
                                             andBubbles:false] ];
}
- (void)updateAutoCompleteList {
    [autoCompleteList removeAllObjects];
    NSPredicate *predicate;
    if ([autoCompleteMatchType isEqual: AUTO_COMPLETE_MATCH_TYPE_BEGINS_WITH] || autoCompleteMatchType == nil)
    {
    predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[cd] %@", self.text];
    } else if ([autoCompleteMatchType isEqual: AUTO_COMPLETE_MATCH_TYPE_ENDS_WITH])
    {
    predicate = [NSPredicate predicateWithFormat:@"SELF ENDSWITH[cd] %@",self.text];
    }else if ([autoCompleteMatchType isEqual: AUTO_COMPLETE_MATCH_TYPE_CONTAINS])
    {
        predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",self.text];
    }
    autoCompleteList = [[autoCompleteSource filteredArrayUsingPredicate:predicate] mutableCopy];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    autoCompleteTable.hidden = YES;
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return autoCompleteList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];


    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }
    // Configure the cell...
    cell.textLabel.text = [autoCompleteList objectAtIndex:indexPath.row];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.text = [autoCompleteList objectAtIndex:indexPath.row];
    autoCompleteTable.hidden = YES;
    [self resignFirstResponder];
    [self.superview becomeFirstResponder];
}

-(void)setAutoCompleteSource:(NSMutableArray *)autoCompleteSourceIn {
    autoCompleteSource=autoCompleteSourceIn;
    if(autoCompleteSourceIn.count>0){
        self.enableAutoComplete=YES;
    }
}

//FLXSIFilterControl Methods

-(NSString*)searchField
{
    return self.filterControlInterface.searchField;
}

-(void)setSearchField:(NSString*)o
{
    self.filterControlInterface.searchField = o;
}

-(NSObject <FLXSIExtendedDataGrid>*)grid
{
    return self.filterControlInterface.grid;
}

-(void)setGrid:(NSObject <FLXSIExtendedDataGrid>*)o
{
    self.filterControlInterface.grid = o;
}

-(NSObject <FLXSIDataGridFilterColumn>*)gridColumn
{
    return self.filterControlInterface.gridColumn;
}

-(void)setGridColumn:(NSObject <FLXSIDataGridFilterColumn>*)o
{
    self.filterControlInterface.gridColumn = o;
}

-(NSString*)filterOperation
{
    return self.filterControlInterface.filterOperation;
}

-(void)setFilterOperation:(NSString*)o
{
    self.filterControlInterface.filterOperation= o;
}

-(NSString*)filterComparisonType
{
    return self.filterControlInterface.filterComparisonType;
}

-(void)setFilterComparisonType:(NSString*)o
{
    self.filterControlInterface.filterComparisonType= o;
}

-(FLXSFilterControlImpl *)filterControlInterface
{
    if(_filterControlInterface==nil)
        _filterControlInterface= [[FLXSFilterControlImpl alloc] initWithFilterControl:self];
    return _filterControlInterface;
}

-(NSString*)filterTriggerEvent
{
    return self.filterControlInterface.filterTriggerEvent;
}

-(void)setFilterTriggerEvent:(NSString*)o
{
    self.filterControlInterface.filterTriggerEvent = o;
}

-(BOOL)autoRegister
{
    return self.filterControlInterface.autoRegister;
}

-(void)setAutoRegister:(BOOL)value
{
    self.filterControlInterface.autoRegister = value;
}
-(void)clear
{
    self.text=@"";
}

-(NSString*)getValue
{
    return self.text;
}

-(void)setValue:(NSString*)val
{
    self.text= val!=nil?[val description]:@"";
}
//End FLXSIFilterControl Methods
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
    if(self.enableDelayChange)
    {
        if([event.type isEqual: [FLXSEvent EVENT_CHANGE]])
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

-(void)onTimerComplete:(NSTimer*)timer
{
    [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSEvent EVENT_DELAYED_CHANGE]
                                          andCancelable:false
                                             andBubbles:false]];
    timerInstance=nil;
}
//End FLXSIEventDispatcher methods



//constants

+ (NSString *)INSIDE_ICON_CLICK
{
	return INSIDE_ICON_CLICK;
}
+ (NSString *)OUTSIDE_ICON_CLICK
{
	return OUTSIDE_ICON_CLICK;
}
+ (NSString *)AUTO_COMPLETE_MATCH_TYPE_BEGINS_WITH
{
	return AUTO_COMPLETE_MATCH_TYPE_BEGINS_WITH;
}
+ (NSString *)AUTO_COMPLETE_MATCH_TYPE_ENDS_WITH
{
	return AUTO_COMPLETE_MATCH_TYPE_ENDS_WITH;
}
+ (NSString *)AUTO_COMPLETE_MATCH_TYPE_CONTAINS
{
	return AUTO_COMPLETE_MATCH_TYPE_CONTAINS;
}


@end

