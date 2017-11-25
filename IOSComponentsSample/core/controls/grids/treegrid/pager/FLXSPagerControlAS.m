#import "FLXSPagerControlAS.h"
#import "FLXSExtendedFilterPageSortChangeEvent.h"
#import "FLXSFlexDataGridEvent.h"
#import "FLXSToolbarAction.h"
#import "UIView+UIViewAdditions.h"
#import "FLXSConstants.h"
#import "FLXSRowInfo.h"
#import "FLXSStyleManager.h"
#import "FLXSFontInfo.h"
#import "FLXSLabelData.h"
#import "FLXSExtendedExportController.h"

@class FLXSFlexDataGrid;


static UIImage* _toolbarActionIcon; 
@implementation FLXSPagerControlAS {

}


@synthesize totalRecords = _totalRecords;
@synthesize pageSize = _pageSize;
@synthesize pageIndex = _pageIndex;
@synthesize pagerPosition = _pagerPosition;
@synthesize level = _level;
@synthesize grid = _grid;
@synthesize rowInfo = _rowInfo;
@synthesize pageDropdownDirty = _pageDropdownDirty;
@synthesize popMenu = _popMenu;
@synthesize lblPaging = _lblPaging;
@synthesize BTN_FIRST_PAGE = _BTN_FIRST_PAGE;
@synthesize BTN_PREV_PAGE = _BTN_PREV_PAGE;
@synthesize BTN_NEXT_PAGE = _BTN_NEXT_PAGE;
@synthesize BTN_LAST_PAGE = _BTN_LAST_PAGE;
@synthesize lblGotoPage = _lblGotoPage;
@synthesize cbxPage = _cbxPage;
@synthesize hboxToolbar = _hboxToolbar;
@synthesize BTN_MCS = _BTN_MCS;
@synthesize BTN_EXP_ONE_DOWN = _BTN_EXP_ONE_DOWN;
@synthesize BTN_EXP_ONE_UP = _BTN_EXP_ONE_UP;
@synthesize BTN_EXP_ALL = _BTN_EXP_ALL;
@synthesize BTN_COLLAPSE_ALL = _BTN_COLLAPSE_ALL;
@synthesize BTN_PREFERENCES = _BTN_PREFERENCES;
@synthesize BTN_SAVE_PREFS = _BTN_SAVE_PREFS;
@synthesize BTN_OPEN_PREFS = _BTN_OPEN_PREFS;
@synthesize BTN_FOOTER = _BTN_FOOTER;
@synthesize BTN_FILTER = _BTN_FILTER;
@synthesize BTN_RUN_FILTER = _BTN_RUN_FILTER;
@synthesize BTN_CLEAR_FILTER = _BTN_CLEAR_FILTER;
@synthesize BTN_PRINT = _BTN_PRINT;
@synthesize BTN_PDF = _BTN_PDF;
@synthesize BTN_WORD = _BTN_WORD;
@synthesize BTN_EXCEL = _BTN_EXCEL;
@synthesize built = _built;
@synthesize levelDepth = _levelDepth;
@synthesize separatorFactory = _separatorFactory;
@synthesize dispatchEvents = _dispatchEvents;
@synthesize actionsWidthInvalid = _actionsWidthInvalid; 
@synthesize padding;
-(id)init
{
	self = [super init];
	if (self)
	{

        [self   initView];
	}
	return self;

}

-(id)initWithFrame:(CGRect)frame
{
    self = [super   initWithFrame:frame];
    if (self) {
        [self       initView];
    }
    return self;
}


-(void)initView{



    _totalRecords = 0;
    _pageSize = 50;
    _pageIndex = 0;
    _pagerPosition = @"middle";
    _pageDropdownDirty = NO;
    self.built = NO;
    _dispatchEvents = YES;
    _actionsWidthInvalid = NO;
    self.opaque=NO;
    padding  = [FLXSUIUtils isIPad]?3:4;
    self.backgroundColor = [UIColor clearColor];
}

-(void)popupButton_openHandler:(FLXSEvent*)event
{
    //next version   v1.2
//	PopUpButton* popupButton = event.currentTarget as PopUpButton;
//	ToolbarAction* action = nestedGrid.toolbarActions[[popupButton.parent getChildIndex:popupButton]];
//	[self initializeMenu:action];
}

-(void)onImgFirstClick
{
	{
		_pageIndex = 0;
		[self onPageChanged];
	}
}

-(void)onImgPreviousClick
{
	if(_pageIndex > 0)
	{
		_pageIndex--;
		[self onPageChanged];
	}
}

-(void)onImgNextClick
{
	if(_pageIndex < self.pageCount-1)
	{
		_pageIndex++;
		[self onPageChanged];
	}

}

-(void)onImgLastClick
{
	if(_pageIndex < self.pageCount-1)
	{
		_pageIndex = self.pageCount-1;
		[self onPageChanged];
	}
}

-(void)onPageCbxChange
{
    _pageIndex = self.cbxPage.selectedIndex;
	[self onPageChanged];
}

-(void)onPageChanged
{
	if(self.cbxPage && (self.cbxPage.selectedIndex != (_pageIndex)))
	{
        self.cbxPage.selectedIndex=_pageIndex;
	}
	if(self.dispatchEvents)
		[self dispatchEvent:([[FLXSExtendedFilterPageSortChangeEvent alloc] initWithType:[FLXSExtendedFilterPageSortChangeEvent PAGE_CHANGE]])];
}

