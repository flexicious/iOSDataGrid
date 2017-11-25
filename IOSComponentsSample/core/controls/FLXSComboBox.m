#import "FLXSComboBox.h"
#import "UIView+UIViewAdditions.h"
#define defaultNavTitle @"Select an Option"
@interface  FLXSComboBox()
@end
@implementation FLXSComboBox {
    
@protected
    UIButton *comboBoxButton;
    UITableView *popOverTable;
    BOOL selectedValueDirty;
    BOOL addAllItemDirty;
    
@private
    UITableView *_popOverTable;
    UIPopoverController *_popOverController;
    UIActionSheet *_uiActionSheet;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    UIAlertController *_alertController;
#endif
    int _selectedIndex;
    BOOL _addAllItem;
    NSString *_addAllItemText;
    BOOL _hasSearch;
    float _rowHeight;
    NSString *_dataFieldFLXS;
    NSString *_labelField;
    float _dropDownWidth;
    NSArray *_dataProviderFLXS;
    NSTimer *_popOverTimer;
}

@synthesize filterControlInterface=_filterControlInterface;
@synthesize popOverTable = _popOverTable;
@synthesize popOverController = _popOverController;
@synthesize uiActionSheet = _uiActionSheet;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
@synthesize alertController = _alertController;
#endif
@synthesize selectedIndex = _selectedIndex;
@synthesize selectedValue = _selectedValue;
@synthesize addAllItem = _addAllItem;
@synthesize addAllItemText = _addAllItemText;
@synthesize hasSearch = _hasSearch;
@synthesize rowHeight = _rowHeight;
@synthesize dataFieldFLXS = _dataFieldFLXS;
@synthesize labelField = _labelField;
@synthesize accessibilityIdentifier = _accessibilityIdentifier;
@synthesize pickerTitle;
@synthesize dropDownWidth = _dropDownWidth;
@synthesize showAccessory=_showAccessory;
@synthesize dataProviderFLXS = _dataProviderFLXS;

- (id)init{
    self = [super init];
    if (self) {
        [self _initWithIcon:nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initWithIcon:nil];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self   _initWithIcon:nil];
    }
    return self;
    
}
-(id)initWithFrame:(CGRect)frame AndIcon:(UIImage *)icon {
    self = [super initWithFrame:frame];
    if (self) {
        [self   _initWithIcon:icon];
    }
    return self;
    
}

