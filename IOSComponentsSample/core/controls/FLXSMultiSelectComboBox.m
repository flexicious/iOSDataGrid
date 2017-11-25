#import "FLXSMultiSelectComboBox.h"
#import "FLXSCheckBoxList.h"
#import "UIView+UIViewAdditions.h"

#define defaultNavTitle @"Select an Option"


@implementation FLXSMultiSelectComboBox{
@protected
    UIButton *_comboBoxButton;
    UIBarButtonItem *_btnOk;
    UIBarButtonItem *_btnCancel;
    
    bool _dispatched;
    bool _valueDirty;
    NSArray * _value;
    bool _labelDirty;
    UINavigationItem *_navItem;
}

@synthesize previousSelectedValues = _previousSelectedValues;
@synthesize cbList;
@synthesize searchBox;
@synthesize dropDownWidth=_dropDownWidth;
@synthesize addOkCancel;
@synthesize buttonOkLabel;
@synthesize buttonCancelLabel;
@synthesize addSearchBox;
@synthesize searchBoxWatermark;
@synthesize alignRightEdgeOfPopup;
@synthesize labelMaxLength;

@synthesize popOverController = _popOverController;
@synthesize uiActionSheet;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
@synthesize alertController;
#endif

@synthesize pickerTitle;
- (id)init
{
    self = [super init];
    if (self) {
        [self   _init];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self   _init];
    }
    return self;
}

-(void) _init{
    _comboBoxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_comboBoxButton addTarget:self
                        action:@selector(comboBoxButtonClicked:)
              forControlEvents:UIControlEventTouchUpInside];
    [_comboBoxButton setTitle:@"All" forState:UIControlStateNormal];
    _comboBoxButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [_comboBoxButton setImage:[UIImage imageNamed:@"FLXSAPPLE_dropdown.png"] forState:UIControlStateNormal];
    [_comboBoxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _comboBoxButton.frame = self.bounds;
    _comboBoxButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.bounds.size.width-30, 0, 0);
    [_comboBoxButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 30)];
    
    self.userInteractionEnabled = YES;
    _comboBoxButton.userInteractionEnabled = YES;
    self.labelField=@"label";
    self.dataFieldFLXS =@"data";
    self.addAllItem = NO;
    self.addAllItemText = FLXSFilter.ALL_ITEM;
    self.hasSearch = NO;
    self.rowHeight = 0;
    self.opaque = NO;
    
    
    [self addSubview:_comboBoxButton];
    self.previousSelectedValues = nil;
    cbList = [[FLXSCheckBoxList alloc] init];
    _dispatched = NO;
    searchBox = [[UITextView alloc] init];
    _valueDirty = NO;
    _labelDirty = NO;
    _dropDownWidth = 0;
    addOkCancel = YES;
    buttonOkLabel = @"OK";
    buttonCancelLabel = @"Cancel";
    addSearchBox = NO;
    searchBoxWatermark = @"Search";
    alignRightEdgeOfPopup = NO;
    labelMaxLength = 500;
    
    [cbList addEventListenerOfType:[FLXSCheckBoxList EVENT_CHANGE] usingTarget:self withHandler:@selector(onCbValueCommit:)];
    
    [self setLabel];
    //    if(_dropDownWidth)
    //    {
    //        cbList.frame= CGRectMake(cbList.frame.origin.x,cbList.frame.origin.y, _dropDownWidth, cbList.frame.size.height);
    //    }
    
    if(addSearchBox)
        [self createSearchBox];
    
    self.layer.cornerRadius = 4.0;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0f;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self   _init];
    }
    return self;
    
}