-(void)onCreationComplete:(FLXSEvent*)event
{//next version   v1.2
//	if(self.nestedGrid.enableToolbarActions)
//	{
//		[nestedGrid.toolbarActions addEventListener:[CollectionEvent COLLECTION_CHANGE] :onToolbarActionsChanged];
//		[nestedGrid addEventListener:[FLXSFlexDataGridEvent CHANGE] :onGridSelectionChange];
//		[self createToolbarActions];
//	}
}

-(void)reset
{
    _pageIndex=0;
    self.cbxPage.selectedIndex=0;
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:@"reset" andCancelable:NO andBubbles:NO
            ])];
}

-(int)pageStart
{
	return _totalRecords==0?0:((_pageIndex)*_pageSize)+1;
}

-(int)pageEnd
{
	int val= (_pageIndex+1)*_pageSize;
	return (val>_totalRecords)?_totalRecords:val;
}


-(void)setPageIndex:(int)val
{
	if(_pageIndex != val)
	{
		_pageIndex = val;
		[self onPageChanged];
		[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"pageIndexChanged")])];
	}
}

-(int)pageCount
{
	return self.pageSize>0?(self.totalRecords/self.pageSize)+(self.totalRecords%self.pageSize==0?0:1):0;
}

-(void)setTotalRecords:(int)val
{
	if(val!=_totalRecords)
	{
		_pageDropdownDirty=YES;
		[self setNeedsDisplay];
	}
	_totalRecords = val;
	self.pageIndex=0;
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"reset")])];
}


-(FLXSFlexDataGrid*)grid
{
	return _grid;
}

-(void)grid:(FLXSFlexDataGrid*)val
{
	_grid = val;
 	if(_grid){
		//[_grid addEventListener:[FLXSFlexDataGridEvent CHANGE] :self :@selector(enableDisableToolbarButtons:)];
    }
}

-(FLXSFlexDataGrid*)nestedGrid
{
	return _grid;
}

-(void)onWordExport
{
	[self.nestedGrid defaultWordHandlerFunction];
}

-(void)onExcelExport
{
    [self.nestedGrid defaultExcelHandlerFunction];
}

-(void)onPrint
{
    [self.nestedGrid defaultPrintHandlerFunction];
}

-(void)onPdf
{
    [self.nestedGrid defaultPdfHandlerFunction];
}
-(void) onExpandOne{
    if([self.nestedGrid canExpandDown])
        [self.nestedGrid expandDown];
}
-(void) onExpandAll{
    [self.nestedGrid expandAll];
}
-(void) onCollapseOne{
    if([self.nestedGrid canExpandUp]){
        [self.nestedGrid expandUp];
    }
}

-(void) onCollapseAll{
    [self.nestedGrid collapseAll];
}
-(void) onMultiColmnSort{

//    if (popMultiColumnSortVc== nil) {
//        if (multiColumnSortVC ==nil) {
//            multiColumnSortVC = [[FLXSMultiColumnSortViewController alloc] initWithNibName:@"FLXSMultiColumnSortViewController" bundle:nil];
//        }
//        popMultiColumnSortVc = [[UIPopoverController    alloc] initWithContentViewController:multiColumnSortVC];
//    }
//    [popMultiColumnSortVc setPopoverContentSize:CGSizeMake(multiColumnSortVC.view.frame.size.width, multiColumnSortVC.view.frame.size.height)];
//    [popMultiColumnSortVc presentPopoverFromRect:self.BTN_MCS.frame inView:self.nestedGrid permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [self.nestedGrid multiColumnSortShowPopup];
}

-(void)onClearFilter
{
    [self.grid clearFilter];
}

-(void)onProcessFilter
{
	[self.grid processFilter];
}

-(void)onShowHideFilter
{
	self.grid.filterVisible=!self.grid.filterVisible;
}

-(void)onShowHideFooter
{
	self.grid.footerVisible=!self.grid.footerVisible;
}

-(void)onShowSettingsPopup
{
	NSObject* popup=[self.nestedGrid.popupFactorySettingsPopup generateInstance];
    [FLXSUIUtils addPopUpController:(UIViewController *)popup parent:self.grid modal:YES ];
    if([popup respondsToSelector:NSSelectorFromString(@"grid")]){
        [popup setValue:self.grid forKey:@"grid"];
    }
}

-(void)onSaveSettingsPopup
{
    NSObject* popup=[self.nestedGrid.popupFactorySaveSettingsPopup generateInstance];
    [FLXSUIUtils addPopUpController:(UIViewController *)popup parent:self.grid modal:YES ];
    if([popup respondsToSelector:NSSelectorFromString(@"grid")]){
        [popup setValue:self.grid forKey:@"grid"];
    }
}

-(void)onOpenSettingsPopup
{
//	NSObject* popup=[nestedGrid.popupFactoryOpenSettingsPopup generateInstance];
//	[FLXSUIUtils addPopUp:popup as IFlexDisplayObject :grid as DisplayObject :YES :nil :nil :(self.grid.useModuleFactory?grid.moduleFactory:nil)];
//	popup.grid=grid;
}

-(void)createToolbarActions
{
	[self setToolbarActions];
}

-(void)onToolbarActionsChanged:(FLXSEvent*)event
{
	[self createToolbarActions];
}

-(void)onGridSelectionChange:(FLXSFlexDataGridEvent*)event
{
	[self enableDisableToolbarButtons];
}