-(void)_initWithIcon:(UIImage*)icon{
    self.showAccessory=YES;
    comboBoxButton = icon!=nil?[UIButton buttonWithType:UIButtonTypeCustom]:[UIButton buttonWithType:UIButtonTypeCustom];
    
    [comboBoxButton addTarget:self
                       action:@selector(comboBoxButtonClicked:)
             forControlEvents:UIControlEventTouchUpInside];
    
    if(icon){
        [comboBoxButton setImage:icon forState:UIControlStateNormal];
    }else{
        [comboBoxButton setTitle:@"All" forState:UIControlStateNormal];
        comboBoxButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [comboBoxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [comboBoxButton setImage:[UIImage imageNamed:@"FLXSAPPLE_dropdown.png"] forState: UIControlStateNormal];
        comboBoxButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.bounds.size.width-30, 0, 0);
        [comboBoxButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        
        
        self.layer.cornerRadius = 4.0;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }
    comboBoxButton.frame = self.bounds;
    
    //    comboBoxButton
    self.userInteractionEnabled = YES;
    comboBoxButton.userInteractionEnabled = YES;
    self.selectedIndex=-1;
    self.labelField=@"label";
    self.dataFieldFLXS =@"data";
    selectedValueDirty = NO;
    self.addAllItem = NO;
    addAllItemDirty = NO;
    self.addAllItemText = FLXSFilter.ALL_ITEM;
    self.hasSearch = NO;
    self.rowHeight = 0;
    self.opaque = NO;
    
    [self addSubview:comboBoxButton];
}
-(void)setAddAllItemText:(NSString *)val {
    _addAllItemText = val;
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}
- (void)comboBoxButtonClicked:(id)comboBoxButtonClicked {

    if([FLXSUIUtils isIPad]){
        if (self.popOverController == nil || self.popOverController.isPopoverVisible== NO)
        {
            UIViewController *myController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
            UIView *masterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,300)];
            myController.view = masterView;
            myController.preferredContentSize = masterView.frame.size;
            popOverTable = [[UITableView alloc] initWithFrame:masterView.bounds style:UITableViewStylePlain];
            popOverTable.delegate = self;
            popOverTable.dataSource = self;
            popOverTable.scrollEnabled = YES;
            [masterView addSubview:popOverTable];
            myController.contentSizeForViewInPopover = myController.view.frame.size;
            _popOverController = [[UIPopoverController alloc] initWithContentViewController:myController];
            self.popOverController.delegate = self;
            [self.popOverController presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else
        {
            [self.popOverController dismissPopoverAnimated: YES];
            _popOverController = nil;
        }
        
    }   else{
        
        if(self.uiActionSheet){
            [self.uiActionSheet dismissWithClickedButtonIndex:0 animated:YES];
            _uiActionSheet = nil;
        }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        else if(self.alertController){
            [self.alertController dismissViewControllerAnimated:YES completion:nil];
            _alertController = nil;
        }
#endif
        else{
            float width = 320.0f;
            UIWindow *topWindow = [FLXSUIUtils getTopLevelWindow];
            if(topWindow != nil){
                if(topWindow.bounds.size.width < topWindow.bounds.size.height)
                    width = topWindow.bounds.size.width;
                else
                    width = topWindow.bounds.size.height;
            }
            UIView *masterView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, width,240)];
            
            popOverTable = [[UITableView alloc] initWithFrame:masterView.bounds style:UITableViewStylePlain];
            popOverTable.delegate = self;
            popOverTable.dataSource = self;
            popOverTable.scrollEnabled = YES;
            [masterView addSubview:popOverTable];
            [popOverTable reloadData];
            
            
            //Nav bar
            UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0,0, width, 44)];
            //[navBar setBarStyle:UIBarStyleDefault];
            navItem = [[UINavigationItem alloc] init];
            
            if (pickerTitle == nil) {
                pickerTitle   = defaultNavTitle;
            }
            [navItem   setTitle:pickerTitle];
            UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonPressed:)];
            navItem.rightBarButtonItem = cancelBtn;
            [navBar pushNavigationItem:navItem animated:NO];
            
            //UIActionsheet depcrecated in IOS8
            if([FLXSUIUtils isRunningIOS8OrGreater]){
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
               
                _alertController = [UIAlertController alertControllerWithTitle:@"Select" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *one = [UIAlertAction actionWithTitle:@"1" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self.alertController dismissViewControllerAnimated:YES completion:nil];
                }];
                UIAlertAction *two = [UIAlertAction actionWithTitle:@"2" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self.alertController dismissViewControllerAnimated:YES completion:nil];
                }];
                UIAlertAction *three = [UIAlertAction actionWithTitle:@"3" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self.alertController dismissViewControllerAnimated:YES completion:nil];
                }];
                UIAlertAction *four = [UIAlertAction actionWithTitle:@"4" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self.alertController dismissViewControllerAnimated:YES completion:nil];
                }];
                
                UIAlertAction *done = [UIAlertAction actionWithTitle:@"4" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self.alertController dismissViewControllerAnimated:YES completion:nil];
                }];
                
                [self.alertController addAction:one];
                [self.alertController addAction:two];
                [self.alertController addAction:three];
                [self.alertController addAction:four];
                [self.alertController addAction:done];
                masterView.frame = CGRectMake(0, 20, width-15, 240);
                popOverTable.frame = masterView.frame;
                navBar.frame = CGRectMake(0, 0, width-15, 44);
                
                [self.alertController.view addSubview:masterView];
                [self.alertController.view addSubview:navBar];
                
                
                UIViewController* attachedVC = [FLXSUIUtils findFileOwnerForComponent:self];
                if(!attachedVC){
                    UIWindow *window = [FLXSUIUtils getTopLevelWindow];
                    attachedVC = window.rootViewController;
                }
                [attachedVC presentViewController:self.alertController animated:YES completion:nil];
                
