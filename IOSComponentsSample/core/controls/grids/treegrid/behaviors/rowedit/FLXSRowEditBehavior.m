#import <QuartzCore/QuartzCore.h>
#import "FLXSRowEditBehavior.h"
#import "FLXSFlexDataGridEvent.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSScrollEvent.h"
#import "FLXSCellInfo.h"
#import "FLXSRowInfo.h"
#import "FLXSIFlexDataGridDataCell.h"
#import "FLXSFlexDataGridItemEditEvent.h"
#import "FLXSExtendedUIUtils.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGridDataCell.h"
#import "FLXSFlexDataGridBodyContainer.h"
#import "FLXSCellUtils.h"
#import "FLXSKeyboardEvent.h"
#import "UIScrollView+UIScrollViewAdditions.h"
#import <objc/message.h>

@implementation FLXSRowEditBehavior {
@private
    float _keyboardHeight;
    BOOL _keyboardHeightMoved;
}

@synthesize grid;
@synthesize currentEditCell;
@synthesize enabled;
@synthesize leftLockedContent;
@synthesize rightLockedContent;
@synthesize unlockedContent;
@synthesize buttonContainer;
@synthesize buttonRowHeight;
@synthesize padding;
@synthesize buttonContainerWidth;
@synthesize buttonContainerHeight;
@synthesize okButtonText;
@synthesize okButton;
@synthesize cancelButton;
@synthesize cancelButtonText;
@synthesize okButtonStyleName;
@synthesize cancelButtonStyleName;
@synthesize editorMap;
@synthesize currentEditCellInfo;
@synthesize itemEditorsValidatorFunction;
@synthesize itemEditorsCommitFunction;
@synthesize itemEditorsInitializeFunction;
@synthesize childrenDisabledForEdit;

@synthesize keyboardHeight = _keyboardHeight;
@synthesize keyboardHeightMoved = _keyboardHeightMoved;

-(id)initWithGrid:(FLXSFlexDataGrid*)gridIn
{
	self = [super init];
	if (self)
	{
		enabled = NO;
		buttonRowHeight = 40;
		padding = 10;
		buttonContainerWidth = 168;
		buttonContainerHeight = 30;
		okButtonText = @"Save";
		cancelButtonText = @"Cancel";
		okButtonStyleName = @"";
		cancelButtonStyleName = @"";
		itemEditorsValidatorFunction = nil;
		itemEditorsCommitFunction = nil;
		itemEditorsInitializeFunction = nil;
		childrenDisabledForEdit = [[NSMutableArray alloc] init];

		self.grid=gridIn;
		[self.grid addEventListenerOfType:[FLXSFlexDataGridEvent ITEM_EDIT_BEGINNING] usingTarget:self withHandler:@selector(onItemEditBeginning:)];
        [self.grid.bodyContainer addEventListenerOfType:[FLXSScrollEvent SCROLL] usingTarget:self withHandler:@selector(onGridScroll:)];
		[self.grid.leftLockedContent addEventListenerOfType:[FLXSScrollEvent SCROLL] usingTarget:self withHandler:@selector(endEdit:)];
		[self.grid.rightLockedContent addEventListenerOfType:[FLXSScrollEvent SCROLL] usingTarget:self withHandler:@selector(endEdit:)];


        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
	}
	return self;
}


-(void)onGridScroll:(NSNotification*)ns
{
//    FLXSScrollEvent* event = (FLXSScrollEvent*)[ns.userInfo objectForKey:@"event"];
    if(!self.grid.inMultiRowEdit)return;
	//if(event.direction==[FLXSScrollEventDetail HORIZONTAL])
	{
		self.unlockedContent.horizontalScrollPosition=self.grid.horizontalScrollPosition;
	}
//	else if(event.direction==[FLXSScrollEventDetail VERTICAL])
//	{
//		[self endEdit:event];
//	}

}

-(void)endEdit:(FLXSEvent*)event
{
	if(self.grid.inMultiRowEdit)
	{
		[self onItemEditEnd:event];
	}
}


-(void)setCurrentEditCell:(UIView<FLXSIFlexDataGridDataCell>*)value
{
	currentEditCell = value;
	if(value)
        self.currentEditCellInfo = [[FLXSCellInfo alloc] initWithRowData:value.rowInfo.data andColumn:value.columnFLXS];
}