-(BOOL)toolbarActionFilterFunction:(FLXSToolbarAction*)item
{
	return item.level==self.level.nestDepth || item.level==-1;
}

-(void)onToolbarButtonClick:(FLXSEvent*)event
{
//	ToolbarAction* action=nestedGrid.toolbarActions[[event.currentTarget.parent getChildIndex:event.currentTarget]];
//	[nestedGrid runToolbarAction:action :event.currentTarget :self];
}

-(void)popupButton_clickHandler:(FLXSEvent*)event
{
//	[self onToolbarButtonClick:event]
//PopUpButton* popupButton = event.currentTarget as PopUpButton;
//	ToolbarAction* action = nestedGrid.toolbarActions[[popupButton.parent getChildIndex:popupButton]];
//	if(!action.dropdownOnly)
//	{
//		[nestedGrid runToolbarAction:action :event.currentTarget :self];
//	}
//	[self initializeMenu:action];
}

-(void)initializeMenu:(FLXSToolbarAction*)action
{
//	popMenu.styleName=@"noIconMenu";
//	popMenu.dataProviderFLXS=action.subActions;
//	popMenu.dataDescriptor=[[ToolbarMenuDataDescriptor alloc] init:isEnabledFunction];
//	[popMenu invalidateListRecursive];
//	[popMenu validateNow];
//	popMenu.action=action;
}

-(void)onMenuItemClick:(FLXSEvent*)event
{
	//ToolbarAction* action = event.item as ToolbarAction;
	//[nestedGrid runToolbarAction:action :event.currentTarget :self];
}

-(NSObject*)isEnabledFunction:(FLXSToolbarAction*)action
{
	//[return nestedGrid isToolbarActionValid:action :action.trigger :self] ;
    return nil;
}

-(void)drawRect:(CGRect)rect {
 	if(!self.built && self.nestedGrid)
	{
		[self.nestedGrid traceEvent:(@"building pager")];
		[self reBuild];
		[self.nestedGrid traceEvent:(@"done building pager")];
	}
//	if(_actionsWidthInvalid)
//	{
//		_actionsWidthInvalid=NO;
//		int n = numChildren;
//		float top=[self getStyle:(@"paddingTop")];
//		float bottom=[self getStyle:(@"paddingBottomFLXS")];
//		float wSoFar=[self getStyle:(@"paddingLeft")];
//		for (int i = 0; i < n; i++)
//		{
//			UIView* child = [self getChildAt:i] as IUIComponent;
//			if(child!=hboxToolbar)
//				wSoFar+=child.width+([self getStyle:(@"horizontalGap")]);
//		}
//		wSoFar+=[self getStyle:(@"paddingRight")];
//		if(hboxToolbar)
//		{
//			hboxToolbar.width=(width-wSoFar);
//			hboxToolbar.height=self.height-top-bottom;
//		}
//	}
	if(_pageDropdownDirty && self.cbxPage)
	{
		_pageDropdownDirty=NO;
		[self setPageDropdown];
	}
}
-(void)onSettingsDropDownSelect
{
    if([self.cbxSettings.selectedValue isEqual:[FLXSConstants PGR_GRID_SETTINGS]]){
        [self onShowSettingsPopup];
    }else if([self.cbxSettings.selectedValue isEqual:[FLXSConstants PGR_SAVE_SETTINGS]]){
        [self onSaveSettingsPopup];
    }else if([self.cbxSettings.selectedValue isEqual:[FLXSConstants PGR_SORT_SETTINGS]]){
        [self onMultiColmnSort];
    }
}
-(void)onExportDropDownSelect
{
    if([self.cbxExport.selectedValue isEqual:[FLXSConstants PGR_EXPORT_TO_EXCEL]]){
        [self onExcelExport];
    }else if([self.cbxExport.selectedValue isEqual:[FLXSConstants PGR_EXPORT_TO_WORD]]){
        [self onWordExport];
    }else if([self.cbxExport.selectedValue isEqual:[FLXSConstants PGR_EXPORT_TO_TEXT]]){
        FLXSExportOptions* eo = [FLXSExportOptions create:[FLXSExportOptions TXT_EXPORT]];
        [[FLXSExtendedExportController instance] export:self.grid exportOptions:eo];
    }else if([self.cbxExport.selectedValue isEqual:[FLXSConstants PGR_EXPORT_TO_HTML]]){
        FLXSExportOptions* eo = [FLXSExportOptions create:[FLXSExportOptions HTML_EXPORT]];
        [[FLXSExtendedExportController instance] export:self.grid exportOptions:eo];
    }else{


        for(FLXSExporter* exp in _grid.excelOptions.exporters){
            if([self.cbxExport.selectedValue isEqual:exp.name]){
                FLXSExportOptions* eo = [FLXSExportOptions create:[FLXSExportOptions HTML_EXPORT]];
                eo.exporter = exp;
                eo.exporters =_grid.excelOptions.exporters;
                [[FLXSExtendedExportController instance] export:self.grid exportOptions:eo];
            }
        }

    }

}
-(void)onFilterDropDownSelect
{
    if([self.cbxFilter.selectedValue isEqual:[FLXSConstants PGR_RUN_FILTER]]){
        [self onProcessFilter];
    }else if([self.cbxFilter.selectedValue isEqual:[FLXSConstants PGR_CLEAR_FILTER]]){
        [self onClearFilter];
    }else if([self.cbxFilter.selectedValue isEqual:[FLXSConstants PGR_SHOW_HIDE_FILTER]]){
        [self onShowHideFilter];
    }
}