#endif
            }else{

                _uiActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select"
                                                             delegate:self
                                                    cancelButtonTitle:@"Done"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"1",@"2",@"3",@"4",nil];
                
                self.uiActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
                [self.uiActionSheet setBounds:CGRectMake(0, 0, width, 300-44)];
                [self.uiActionSheet addSubview:masterView];
                [self.uiActionSheet addSubview:navBar];
                [self.uiActionSheet showInView:self];
            }
            
        }
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataProviderFLXS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    // Configure the cell...
    cell.textLabel.text = [self itemToLabel:[self.dataProviderFLXS objectAtIndex:indexPath.row]];
    
    if (self.showAccessory && (self.selectedIndex == indexPath.row))
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = (int)indexPath.row;
    [comboBoxButton setTitle:[self itemToLabel:self.selectedItem] forState:UIControlStateNormal];
    if([FLXSUIUtils isIPad]){
        [self.popOverController dismissPopoverAnimated:YES];
        [tableView reloadData];
        if([FLXSUIUtils isRunningIOS8OrGreater]){
            if(_popOverTimer){
                [_popOverTimer invalidate];
            }
            _popOverTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(checkPopoverHidden) userInfo:nil repeats:YES];
        }else
            [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSComboBox EVENT_CHANGE]
                                                  andCancelable:false
                                                     andBubbles:false] ];
    }  else{
        if([FLXSUIUtils isRunningIOS8OrGreater]){
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
            if(self.alertController){
                [self.alertController dismissViewControllerAnimated:YES completion:^{
                    [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSComboBox EVENT_CHANGE]
                                                          andCancelable:false
                                                             andBubbles:false] ];
                }];
                _alertController = nil;
            }else{
                [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSComboBox EVENT_CHANGE]
                                                      andCancelable:false
                                                         andBubbles:false] ];
            }
            
#endif
        }else{
            if(self.uiActionSheet){
                [self.uiActionSheet dismissWithClickedButtonIndex:0 animated:YES];
                _uiActionSheet=nil;
            }
            [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSComboBox EVENT_CHANGE]
                                                  andCancelable:false
                                                     andBubbles:false] ];
        }
    }
}

-(void)checkPopoverHidden{
    if(!self.popOverController.isPopoverVisible){
        [_popOverTimer invalidate];
        _popOverTimer = nil;
        [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSComboBox EVENT_CHANGE]
                                              andCancelable:false
                                                 andBubbles:false] ];
    }
}

#pragma Popover Delegate methods
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    
}

-(void)commitPropertiesSelectedValue
{
    if (selectedValueDirty)
    {
        selectedValueDirty=NO;
        for(NSObject* item in self.dataProviderFLXS)
        {
            NSString* lhs= [item isKindOfClass:[NSString class]]?item: [item valueForKey:self.dataFieldFLXS];
            lhs = [lhs lowercaseString];
            NSString* rhs= [_selectedValue lowercaseString];
            if ([lhs isEqualToString: rhs])
            {
                self.selectedIndex= (int)[self.dataProviderFLXS indexOfObject:item];
                return ;
            }
        }
        //we were not able to set - so set to nil
        self.selectedIndex=-1;
    }
}

-(void)setSelectedValue:(NSString*)val
{
    if (!self.dataFieldFLXS || self.dataFieldFLXS.length == 0)
        [FLXSUIUtils raiseExceptionWithType:@"InvalidArgumentException"
                                 andMessage:@"Cannot set checked value if value field is not set"];
    _selectedValue=val;
    selectedValueDirty=YES;
    [self setNeedsDisplay];
}

-(NSObject*)selectedValue
{
    return selectedValueDirty?_selectedValue:
    (self.selectedItem&&[self.selectedItem
                         respondsToSelector:NSSelectorFromString(self.dataFieldFLXS)])?
            [self.selectedItem valueForKey:self.dataFieldFLXS] :self.selectedItem;
}
-(NSObject *)selectedItem {
    if(_selectedIndex == -1){
        return  nil;
    } else if(_selectedIndex>=0 && _selectedIndex< [self.dataProviderFLXS count]){
        return [_dataProviderFLXS objectAtIndex:_selectedIndex];
    }else{
        return nil;
    }
}

-(void)commitPropertiesAddAllItem
{
    if (addAllItemDirty)
    {
        addAllItemDirty=NO;
        NSArray* array=self.dataProviderFLXS;
        if (_addAllItem)
        {
            if ([self.dataProviderFLXS count]>0 && ![[[self dataProviderFLXS] objectAtIndex:0] isEqual:self.addAllItemText])
            {
                //Changed so all item does not affect the original collection, instead creates a new collection,
                //so original collection can be used elsewhere without the All ITem
                NSMutableArray* newArray = [[NSMutableArray alloc] init];
                for(NSObject* item in array)
                {
                    [newArray addObject:item];
                }
                NSObject* allItem=self.addAllItemText;
                [newArray insertObject:allItem atIndex:0];
                self.dataProviderFLXS =newArray;
            }
        }
        
    }
}