-(void)onItemEditBeginning:(NSNotification*)ns
{
	if(!self.enabled)return;
    FLXSFlexDataGridItemEditEvent* event = (FLXSFlexDataGridItemEditEvent*) [ns.userInfo objectForKey:@"event"];
    [self onItemEditEnd:(FLXSEvent*)event];
 	[event preventDefault];
	//no default editors.
	self.currentEditCell=(UIView<FLXSIFlexDataGridDataCell>*)event.cellFLXS;
	grid.editCell=self.currentEditCell;
	//[self disableChildren:grid];
	self.leftLockedContent = self.leftLockedContent = [[UIView alloc] init];
    self.rightLockedContent = self.rightLockedContent = [[UIView alloc] init];
    self.unlockedContent = self.unlockedContent = [[UIScrollView alloc] init];
    //[self.unlockedContent setContentSize:CGSizeMake(self.grid.bodyContainer.contentSize.width, currentEditCell.height+buttonRowHeight)];
    //unlockedContent.horizontalScrollPolicy=@"off";
    self.buttonContainer =self.buttonContainer = [[UIView alloc] init];
	//buttonContainer.horizontalScrollPolicy=@"off";
	[self.buttonContainer setStyle:(@"textAlign") value:(@"center")];
	/*
			grid.leftLockedContent.tabIndex=1;
	grid.bodyContainer.tabIndex=2;
	grid.rightLockedContent.tabIndex=3;
	*/

    [leftLockedContent setActualSizeWithWidth:grid.leftLockedContent.frame.size.width andHeight:(currentEditCell.height + padding + padding)];
    [rightLockedContent setActualSizeWithWidth:grid.rightLockedContent.width andHeight:(currentEditCell.height + padding + padding)];
    [unlockedContent setActualSizeWithWidth:grid.bodyContainer.width andHeight:(currentEditCell.height + padding + padding)];
    [buttonContainer setActualSizeWithWidth:buttonContainerWidth andHeight:buttonContainerHeight];
    [leftLockedContent moveToX:grid.leftLockedContent.x y:(currentEditCell.y - padding - grid.verticalScrollPosition + grid.headerSectionHeight)];
    [rightLockedContent moveToX:grid.rightLockedContent.x y:(currentEditCell.y - padding - grid.verticalScrollPosition + grid.headerSectionHeight)];
    [unlockedContent moveToX:grid.bodyContainer.x y:(currentEditCell.y - padding - grid.verticalScrollPosition + grid.headerSectionHeight)];
    [buttonContainer moveToX:((grid.width / 2) - (buttonContainerWidth / 2)) y:(currentEditCell.y + currentEditCell.height - grid.verticalScrollPosition + grid.headerSectionHeight + 5)];
	okButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
	//okButton.titleLabel.text=self.okButtonText;
    [okButton setTitle:self.okButtonText forState:UIControlStateNormal];
    cancelButton= [UIButton buttonWithType:UIButtonTypeRoundedRect];
	//cancelButton.titleLabel.text=self.cancelButtonText;
    [cancelButton setTitle:self.cancelButtonText forState:UIControlStateNormal];


    [self addBorders:buttonContainer];
    [self addBorders:leftLockedContent];
    [self addBorders:rightLockedContent];
    [self addBorders:unlockedContent];

    [okButton sizeToFit];
    [cancelButton sizeToFit];


    [buttonContainer addChild:okButton];
	[buttonContainer addChild:cancelButton];
    [buttonContainer sizeToFit];
    [okButton addTarget:self action:@selector(onOkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[cancelButton addTarget:self action:@selector(onCancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [okButton moveToX:10 y:10];
    [cancelButton moveToX:okButton.width + 10 + 10 y:10];
    [buttonContainer setActualSizeWithWidth:okButton.width + cancelButton.width + 30 andHeight:buttonRowHeight + 20];

//	[okButton addEventListener:[KeyboardEvent KEY_UP] :onCellKeyUp];
//	[cancelButton addEventListener:[KeyboardEvent KEY_UP] :onCellKeyUp];

    [grid addChild:buttonContainer];
    [grid addChild:leftLockedContent];
	[grid addChild:unlockedContent];
	[grid addChild:rightLockedContent];
	NSArray* editColors=(NSArray*)[currentEditCell getStyleValue:@"editItemColors"] ;
    [FLXSExtendedUIUtils gradientFill:leftLockedContent colors:editColors paddingX:0 paddingY:0];
    [FLXSExtendedUIUtils gradientFill:rightLockedContent colors:editColors paddingX:0 paddingY:0];
    [FLXSExtendedUIUtils gradientFill:unlockedContent colors:editColors paddingX:0 paddingY:0];
    [FLXSExtendedUIUtils gradientFill:buttonContainer colors:([[editColors reverseObjectEnumerator] allObjects]) paddingX:0 paddingY:0];
	[self drawBorder:leftLockedContent cell:currentEditCell left:NO right:NO top:YES bottom:YES ];
	[self drawBorder:rightLockedContent cell:currentEditCell left:NO right:NO top:YES bottom:YES ];
	[self drawBorder:unlockedContent cell:currentEditCell left:NO right:NO top:YES bottom:YES ];
	[self drawBorder:buttonContainer cell:currentEditCell left:YES right:YES top:NO bottom:YES ];
	grid.inMultiRowEdit=YES;
	editorMap=[[NSMutableDictionary alloc]init];
    NSArray* cols = [[currentEditCell.level.leftLockedColumns arrayByAddingObjectsFromArray:currentEditCell.level.unLockedColumns ] arrayByAddingObjectsFromArray:currentEditCell.level.rightLockedColumns];
	//NSArray* cols=[currentEditCell.level.leftLockedColumns concat:currentEditCell.level.unLockedColumns concat:currentEditCell.level.rightLockedColumns];
	UIView* firstEditor;
	for(FLXSFlexDataGridColumn* col in cols)
	{
		FLXSFlexDataGridDataCell* cell = [[FLXSFlexDataGridDataCell alloc]init];
		cell.columnFLXS =col;
		cell.rowInfo=currentEditCell.rowInfo;
        cell.level=currentEditCell.level;
//		int tabIndex=0;
		if([self.grid isCellEditable:cell] && col.editable)
		{
			UIView* editor = [col.itemEditor generateInstance];
			[editorMap setObject:editor forKey:col.uniqueIdentifier];
            UIView* parent = col.isLeftLocked?leftLockedContent:col.isRightLocked?rightLockedContent:unlockedContent;
			[grid.bodyContainer initializeEditor:cell editor:editor pare:parent];
            [editor moveToX:col.x y:padding];
            //[editor addEventListener:[FLXSKeyboardEvent KEY_UP] :onCellKeyUp];
            [FLXSCellUtils setRendererSize:editor width:(col.width - 4) height:currentEditCell.height];
			if(!firstEditor || (col==currentEditCell.columnFLXS))
			{
				firstEditor = editor;
			}
		}
	}
//	if(!self.grid.forceColumnsToFitVisibleArea && self.grid.verticalScrollBar)
//	{
//		UIView* spacer = [[UIView alloc] init];;
//		[spacer setActualSize:self.grid.verticalScrollBar.width :self.currentEditCell.height];
//		[unlockedContent addChild:spacer];
//		[spacer move:(self.grid.bodyContainer.width+self.grid.bodyContainer.maxHorizontalScrollPosition-self.grid.verticalScrollBar.width) :0];
//	}
	if(self.itemEditorsInitializeFunction!=nil)
	{

        SEL selector = NSSelectorFromString(self.itemEditorsInitializeFunction);
        id target = self.grid.delegate;
        ((void(*)(id, SEL, NSMutableDictionary *))objc_msgSend)(target, selector,self.editorMap);
	}
	if(firstEditor)
	{
        [firstEditor becomeFirstResponder];
	}
	if(grid.horizontalScrollPosition>0)
	{
		[self.unlockedContent validateNow];
		self.unlockedContent.horizontalScrollPosition=grid.horizontalScrollPosition;
	}
}

- (void)addBorders:(UIView *)view {
    view.backgroundColor = [UIColor whiteColor];
    view.opaque = YES;
    view.layer.borderColor = [self.grid.horizontalGridLineColor CGColor];
    view.layer.borderWidth = self.grid.horizontalGridLineThickness;
    view.layer.cornerRadius = 5;

}

-(void)onCellKeyUp:(FLXSKeyboardEvent*)event
{
}

-(void)disableChildren:(UIView*)editorContainer
{
	int n = (int)[[editorContainer subviews ] count ];
	for (int i = 0; i < n; i++)
	{
		UIView* gridChid = (UIView*)[[editorContainer subviews] objectAtIndex:i];
		if(gridChid )
		{
			if(gridChid.userInteractionEnabled)
			{
				gridChid.userInteractionEnabled=NO;
				[self.childrenDisabledForEdit addObject:gridChid];
			}
		}
	}
}

-(void)onCancelButtonClick:(id)sender
{
    FLXSEvent * event = nil;
	FLXSFlexDataGridItemEditEvent* evt= [[FLXSFlexDataGridItemEditEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_EDIT_CANCEL] andGrid:grid andLevel:currentEditCellInfo.columnFLXS.level andColumn:currentEditCellInfo.columnFLXS andCell:currentEditCell andItem:currentEditCellInfo.rowData andTriggerEvent:event andBubbles:NO andCancelable:NO ];
	//evt.itemEditor=(UIView *)event.target;
	[currentEditCellInfo.columnFLXS dispatchEvent:evt];
	if(![evt isDefaultPrevented])
		[self onItemEditEnd:nil];
}

-(void)onOkButtonClick:(id)sender
{
    FLXSEvent * event = nil;
    if(self.itemEditorsValidatorFunction!=nil)
	{
        SEL selector = NSSelectorFromString(self.itemEditorsValidatorFunction);
        id target = self.grid.delegate;
        ((void(*)(id, SEL, NSMutableDictionary *))objc_msgSend)(target, selector,self.editorMap);
	}
	[self saveEditors:self.leftLockedContent];
	[self saveEditors:self.unlockedContent];
	[self saveEditors:self.rightLockedContent];
	if(self.itemEditorsCommitFunction!=nil)
	{
        SEL selector = NSSelectorFromString(self.itemEditorsCommitFunction);
        id target = self.grid.delegate;
        ((void(*)(id, SEL, NSMutableDictionary *))objc_msgSend)(target, selector,self.editorMap);
	}
	FLXSFlexDataGridItemEditEvent* evt= [[FLXSFlexDataGridItemEditEvent alloc] initWithType:[FLXSFlexDataGridEvent ITEM_EDIT_END] andGrid:grid andLevel:currentEditCellInfo.columnFLXS.level andColumn:currentEditCellInfo.columnFLXS andCell:currentEditCell andItem:currentEditCellInfo.rowData andTriggerEvent:event andBubbles:NO andCancelable:NO ];
	evt.itemEditor=(UIView*)event.target;
	[currentEditCellInfo.columnFLXS dispatchEvent:evt];
	for(FLXSRowInfo* row in self.grid.bodyContainer.rows)
	{
		if(row.rowPositionInfo.rowData==currentEditCellInfo.rowData)
		{
			[row refreshCells];
			[row invalidateCells];
			break;
		}
	}
	[self onItemEditEnd:nil];
}

-(void)saveEditors:(UIView*)editorContainer
{
	int n = (int)[[editorContainer subviews ]count ];
	FLXSRowInfo* currentEditRow=nil;
	for(FLXSRowInfo* row in self.grid.bodyContainer.rows)
	{
		if(row.rowPositionInfo.rowData==currentEditCellInfo.rowData)
		{
			currentEditRow=row;
			break;
		}
	}
	for (int i = 0; i < n; i++)
	{
		FLXSFlexDataGridColumn* column;
		UIView* editor =(UIView*) [[editorContainer subviews] objectAtIndex:i]; //as UIComponent;
		if (editor)
		{
			column = nil;
			for (NSString* uq in editorMap.allKeys)
			{
				if([editorMap objectForKey:uq] == editor)
				{
					column = [currentEditCellInfo.columnFLXS.level getColumnByUniqueIdentifier:uq];
					break;
				}
			}
			if(!column)continue;
			NSObject* lhs= [FLXSExtendedUIUtils resolveExpression:currentEditRow.data expression:column.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];

			NSObject* rhs=[editor respondsToSelector:NSSelectorFromString(column.editorDataField)]? [editor valueForKey:column.editorDataField]:nil;
			if(column.itemEditorManagesPersistence)
			{
			}
			else if(lhs==nil && [rhs isEqual:@""])
			{
				//self commonly happens if the pojo has a nil and the text input returns a blank string  when the user
				//does not make any change
			}
			else if(lhs!=rhs)
			{
				FLXSFlexDataGridDataCell* cell =[[FLXSFlexDataGridDataCell alloc] init];
				cell.columnFLXS =column;
				cell.rowInfo=currentEditRow;
				self.grid.editor=editor;
				self.grid.editCell=cell;
				[self.grid.bodyContainer populateValue:nil itemEditor:editor];
			}
		}
	}
}

- (void)drawBorder:(UIView *)sprite cell:(UIView <FLXSIFlexDataGridCell> *)cell left:(BOOL)left right:(BOOL)right top:(BOOL)top bottom:(BOOL)bottom {

    
//    if(top)
//	{
//		[sprite.graphics lineStyle:1 :[FLXSExtendedUIUtils getColorName:cell.horizontalGridLineColor]];
//		[sprite.graphics moveTo:0 :0];
//		[sprite.graphics lineTo:sprite.width :0];
//	}
//	if(bottom)
//	{
//		[sprite.graphics lineStyle:1 :[FLXSExtendedUIUtils getColorName:cell.horizontalGridLineColor]];
//		[sprite.graphics moveTo:0 :(sprite.height-1)];
//		[sprite.graphics lineTo:sprite.width :(sprite.height-1)];
//	}
//	if(left)
//	{
//		[sprite.graphics lineStyle:1 :[FLXSExtendedUIUtils getColorName:cell.verticalGridLineColor]];
//		[sprite.graphics moveTo:1 :0];
//		[sprite.graphics lineTo:1 :(sprite.height-1)];
//	}
//	if(right)
//	{
//		[sprite.graphics lineStyle:1 :[FLXSExtendedUIUtils getColorName:cell.verticalGridLineColor]];
//		[sprite.graphics moveTo:(sprite.width-1) :0];
//		[sprite.graphics lineTo:(sprite.width-1) :(sprite.height-1)];
//	}
}

-(void)onItemEditEnd:(FLXSEvent*)event
{
    [self.grid invalidateCells];
    [self.grid becomeFirstResponder];
//	for (NSString* key in self.editorMap.allKeys)
//	{
//		self.editorMap[key[] removeEventListener:[FLXSKeyboardEvent KEY_UP] :onCellKeyUp];
//	}
//	if(self.okButton)
//		[self.okButton removeEventListener:[FLXSKeyboardEvent KEY_UP] :onCellKeyUp];
//	if(self.cancelButton)
//		[self.cancelButton removeEventListener:[FLXSKeyboardEvent KEY_UP] :onCellKeyUp];
	self.okButton=nil;
	self.cancelButton=nil;
	for(UIView* uiComp in self.childrenDisabledForEdit)
	{
		uiComp.userInteractionEnabled=YES;
        uiComp.hidden = NO;
	}
	self.childrenDisabledForEdit= [[NSMutableArray alloc] init];
	editorMap=[[NSMutableDictionary alloc]init];
	self.currentEditCell=nil;
	if(self.leftLockedContent)
	{
        [self.leftLockedContent removeFromSuperview];
		self.leftLockedContent=nil;
	}
	if(self.rightLockedContent)
	{
        [self.rightLockedContent removeFromSuperview];
		self.rightLockedContent=nil;
	}
	if(self.unlockedContent)
	{
		[self.unlockedContent removeFromSuperview];
		//[self.unlockedContent removeEventListener:[FLXSKeyboardEvent KEY_UP] :onCellKeyUp];
		self.unlockedContent=nil;
	}
	if(self.buttonContainer)
	{
		[self.buttonContainer removeFromSuperview];
		self.buttonContainer=nil;
	}
	self.grid.inMultiRowEdit=NO;
	self.grid.editCell=nil;
}

-(void)keyboardWillShow :(NSNotification *)n
{
    // Animate the current view out of the way
    NSDictionary* info = [n userInfo];
    UIWindow *window = [FLXSUIUtils getTopLevelWindow];
    UIView *rootView=window.rootViewController.view;
    CGSize keyboardSize=[[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if (UIInterfaceOrientationIsLandscape(window.rootViewController.interfaceOrientation)) {
        self.keyboardHeight =  keyboardSize.width;
        self.keyboardHeight = 612;
    }
    else {
        self.keyboardHeight =  keyboardSize.height;
    }
    CGPoint buttonOrigin=[self.buttonContainer convertPoint:self.buttonContainer.bounds.origin
                                toView:rootView];


    if ((buttonOrigin.y + buttonContainer.height+self.keyboardHeight) >=  rootView.height)
    {
        self.keyboardHeight=  buttonOrigin.y-  (rootView.height-buttonContainer.height-self.keyboardHeight);
        [self setViewMovedUp:YES];
        self.keyboardHeightMoved=YES;
    }
    else{
        self.keyboardHeightMoved=NO;
    }
}

-(void)keyboardWillHide {
    if (self.keyboardHeightMoved)

    {
        [self setViewMovedUp:NO];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    [self moveView:movedUp view:self.unlockedContent];
    [self moveView:movedUp view:self.leftLockedContent];
    [self moveView:movedUp view:self.rightLockedContent];
    [self moveView:movedUp view:self.buttonContainer];

    [UIView commitAnimations];
}

- (void)moveView:(BOOL)movedUp view:(UIView *)view {
    CGRect rect = view.frame;
    if (movedUp)
    {
        rect.origin.y -= self.keyboardHeight;
       // rect.size.height += self.keyboardHeight;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += self.keyboardHeight;
        //rect.size.height -= self.keyboardHeight;
    }
    view.frame = rect;
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