-(void)reBuild{
    while([self.subviews count ]>0)
    {
        [self.subviews[0] removeFromSuperview];
    }
    if(self.nestedGrid)
    {

//        NSMutableArray  *items = [[NSMutableArray    alloc] init];
        float gap = padding;
        float xSoFar=padding;

        if(self.rowInfo.rowPositionInfo.levelNestDepth==1){
            if(self.grid.enablePreferencePersistence)
            {
                self.cbxSettings = [[FLXSComboBox alloc] initWithFrame:CGRectMake(xSoFar, padding, 40, 40) AndIcon:[FLXSPagerControlAS iconSettings] ];
                [self.cbxSettings addEventListenerOfType:[FLXSEvent EVENT_CHANGE]
                                             usingTarget:self
                                             withHandler:@selector(onSettingsDropDownSelect)];
                [self addChild:self.cbxSettings];
                if(self.nestedGrid.enableMultiColumnSort)
                {
                    self.cbxSettings.dataProviderFLXS = [[NSArray alloc]
                            initWithObjects:
                                    [[FLXSLabelData alloc] initWithLabel:[FLXSConstants PGR_GRID_SETTINGS] andData:[FLXSConstants PGR_GRID_SETTINGS]],
                                    [[FLXSLabelData alloc] initWithLabel:[FLXSConstants PGR_SORT_SETTINGS] andData:[FLXSConstants PGR_SORT_SETTINGS]],
                                    [[FLXSLabelData alloc] initWithLabel:[FLXSConstants PGR_SAVE_SETTINGS] andData:[FLXSConstants PGR_SAVE_SETTINGS]],
                                    nil];

                }
                else{
                    self.cbxSettings.dataProviderFLXS = [[NSArray alloc]
                            initWithObjects:
                                    [[FLXSLabelData alloc] initWithLabel:[FLXSConstants PGR_GRID_SETTINGS] andData:[FLXSConstants PGR_GRID_SETTINGS]],
                            /*[[FLXSLabelData alloc] initWithLabel:[FLXSConstants PGR_SORT_SETTINGS] andData:[FLXSConstants PGR_SORT_SETTINGS]],*/
                                    [[FLXSLabelData alloc] initWithLabel:[FLXSConstants PGR_SAVE_SETTINGS] andData:[FLXSConstants PGR_SAVE_SETTINGS]],
                                    nil];

                }
                self.cbxSettings.showAccessory=NO;
                self.cbxSettings.height = self.height;
                xSoFar+=self.cbxSettings.width+gap;

            }
            if(self.grid.enableExport)
            {

                self.cbxExport = [[FLXSComboBox alloc] initWithFrame:CGRectMake(xSoFar, padding, 40, 40)
                                                             AndIcon:[FLXSPagerControlAS iconExportExcel] ];
                if(self.grid.exportTypeList && self.grid.exportTypeList.count > 0)
                    self.cbxExport.dataProviderFLXS = self.grid.exportTypeList;
                else{
                    NSMutableArray * exporters = [[NSMutableArray alloc] init];

                    for(FLXSExporter* exp in _grid.excelOptions.exporters){
                        [exporters addObject:[[FLXSLabelData alloc] initWithLabel:exp.name andData:exp.name] ];
                    }

                    self.cbxExport.dataProviderFLXS = exporters;
                }
                [self.cbxExport addEventListenerOfType:[FLXSEvent EVENT_CHANGE]
                                           usingTarget:self
                                           withHandler:@selector(onExportDropDownSelect)];
                self.cbxExport.showAccessory=NO;
                [self addChild:self.cbxExport];
                self.cbxExport.height = self.height;
                xSoFar+=self.cbxExport.width+gap;

            }
            if(self.grid.enableFilters)
            {

                self.cbxFilter = [[FLXSComboBox alloc] initWithFrame:CGRectMake(xSoFar, padding, 40, 40)
                                                             AndIcon:[FLXSPagerControlAS iconFilterShowHide] ];
                self.cbxFilter.dataProviderFLXS = [[NSArray alloc]
                        initWithObjects:
                                [[FLXSLabelData alloc] initWithLabel:[FLXSConstants PGR_RUN_FILTER] andData:[FLXSConstants PGR_RUN_FILTER] ],
                                [[FLXSLabelData alloc] initWithLabel:[FLXSConstants PGR_CLEAR_FILTER] andData:[FLXSConstants PGR_CLEAR_FILTER]],
                                [[FLXSLabelData alloc] initWithLabel:[FLXSConstants PGR_SHOW_HIDE_FILTER] andData:[FLXSConstants PGR_SHOW_HIDE_FILTER]],
                                nil];
                [self.cbxFilter addEventListenerOfType:[FLXSEvent EVENT_CHANGE]
                                           usingTarget:self
                                           withHandler:@selector(onFilterDropDownSelect)];
                self.cbxFilter.showAccessory=NO;
                [self addChild:self.cbxFilter];
                self.cbxFilter.height = self.height;
                xSoFar+=self.cbxFilter.width+gap;
            }


        }
        if(self.nestedGrid.enablePaging)
        {
            //add the paging label
            self.lblPaging=[[UILabel alloc] init];
            if(self.grid.pagerStyleName){
                [self.grid.pagerStyleName applyFont:self.lblPaging];
            }
            self.lblPaging.backgroundColor = [UIColor clearColor];
            [self addChild:self.lblPaging];
            [self setPagingLabel];
            self.lblPaging.height = self.height;
            int numButtons = 0;
            if(self.grid.enablePreferencePersistence)
                numButtons++;
            if(self.grid.enableFilters)
                numButtons++;
            if(self.grid.enableExport)
                numButtons++;

            self.lblPaging.width = (self.width-((4+numButtons)*(40+padding)))-padding;
            self.lblPaging.textAlignment = NSTextAlignmentCenter;
            [self.lblPaging moveToX:xSoFar y:-2];

            xSoFar+=self.lblPaging.width+gap;

            //add the paging buttons
            self.BTN_FIRST_PAGE = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupImageButton:self.BTN_FIRST_PAGE :(@"BTN_FIRST_PAGE") :[FLXSPagerControlAS iconFirstPage] :@selector(onImgFirstClick)];
            [self.BTN_FIRST_PAGE moveToX:xSoFar y:padding];

            xSoFar+=self.BTN_FIRST_PAGE.width+gap;

            self.BTN_PREV_PAGE = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupImageButton:self.BTN_PREV_PAGE :(@"BTN_PREV_PAGE") :[FLXSPagerControlAS iconPrevPage] :@selector(onImgPreviousClick)];
            [self.BTN_PREV_PAGE moveToX:xSoFar y:padding];
            xSoFar+=self.BTN_FIRST_PAGE.width+gap;


            self.BTN_NEXT_PAGE = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupImageButton:self.BTN_NEXT_PAGE :(@"BTN_NEXT_PAGE") :[FLXSPagerControlAS iconNextPage] :@selector(onImgNextClick)];
            [self.BTN_NEXT_PAGE moveToX:xSoFar y:padding];
            xSoFar+=self.BTN_FIRST_PAGE.width+gap;


            self.BTN_LAST_PAGE = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupImageButton:self.BTN_LAST_PAGE :(@"BTN_LAST_PAGE") :[FLXSPagerControlAS iconLastPage] :@selector(onImgLastClick)];
            [self.BTN_LAST_PAGE moveToX:xSoFar y:padding];
            xSoFar+=self.BTN_FIRST_PAGE.width+gap;

            [self setPagingButtons];

            xSoFar+=self.cbxPage.width+gap;
        }
        [self setContentSize:CGSizeMake(xSoFar, self.height)];
        if(xSoFar>self.width) {
            [self flashScrollIndicators];
        }


    }
}
-(void)reBuildOld
{
    while([self.subviews count ]>0)
    {
        [self.subviews[0] removeFromSuperview];
    }
   // self.built=YES;
	if(self.nestedGrid)
	{

//        NSMutableArray  *items = [[NSMutableArray    alloc] init];
        float gap = padding;
        float xSoFar=padding;



        if(self.rowInfo.rowPositionInfo.levelNestDepth==1){

            if(self.nestedGrid.enableDrillDown)
            {
                self.BTN_EXP_ONE_DOWN = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_EXP_ONE_DOWN :(@"BTN_EXP_ONE_DOWN") :[FLXSPagerControlAS iconExpandOne] :
                        @selector(onExpandOne)];
                [self.BTN_EXP_ONE_DOWN moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_EXP_ONE_DOWN.width+gap;

                self.BTN_EXP_ONE_UP = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_EXP_ONE_UP :(@"BTN_EXP_ONE_UP") :[FLXSPagerControlAS iconCollapseOne] :
                        @selector(onCollapseOne)];
                [self.BTN_EXP_ONE_UP moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_EXP_ONE_UP.width+gap;


                [self addSeparator];
                self.BTN_EXP_ALL = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_EXP_ALL :(@"BTN_EXP_ALL") :[FLXSPagerControlAS iconExpandAll] :
                        @selector(onExpandAll)];
                [self.BTN_EXP_ALL moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_EXP_ALL.width+gap;


                self.BTN_COLLAPSE_ALL = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_COLLAPSE_ALL :(@"BTN_COLLAPSE_ALL") :[FLXSPagerControlAS iconCollapseAll]
                        :@selector(onCollapseAll)];
                [self.BTN_COLLAPSE_ALL moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_COLLAPSE_ALL.width+gap;

                [self addSeparator];
            }
            if(self.nestedGrid.enablePreferencePersistence)
            {
                self.BTN_PREFERENCES = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_PREFERENCES :(@"BTN_PREFERENCES") :[FLXSPagerControlAS iconSettings] :
                        @selector(onShowSettingsPopup)];
                [self.BTN_PREFERENCES moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_PREFERENCES.width+gap;

                self.BTN_SAVE_PREFS = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_SAVE_PREFS :(@"BTN_SAVE_PREFS") :[FLXSPagerControlAS iconSaveSettings] :
                        @selector(onSaveSettingsPopup)];
                [self.BTN_SAVE_PREFS moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_SAVE_PREFS.width+gap;
                if(self.grid.enableMultiplePreferences)
                {
                    self.BTN_OPEN_PREFS = [UIButton buttonWithType:UIButtonTypeCustom];
                    [self setupImageButton:self.BTN_OPEN_PREFS :(@"BTN_OPEN_PREFS") :[FLXSPagerControlAS iconOpenSettings] :
                            @selector(onOpenSettingsPopup)];
                    [self.BTN_OPEN_PREFS moveToX:xSoFar y:padding];
                    xSoFar+=self.BTN_OPEN_PREFS.width+gap;
                }
                [self addSeparator];
            }
            if(self.nestedGrid.enableFooters)
            {
                self.BTN_FOOTER= [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_FOOTER :(@"BTN_FOOTER") :
                        [FLXSPagerControlAS iconFooterShowHide] :@selector(onShowHideFooter)];
                [self addSeparator];
                [self.BTN_FOOTER moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_FOOTER.width+gap;
            }
            if(self.nestedGrid.enableFilters)
            {
                self.BTN_FILTER= [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_FILTER :(@"BTN_FILTER") :[FLXSPagerControlAS iconFilterShowHide ]:
                        @selector(onShowHideFilter)];
                [self.BTN_FILTER moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_FILTER.width+gap;

                self.BTN_RUN_FILTER = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_RUN_FILTER :(@"BTN_RUN_FILTER") :[FLXSPagerControlAS iconFilterRun]
                        :@selector(onProcessFilter)];
                [self.BTN_RUN_FILTER moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_RUN_FILTER.width+gap;

                self.BTN_CLEAR_FILTER= [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_CLEAR_FILTER :(@"BTN_CLEAR_FILTER") :[FLXSPagerControlAS iconFilterClear]
                        :@selector(onClearFilter)];
                [self.BTN_CLEAR_FILTER moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_CLEAR_FILTER.width+gap;
                [self addSeparator];
            }
            if(self.nestedGrid.enablePrint)
            {
                //next version v1.2
//            self.BTN_PRINT = [UIButton buttonWithType:UIButtonTypeCustom];
//			[self setupImageButton:self.BTN_PRINT :(@"BTN_PRINT") :[FLXSPagerControlAS iconPrint] :([self function:(e:Event)]:void{[self onPrint];})];
//            self.BTN_PDF = [UIButton buttonWithType:UIButtonTypeCustom];
//			[self setupImageButton:self.BTN_PDF :(@"BTN_PDF") :[FLXSPagerControlAS iconPdf] :([self function:(e:Event)]:void{[self onPdf];})];
//			[self addSeparator];
            }
            if(self.nestedGrid.enableExport)
            {
                self.BTN_EXCEL = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_EXCEL :(@"BTN_EXCEL") :[FLXSPagerControlAS iconExportExcel]
                        :@selector(onExcelExport)];
                [self.BTN_EXCEL moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_EXCEL.width+gap;

                self.BTN_WORD = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_WORD :(@"BTN_WORD") :[FLXSPagerControlAS iconExportWord]
                        :@selector(onWordExport)];
                [self.BTN_WORD moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_WORD.width+gap;
                [self addSeparator];
            }
            if(self.nestedGrid.enableMultiColumnSort)
            {
                self.BTN_MCS = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setupImageButton:self.BTN_MCS :(@"BTN_MCS") :[FLXSPagerControlAS iconMultiColumnSort] :@selector(onMultiColmnSort)];
                [self.BTN_MCS moveToX:xSoFar y:padding];
                xSoFar+=self.BTN_MCS.width+gap;

            }
        }
        if(self.nestedGrid.enablePaging)
        {
            //add the paging label
            self.lblPaging=[[UILabel alloc] init];
            if(self.grid.pagerStyleName){
                [self.grid.pagerStyleName applyFont:self.lblPaging];
            }
            self.lblPaging.backgroundColor = [UIColor clearColor];
            [self addChild:self.lblPaging];
            [self setPagingLabel];
            self.lblPaging.height = self.height;
            [self.lblPaging moveToX:xSoFar y:10];
            [self.lblPaging sizeToFit];

            xSoFar+=self.lblPaging.width+gap;

            //add the paging buttons
            self.BTN_FIRST_PAGE = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupImageButton:self.BTN_FIRST_PAGE :(@"BTN_FIRST_PAGE") :[FLXSPagerControlAS iconFirstPage] :@selector(onImgFirstClick)];
            [self.BTN_FIRST_PAGE moveToX:xSoFar y:padding];

            xSoFar+=self.BTN_FIRST_PAGE.width+gap;

            self.BTN_PREV_PAGE = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupImageButton:self.BTN_PREV_PAGE :(@"BTN_PREV_PAGE") :[FLXSPagerControlAS iconPrevPage] :@selector(onImgPreviousClick)];
            [self.BTN_PREV_PAGE moveToX:xSoFar y:padding];
            xSoFar+=self.BTN_FIRST_PAGE.width+gap;


            self.BTN_NEXT_PAGE = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupImageButton:self.BTN_NEXT_PAGE :(@"BTN_NEXT_PAGE") :[FLXSPagerControlAS iconNextPage] :@selector(onImgNextClick)];
            [self.BTN_NEXT_PAGE moveToX:xSoFar y:padding];
            xSoFar+=self.BTN_FIRST_PAGE.width+gap;


            self.BTN_LAST_PAGE = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupImageButton:self.BTN_LAST_PAGE :(@"BTN_LAST_PAGE") :[FLXSPagerControlAS iconLastPage] :@selector(onImgLastClick)];
            [self.BTN_LAST_PAGE moveToX:xSoFar y:padding];
            xSoFar+=self.BTN_FIRST_PAGE.width+gap;

            [self setPagingButtons];
//			[self addSeparator]  ;
            self.lblGotoPage=[[UILabel alloc] init];
            if(self.grid.pagerStyleName){
                [self.grid.pagerStyleName applyFont:self.lblGotoPage];
            }

            self.lblGotoPage.text=[FLXSConstants PGR_LBL_GOTO_PAGE_TEXT];
            self.lblGotoPage.backgroundColor = [UIColor clearColor];
            [self addChild:self.lblGotoPage];
            self.lblGotoPage.height = self.height;
            [self.lblGotoPage moveToX:xSoFar y:10];
            [self.lblGotoPage sizeToFit];

            xSoFar+=self.lblGotoPage.width+gap;

            self.cbxPage = [[FLXSComboBox alloc] initWithFrame:CGRectMake(xSoFar, padding, 60, 40)];

            [self setPageDropdown];
            [self.cbxPage addEventListenerOfType:[FLXSEvent EVENT_CHANGE] usingTarget:self withHandler:@selector(onPageCbxChange)];

            [self addChild:self.cbxPage];
            self.cbxPage.height = self.height;

            xSoFar+=self.cbxPage.width+gap;
        }
    [self setContentSize:CGSizeMake(xSoFar, self.height)];
        if(xSoFar>self.width) {
            [self flashScrollIndicators];
        }
	}
	[self invalidateActionsWidth :nil];

}