- (void)comboBoxButtonClicked:(id)comboBoxButtonClicked {
    
    //Nav bar
    UINavigationBar *navBar = [[UINavigationBar alloc]init];
    //[navBar setBarStyle:UIBarStyleDefault];
    _navItem = [[UINavigationItem alloc] init];
    if (pickerTitle ==nil) {
        pickerTitle  = defaultNavTitle;
    }
    [_navItem  setTitle:pickerTitle];
    _btnOk = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:self action:@selector(btnOkPressed:)];
    _btnCancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(btnCancelPressed:)];
    _navItem.rightBarButtonItem = _btnCancel;
    _navItem.leftBarButtonItem = _btnOk;
    [navBar pushNavigationItem:_navItem animated:NO];
    
    if([FLXSUIUtils isIPad]){
        if (self.popOverController== nil || self.popOverController.isPopoverVisible== NO)
        {
            UIViewController *myController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
            UIView *masterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,300)];
            myController.view = masterView;
            myController.preferredContentSize = masterView.frame.size;
            
            [masterView addSubview:cbList];
            myController.contentSizeForViewInPopover = myController.view.frame.size;
            cbList.frame = myController.view.frame;
            CGRect frame = cbList.frame;
            frame.origin.y = frame.origin.y +44;
            frame.size.height = frame.size.height -44;
            cbList.frame=frame;
            
            self.popOverController = [[UIPopoverController alloc] initWithContentViewController:myController];
            [navBar  setFrame:CGRectMake(0,0, 300, 44)];
            [masterView addSubview:navBar   ];
            
            self.popOverController.delegate = self;
            [self.popOverController presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            [self onItemOpen:nil];
        }
        else
        {
            [self.popOverController dismissPopoverAnimated: YES];
            self.popOverController = nil;
        }
        
    }   else{
        
        if(uiActionSheet ){
            [uiActionSheet dismissWithClickedButtonIndex:0 animated:YES];
            uiActionSheet = nil;
        }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        else if(alertController){
            [alertController dismissViewControllerAnimated:YES completion:nil];
            alertController = nil;
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
            
            UIView *masterView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, width,301)];
            [masterView addSubview:cbList];
            
            //UIActionsheet depcrecated in IOS8
            if([FLXSUIUtils isRunningIOS8OrGreater]){
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
                alertController = [UIAlertController alertControllerWithTitle:@"Select" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                
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
                
                UIAlertAction *done = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self.alertController dismissViewControllerAnimated:YES completion:nil];
                }];
                
                [self.alertController addAction:one];
                [self.alertController addAction:two];
                [self.alertController addAction:three];
                [self.alertController addAction:four];
                [self.alertController addAction:done];
                masterView.frame = CGRectMake(0, 20, width-15, 240);
                cbList.frame = masterView.frame;
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
                uiActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select"
                                                            delegate:self
                                                   cancelButtonTitle:@"Done"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"1",@"2",@"3",@"4",nil];
                
                uiActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
                
                [uiActionSheet setFrame:CGRectMake(0, 0, width, 300)];
                cbList.frame =                                   CGRectMake(0, 0, width, 300);
                [uiActionSheet addSubview:masterView];
                [navBar  setFrame:CGRectMake(0,0, width, 44)];
                [uiActionSheet addSubview:navBar   ];
                [uiActionSheet showInView:self.superview];
            }
            [self onItemOpen:nil];
        }
        
        /*if(uiActionSheet == nil){
         uiActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select"
         delegate:self
         cancelButtonTitle:@"Done"
         destructiveButtonTitle:nil
         otherButtonTitles:@"1",@"2",@"3",@"4",nil];
         
         uiActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
         
         UIView *masterView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320,301)];
         [masterView addSubview:cbList];
         [uiActionSheet setFrame:CGRectMake(0, 0, 320, 300)];
         cbList.frame =                                   CGRectMake(0, 0, 320, 300);
         [uiActionSheet addSubview:masterView];
         [navBar  setFrame:CGRectMake(0,0, 320, 44)];
         [uiActionSheet addSubview:navBar   ];
         [uiActionSheet showInView:self.superview];
         [self onItemOpen:nil];
         
         
         }else{
         [uiActionSheet dismissWithClickedButtonIndex:0 animated:YES];
         uiActionSheet = nil;
         }*/
    }
    
}
- (void)setActualSizeWithWidth:(float )width andHeight:(float)height {
    [super setActualSizeWithWidth:width andHeight:height];
    _comboBoxButton.frame = self.bounds;
    _comboBoxButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.bounds.size.width-30, 0, 0);
    _comboBoxButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 30 );
}
-(void)dealloc {
    [cbList removeEventListenerOfType:[FLXSCheckBoxList EVENT_CHANGE] fromTarget:self usingHandler:@selector(onCbValueCommit:)];
}
-(void)onCbValueCommit:(FLXSEvent*)event
{
    _btnOk.enabled= [cbList.selectedItems count] >0;
    //[self setLabel];
}

-(NSString*)itemToLabel:(NSObject*)item
{
	return [cbList itemToLabel:item];
}


-(NSString*)itemToData:(NSObject*)item
{
    return [cbList itemToData:item];
}

- (BOOL) isItemSelected:(NSObject *)item
{
    return [cbList isItemSelected:item];
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
}

-(void)close
{
    
	if((self.previousSelectedValues==nil && cbList.selectedItems && cbList.selectedItems.count>0)||
       ((self.previousSelectedValues &&![FLXSUIUtils areArraysEqual:self.previousSelectedValues array2:cbList.selectedItems]) && !_dispatched))
	{
		_dispatched=YES;
		if([cbList.selectedItems count] >0)
		{
            [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSCheckBoxList EVENT_CHANGE]
                                                  andCancelable:false
                                                     andBubbles:false] ];
		}
	}
	_previousSelectedValues =nil;
    [self setLabel];
    
    if([FLXSUIUtils isIPad]){
        [self.popOverController dismissPopoverAnimated:YES];
        
    }  else{
        if(self.uiActionSheet)
            [self.uiActionSheet dismissWithClickedButtonIndex:0 animated:YES];
        self.uiActionSheet=nil;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        if(self.alertController)
            [self.alertController dismissViewControllerAnimated:YES completion:nil];
        self.alertController = nil;
        
#endif
    }
    
    
}