- (void)setActualSizeWithWidth:(float )width andHeight:(float)height {
    [super setActualSizeWithWidth:width andHeight:height];
    comboBoxButton.frame = self.bounds;
    comboBoxButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.bounds.size.width-30, 0, 0);
}
-(void)setAddAllItem:(BOOL)value
{
    _addAllItem=value;
    addAllItemDirty=YES;
    [self setNeedsDisplay];
}



-(void)drawRect:(CGRect)rect {
    [self commitPropertiesAddAllItem];
    [self commitPropertiesSelectedValue];
    [super drawRect:rect];
}


-(NSString*)text {
    return [comboBoxButton currentTitle];
}
-(void)setText:(NSString *)text {
    
    [comboBoxButton setTitle:text
                    forState:UIControlStateNormal];
}

-(void)setDataProviderFLXS:(NSArray*)value
{
    _dataProviderFLXS =value;
    if(self.addAllItem) //if dataprovider is updated after all item is added.
        self.addAllItem=YES;
    [self setNeedsDisplay];
}

-(void)setSelectedIndex:(int)value
{
    _selectedIndex = value;
    
    if(self.dataProviderFLXS.count>0){
        
        [comboBoxButton setTitle: value==-1?@"":self.addAllItem && value==0?self.addAllItemText:
         [[self.dataProviderFLXS objectAtIndex:value] respondsToSelector:NSSelectorFromString(self.dataFieldFLXS)]?
         [[[self.dataProviderFLXS objectAtIndex:value] valueForKey:self.dataFieldFLXS] description]:
         [[self.dataProviderFLXS objectAtIndex:value] description]
                        forState:UIControlStateNormal];
    }
    if(value==-1 && self.addAllItem){
        [comboBoxButton setTitle:self.addAllItemText forState:UIControlStateNormal];
    }
}


-(void)clear
{
    
    self.selectedIndex=(self.addAllItem
                        && [self.dataProviderFLXS count] >0
                        &&( (([[[self dataProviderFLXS] objectAtIndex:0] isKindOfClass:[NSString class]]) &&  [[self.dataProviderFLXS objectAtIndex:0] isEqualToString:self.addAllItemText ])
                           ||   ([[self.dataProviderFLXS objectAtIndex:0] respondsToSelector:NSSelectorFromString(self.dataFieldFLXS)] && [[[self.dataProviderFLXS objectAtIndex:0] valueForKey:self.dataFieldFLXS] isEqual:self.addAllItemText])
                           )
                        
                        )
    ?0:-1;
}

-(NSString*)getValue
{
    return self.selectedValue;
}

-(void)setValue:(NSString*)val
{
    self.selectedValue= [val description];
}
-(NSString *)itemToLabel:(NSObject *)item {
    if([item isKindOfClass:[NSString class]]){
        return [item description];
    }else if([item respondsToSelector:NSSelectorFromString(self.labelField)]){
        return [item valueForKey:self.labelField];
    }
    return nil;
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
    if(_filterControlInterface == nil)
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
    [FLXSUIUtils dispatchEvent:event
                    withSender:self];
}
//End FLXSIEventDispatcher methods
+ (NSString *)EVENT_CHANGE
{
    return [FLXSEvent EVENT_CHANGE];
}

#pragma mark - iPhone Bar Buttons Ok and Cancel Cliked...

-(void)cancelButtonPressed:(id)sender{
    if([FLXSUIUtils isIPad]){
        [self.popOverController dismissPopoverAnimated:YES];
        
    }  else{
        if(self.uiActionSheet){
            [self.uiActionSheet dismissWithClickedButtonIndex:0 animated:YES];
            _uiActionSheet=nil;
        }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        if(self.alertController){
            [self.alertController dismissViewControllerAnimated:YES completion:nil];
            _alertController = nil;
        }
#endif
    }
}
-(void)dealloc{
    popOverTable.delegate = nil;
    self.popOverController.delegate = self;
    _uiActionSheet.delegate=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