-(void)setupImageButton:(UIButton*)button :(NSString*)id :(UIImage*)icon :(SEL)clickHandler
{

    [button addTarget:self action:clickHandler forControlEvents:UIControlEventTouchUpInside];
    [button setImage:icon forState:UIControlStateNormal];
    button.imageView.frame=CGRectMake(4, 4, 32, 32);
    button.imageView.hidden=NO;
    [button setActualSizeWithWidth:40 andHeight:40];
    [self addChild:button];

    //[self addChild:btn];
	//btn.id=id;
	//btn.source = icon;
	//btn.automationName= nestedGrid.automationName + @"_" + id;
	//[btn addEventListener:[FLXSTouchEvent TAP] :self :@selector(clickHandler:)];
	//[btn addEventListener:[ResizeEvent RESIZE] :invalidateActionsWidth];
}

-(void)invalidateActionsWidth:(FLXSEvent*)e
{
//	_actionsWidthInvalid=YES;
//	[self setNeedsDisplay];
}

-(void)setupToolbarDropdownButton:(UIView*)btn :(FLXSToolbarAction*)action
{
//	[hboxToolbar addChild:btn];
//	btn.id=id;
//	btn.label = action.label;
//	btn.automationName= nestedGrid.automationName + @"_" + action.code;
//	if(action.isDropdownAction && (btn is PopUpButton))
//		action.trigger=btn;
//	else if(!action.isDropdownAction&& !(btn is PopUpButton))
//action.trigger=btn;
//	[btn addEventListener:[DropdownEvent OPEN] :popupButton_openHandler];
//	[btn addEventListener:(@"click") :popupButton_clickHandler];
//	btn.openAlways=action.dropdownOnly;
//	btn.popUp=popMenu;
}
//
//-(void)setupToolbarButton:(FLXSImageButton*)btn :(FLXSToolbarAction*)action
//{
////	[hboxToolbar addChild:btn];
////	btn.id=id;
////	btn.toolTip = action.tooltip;
////	btn.source = !action.enabled && action.disabledIconUrl?action.disabledIconUrl:action.iconUrl;
////	btn.automationName= nestedGrid.automationName + @"_" + action.code;
////	if(action.isDropdownAction && (btn is PopUpButton))
////		action.trigger=btn;
////	else if(!action.isDropdownAction&& !(btn is PopUpButton))
////action.trigger=btn;
////	[btn addEventListener:[MouseEvent CLICK] :onToolbarButtonClick];
//}