-(void)onItemOpen:(FLXSEvent*)event
{
 	_dispatched=NO;
	_previousSelectedValues = cbList.selectedValues;
    
    //    if(self.dropDownWidth)
    //        cbList.frame= CGRectMake(cbList.frame.origin.x,cbList.frame.origin.y, self.dropDownWidth, cbList.frame.size.height);
	if(alignRightEdgeOfPopup)
	{
        //Popover controller should handle this for us.
        //		Point* pt=[[Point alloc] init:0 :height];
        //		pt=[self localToGlobal:pt];
        //		[popUp move:(pt.x-popUp.width+width) :(pt.y+2)]
        
    }
    [cbList reloadData];
}


-(void)createSearchBox
{
    
    //next version - v 1.2
    //	HBox* box = popUp as HBox;
    //	[box setStyle:(@"verticalGap") :0];
    //	FLXSCheckBoxList* cbList = [box getChildAt:0] as FLXSCheckBoxList;
    //	box.layoutObject.direction = [BoxDirection VERTICAL];
    //	//make it a vbox
    //	[box addChildAt:searchBox :0];
    //	if([self getStyle:(@"filterIcon")])
    //		[searchBox setStyle:(@"insideIcon") :([self getStyle:(@"filterIcon")])];
    //	searchBox.styleName = [self getStyle:(@"searchBoxStyleName")]
    //searchBox.watermark = self.searchBoxWatermark;
    //	searchBox.clearTextOnIconClick=YES;
    //	searchBox.showIconWhenHasText=YES;
    //	[searchBox addEventListener:(@"delayedChange") :self.onSearchBoxChange];
}

-(void)onSearchBoxChange:(FLXSEvent*)event
{
    //next version - v 1.2
    
    //	if(cbList.dataProviderFLXS.filterFunction==nil)
    //	{
    //		cbList.dataProviderFLXS.filterFunction=filterByText;
    //	}
    //	cbList.hasSearch=searchBox.text.length>0;
    //	[cbList.dataProviderFLXS refresh];
    //	cbList.selectedItems= [[NSMutableArray alloc] init]
}

-(BOOL)filterByText:(NSObject*)item
{
    //next version - v 1.2
    
    //	if(item.label==self.addAllItemText)
    //	{
    //		return YES;
    //	}
    //	else if(item.label)
    //	{
    //		[return item.label toLowerCase[] indexOf:([self.searchBox.text toLowerCase])]==0;
    //	}
	return YES;
}

-(void )btnOkPressed:(id )sender{
    [self close];
}


-(void)btnCancelPressed:(id)sender
{
	if(searchBox.text.length>0)
	{
		searchBox.text=@"";
	}
	if(_previousSelectedValues !=nil)
		cbList.selectedItems= [_previousSelectedValues mutableCopy];
    else
        [cbList clear];
    
    if([FLXSUIUtils isIPad]){
        [self.popOverController dismissPopoverAnimated:YES];
        
    }  else{
        if(self.uiActionSheet)
            [self.uiActionSheet dismissWithClickedButtonIndex:0 animated:YES];
        self.uiActionSheet=nil;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        if(self.alertController)
            [self.alertController dismissViewControllerAnimated:YES completion:nil];
        self.alertController = nil;
        
#endif
    }
    
}

-(void)setLabel
{
	if(cbList.isAllSelected && cbList.addAllItem &&!cbList.hasSearch)
	{
        [_comboBoxButton setTitle:cbList.addAllItemText
                         forState:UIControlStateNormal];
	}
    else if(cbList.selectedValues == nil){
        [_comboBoxButton setTitle:cbList.addAllItemText
                         forState:UIControlStateNormal];
    }
	else
	{
        
		NSMutableArray* labels = [[NSMutableArray alloc] init];
		for(int i = 0; i< [cbList.selectedItems count]; i++)
		{
			[labels addObject:([self itemToLabel:(cbList.selectedItems[i])])];
		}
        [labels sortUsingSelector:@selector(compare:)];
        NSString * lbl=@"";
        lbl = [labels componentsJoinedByString:@","];
        if(self.labelMaxLength >-1 && lbl.length>self.labelMaxLength )
		{
            lbl = [lbl substringToIndex:self.labelMaxLength];
        }
        [_comboBoxButton setTitle:lbl
                         forState:UIControlStateNormal];
    }
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if([self.dataProviderFLXS count]==0){
        return;
    }
    if(_valueDirty)
    {
        _valueDirty=NO;
        [cbList setValue:_value];
    }
    if(_labelDirty)
    {
        _labelDirty = NO;
        
        [self setLabel];
    }
    //if(!_dropDownWidth)
    {
        cbList.frame= CGRectMake(cbList.frame.origin.x,cbList.frame.origin.y, self.frame.size.width,cbList.frame.size.height);
    }
    //    else if(cbList.frame.size.width!=_dropDownWidth)
    //        cbList.frame= CGRectMake(cbList.frame.origin.x,cbList.frame.origin.y, _dropDownWidth,cbList.frame.size.height);
}