-(void)setPagingLabel
{
  	if(self.lblPaging)
		self.lblPaging.text= [[[NSArray alloc] initWithObjects:
                @" | ",[FLXSConstants PGR_ITEMS],@" ",[NSNumber numberWithInt:self.pageStart]
                ,@" ",[FLXSConstants PGR_TO],@" ",
                        [NSNumber numberWithInt:self.pageEnd],@" ",[FLXSConstants PGR_OF],@" ",
                        [NSNumber numberWithInt:self.totalRecords]
		,@". ",[FLXSConstants PGR_PAGE],@" ",[(self.totalRecords==0?0:[NSNumber numberWithInt:self.pageIndex+1]) description]
                ,@" ",[FLXSConstants PGR_OF],@" ",[NSNumber numberWithInt:self.pageCount] ,@" | ",nil] componentsJoinedByString:@""];
}

-(void)setPagingButtons
{
	if(self.BTN_FIRST_PAGE)
		self.BTN_FIRST_PAGE.userInteractionEnabled=self.pageIndex>0;
	if(self.BTN_PREV_PAGE)
		self.BTN_PREV_PAGE.userInteractionEnabled=self.pageIndex>0;
	if(self.BTN_NEXT_PAGE)
		self.BTN_NEXT_PAGE.userInteractionEnabled=self.pageIndex <(self.pageCount-1);
	if(self.BTN_LAST_PAGE)
		self.BTN_LAST_PAGE.userInteractionEnabled=self.pageIndex <(self.pageCount-1);
}

-(void)enableDisableToolbarButtons
{
//	for(ToolbarAction* action in nestedGrid.toolbarActions)
//	{
//		if(action.trigger)
//		{
//			action.trigger.enabled=[nestedGrid isToolbarActionValid:action :action.trigger :self];
//			action.trigger.toolTip=action.trigger.enabled?action.tooltip:@"";
//			if(!action.trigger.enabled && action.disabledIconUrl)
//			{
//				if(action.trigger is ImageButton)
//					action.trigger.source=(action.disabledIconUrl==[ToolbarAction DEFAULT_ICON]?_toolbarActionIcon:action.disabledIconUrl);
//				else
//[action.trigger setStyle:(@"icon") :(action.disabledIconUrl==[ToolbarAction DEFAULT_ICON]?_toolbarActionIcon:action.disabledIconUrl)];
//			}
//			else if(action.trigger.enabled && action.iconUrl)
//			{
//				if(action.trigger is ImageButton)
//					action.trigger.source=(action.iconUrl==[ToolbarAction DEFAULT_ICON]?_toolbarActionIcon:action.iconUrl);
//				else
//[action.trigger setStyle:(@"icon") :(action.iconUrl==[ToolbarAction DEFAULT_ICON]?_toolbarActionIcon:action.iconUrl)];
//			}
//		}
//	}
}