-(NSString*)labelField
{
	return cbList.labelField;
}

-(void)setLabelField:(NSString*)o
{
	cbList.labelField = o;
}

-(NSString*)dataFieldFLXS
{
	return cbList.dataFieldFLXS;
}

-(void)setDataFieldFLXS:(NSString*)o
{
	cbList.dataFieldFLXS = o;
}

-(NSMutableArray*)selectedItems
{
	return cbList.selectedItems;
}

-(void)setSelectedItems:(NSMutableArray*)items
{
	cbList.selectedItems = items;
	_labelDirty=YES;
	[self setNeedsDisplay];
}

-(NSMutableArray*)selectedValues
{
	return cbList.selectedValues;
}

-(void)setSelectedValues:(NSMutableArray*)items
{
	cbList.selectedValues = items;
	_labelDirty=YES;
    [self setNeedsDisplay];
}

-(BOOL)addAllItem
{
	return cbList.addAllItem;
}

-(void)setAddAllItem:(BOOL)value
{
	cbList.addAllItem = value;
	_labelDirty=YES;
    [self setNeedsDisplay];
}

-(NSString*)addAllItemText
{
	return cbList.addAllItemText;
}

-(void)setAddAllItemText:(NSString*)value
{
	cbList.addAllItemText = value;
	_labelDirty=YES;
    [self setNeedsDisplay];
}

-(NSArray*)dataProviderFLXS
{
	return cbList.dataProviderFLXS;
}

-(void)setDataProviderFLXS:(NSArray*)value
{
	cbList.dataProviderFLXS = value;
	_labelDirty=YES;
    [self setNeedsDisplay];
}


-(void)clear
{
	[cbList clear];
    _labelDirty=YES;
    [self setNeedsDisplay];
    //next version v1.2
    //	if(self.addAllItem)
    //	{
    //		/*[cbList validateNow];
    //		*/
    ///*if(dataProviderFLXS.length>0)
    //				selectedItems=[dataProviderFLXS[0]];
    //		*/
    //if(searchBox && addSearchBox)
    //		{
    //			searchBox.text=@"";
    //			if(cbList && cbList.dataProviderFLXS)
    //			{
    //				cbList.dataProviderFLXS.filterFunction=nil;
    //				cbList.hasSearch=NO;
    //				[cbList.dataProviderFLXS refresh];
    //			}
    //		}
    //	}
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"clear")])];
}

-(NSObject*)getValue
{
	return _valueDirty?_value:[cbList getValue];
}

-(void)setValue:(NSArray*)val
{
	_valueDirty=YES;
	_value=val;
	_labelDirty=YES;
	[self setNeedsDisplay];
}


-(BOOL)isAllSelected
{
	return cbList.isAllSelected;
}

//FLXSIFilterControl Methods

-(NSString*)searchField
{
    return self.cbList.searchField;
}

-(void)setSearchField:(NSString*)o
{
    self.cbList.searchField = o;
}

-(NSObject <FLXSIExtendedDataGrid>*)grid
{
    return self.cbList.grid;
}

-(void)setGrid:(NSObject <FLXSIExtendedDataGrid>*)o
{
    self.cbList.grid = o;
}

-(NSObject <FLXSIDataGridFilterColumn>*)gridColumn
{
    return self.cbList.gridColumn;
}

-(void)setGridColumn:(NSObject <FLXSIDataGridFilterColumn>*)o
{
    self.cbList.gridColumn = o;
}

-(NSString*)filterOperation
{
    return self.cbList.filterOperation;
}

-(void)setFilterOperation:(NSString*)o
{
    self.cbList.filterOperation= o;
}

-(NSString*)filterComparisonType
{
    return self.cbList.filterComparisonType;
}

-(void)setFilterComparisonType:(NSString*)o
{
    self.cbList.filterComparisonType= o;
}

-(FLXSFilterControlImpl *)filterControlInterface
{
    return self.cbList.filterControlInterface;
}

-(NSString*)filterTriggerEvent
{
    return self.cbList.filterTriggerEvent;
}

-(void)setFilterTriggerEvent:(NSString*)o
{
    self.cbList.filterTriggerEvent = o;
}

-(BOOL)autoRegister
{
    return self.cbList.autoRegister;
}

-(void)setAutoRegister:(BOOL)value
{
    self.cbList.autoRegister = value;
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
@end