-(void)setToolbarActions
{
//	[hboxToolbar removeAllChildren];
//	hboxToolbar.toolbar=self;
//	[hboxToolbar setStyle:(@"horizontalGap") :3];
//	[hboxToolbar setStyle:(@"verticalGap") :0];
//	[hboxToolbar setStyle:(@"dropDownStyleName") :([self getStyle:(@"dropDownStyleName")]||@"dropdownHbox")];
//	[hboxToolbar setStyle:(@"dropDownButtonStyleName") :([self getStyle:(@"dropDownButtonStyleName")]||@"dropDownHBoxButton")];
//	[hboxToolbar setStyle:(@"paddingLeft") :0];
//	[hboxToolbar setStyle:(@"paddingRight") :0];
//	[hboxToolbar setStyle:(@"paddingBottomFLXS") :0];
//	[hboxToolbar setStyle:(@"paddingTop") :0];
//	NSMutableArray* toolbarActions=[[NSMutableArray alloc] init:nestedGrid.toolbarActions.source];
//	toolbarActions.filterFunction=toolbarActionFilterFunction;
//	for(ToolbarAction* action in toolbarActions)
//	{
//		if(action.isSeparator)
//		{
//			Label* titleLabel=[[Label alloc] init];
//			titleLabel.text=@"|";
//			[self addChild:titleLabel];
//		}
//		else if(action.isRegularAction)
//		{
//			ImageButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
//			[self addChild:btn];
//			[self setupToolbarButton:btn :action];
//		}
//		else
//		{
//			//dropdown action
//			PopUpButton* pbtn = [[PopUpButton alloc] init];
//			[self addChild:pbtn];
//			[self setupToolbarDropdownButton:pbtn :action];
//		}
//	}
//	[self enableDisableToolbarButtons];
}

-(void)addSeparator
{
	//UIView* titleLabel = [separatorFactory generateInstance] as DisplayObject;
	//[self addChild:titleLabel];
}

-(void)setPageDropdown
{
	NSMutableArray* pages=[[NSMutableArray alloc] init];
	for(int i=1;i<=self.pageCount;i++)
	{
        [pages addObject:[[NSNumber numberWithInt:i] description]];
	}
    self.cbxPage.dataProviderFLXS =pages;
    self.cbxPage.selectedIndex=self.pageIndex;
}

-(void)dispatchEvent:(FLXSEvent*)event
{
	if([event.type isEqual:@"pageIndexChanged"] || [event.type isEqual:@"pageChange"] || [event.type isEqual:@"reset"])
	{
		[self setPagingLabel];
		[self setPagingButtons];
		[self invalidateActionsWidth:nil];
	}
	[super dispatchEvent:event];

}

-(void)initializePager
{
}
+ (UIImage*)_toolbarActionIcon
{
	return _toolbarActionIcon;
}
+ (void)applyTheme:(NSString*) themeName{

}

 + (UIImage*)iconFirstPage
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_firstPage.png"]];

}
+ (UIImage*)iconPrevPage
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_prevPage.png"]];
}
+ (UIImage*)iconNextPage
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_nextPage.png"]];
}
+ (UIImage*)iconLastPage
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_lastPage.png"]];
}
+ (UIImage*)iconMultiColumnSort
{
    return  [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_sort.png"]];
}
+ (UIImage*)iconExpandOne
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_expandOne.png"]];
}
+ (UIImage*)iconCollapseOne
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_collapseOne.png"]];
}
+ (UIImage*)iconExpandAll
{
    return  [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_expandall.png"]];
}
+ (UIImage*)iconCollapseAll
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_collapseall.png"]];
}
+ (UIImage*)iconSettings
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_settings.png"]];
}
+ (UIImage*)iconSaveSettings
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_saveSettings.png"]];
}
+ (UIImage*)iconOpenSettings
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_openSettings.png"]];
}
+ (UIImage*)iconFooterShowHide
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_footerShowHide.png"]];
}
+ (UIImage*)iconFilterShowHide
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_filterShowHide.png"]];
}
+ (UIImage*)iconFilterRun
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_filter.png"]];
}
+ (UIImage*)iconFilterClear
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_clearFilter.png"]];
}
+ (UIImage*)iconPrint
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_print.png"]];
}
+ (UIImage*)iconPdf
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_pdf.png"]];
}
+ (UIImage*)iconExportWord
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_word.png"]];
}
+ (UIImage*)iconExportExcel
{
    return [UIImage imageNamed:[[[FLXSStyleManager instance] iconFilePrefix] stringByAppendingString: @"_export.png"]];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver: self];
}
@end

