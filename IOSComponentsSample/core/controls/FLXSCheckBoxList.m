#import "FLXSCheckBoxList.h"
#import "UIView+UIViewAdditions.h"

@implementation FLXSCheckBoxList {
@private
    UIImage *partiallySelectedCheckBox;
    UIImage *checkedCheckBox;
    UIImage *unCheckedCheckBox;
    
    BOOL _selectedValuesDirty;
    BOOL _addAllItemDirty;
}


@synthesize selectedItems = _selectedItems;
@synthesize selectedValues = _selectedValues;
 @synthesize filterControlInterface = _filterControlInterface;
@synthesize addAllItem = _addAllItem;
@synthesize addAllItemText = _addAllItemText;
@synthesize dataProviderFLXS = _dataProviderFLXS;
@synthesize hasSearch;
@synthesize rowHeight;
@synthesize dataFieldFLXS = _dataFieldFLXS;
@synthesize labelField = _labelField;

-(void)commitPropertiesAddAllItem
{
	if (_addAllItemDirty)
	{
        _addAllItemDirty=NO;
		NSMutableArray* array= [self.dataProviderFLXS mutableCopy];
		if (_addAllItem)
		{

            if ([self.dataProviderFLXS count]>0)
            {
                NSObject * firstObject =          [[self dataProviderFLXS] objectAtIndex:0];
                if(![firstObject isKindOfClass:[NSString class]]){
                    firstObject = [firstObject valueForKey:self.dataFieldFLXS];
                }
                if(![[firstObject description] isEqualToString:self.addAllItemText]){
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
                    self.selectedItems= [self.dataProviderFLXS mutableCopy];
                }

            }

		}

	}
}
-(void)setAddAllItem:(BOOL)value
{
	_addAllItem=value;
	_addAllItemDirty=YES;
	[self setNeedsDisplay];
}


-(void)commitPropertiesSelectedValues
{
	if (_selectedValuesDirty && self.dataProviderFLXS && self.dataProviderFLXS.count>(self.addAllItem?1:0))
	{
		_selectedValuesDirty=NO;
		NSMutableArray* items=[[NSMutableArray alloc] init];
//        if (!self.dataFieldFLXS || self.dataFieldFLXS.length == 0)
//            [FLXSUIUtils raiseExceptionWithType:@"InvalidArgumentException"
//                                     andMessage:@"Cannot set checked values if value field is not set"];

        BOOL isAllItem=NO;
		if (self.addAllItem && _selectedValues && self.dataProviderFLXS && [self.dataProviderFLXS count] >0 && [_selectedValues count]==1
			&& [_selectedValues[0] isEqual:_addAllItemText])
		{
			isAllItem=YES;
		}
        NSMutableArray * bSelectedValues = _selectedValues;
		for(NSObject* item in self.dataProviderFLXS)
		{
			if(isAllItem)
			{
				[items addObject:item];
			}
			else if ([FLXSUIUtils doesArrayContainStringValue:bSelectedValues compareVal:[self itemToData:item]] !=nil)
			{
                [items addObject:item];
			}

		}
		self.selectedItems=items;
	}
}
-(NSString *)itemToLabel:(NSObject *)item {
    if([item isKindOfClass:[NSString class]]){
        return [item description];
    }else if([item respondsToSelector:NSSelectorFromString(self.labelField)]){
        return [item valueForKey:self.labelField];
    }
    return nil;
}
-(NSString *)itemToData:(NSObject *)item {
    if([item isKindOfClass:[NSString class]]){
        return [item description];
    }else if([item respondsToSelector:NSSelectorFromString(self.dataFieldFLXS)]){
        return [[item valueForKey:self.dataFieldFLXS] description];
    }
    return nil;
}

-(void)setSelectedValues:(NSMutableArray*)val
{
	_selectedValuesDirty=YES;
	_selectedValues=val;
	[self commitPropertiesSelectedValues];
}

-(NSMutableArray*)selectedValues
{
	if (_selectedValuesDirty)
		return _selectedValues;
    NSMutableArray* items=[[NSMutableArray alloc] init];
	if (self.addAllItem && self.selectedItems && self.dataProviderFLXS && [self.selectedItems count] >0 && [self.dataProviderFLXS count] >0
		&& [[self itemToData:_selectedItems[0] ]isEqual:[self itemToData:self.dataProviderFLXS[0] ] ])
	{
		[items addObject :[self itemToData:self.dataProviderFLXS[0] ]];
        return items;
	}
//    if (!self.dataFieldFLXS || self.dataFieldFLXS.length == 0)
//        [FLXSUIUtils raiseExceptionWithType:@"InvalidArgumentException"
//                                 andMessage:@"Cannot set checked values if value field is not set"];


    if ([self.selectedItems count] == 0)
		return nil;
	for(NSObject* item in self.selectedItems)
	{
        if ([self itemToData:item])
		{
			[items addObject:[self itemToData:item]];
		}
	}
	return items;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataProviderFLXS.count;
}
- (BOOL) isItemSelected:(NSObject *)item{
    if([self isAllSelected]){
        return YES;
    }else{
        return [FLXSUIUtils doesArrayContainStringValue:self.selectedValues compareVal:[self itemToData:item]] != nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }
    // Configure the cell...
    cell.textLabel.text = [self itemToLabel:[self.dataProviderFLXS objectAtIndex:indexPath.row]];
    cell.accessoryView = nil;
    if(self.addAllItem && indexPath.row==0){
        //this is the all item cell
        if([self isAllSelected])
            cell.accessoryView = [[UIImageView alloc] initWithImage:checkedCheckBox];
        else if([self.selectedItems count]>0)
            cell.accessoryView = [[UIImageView alloc] initWithImage:partiallySelectedCheckBox];
        else
            cell.accessoryView = [[UIImageView alloc] initWithImage:unCheckedCheckBox];
    }
    else if ([self isItemSelected: self.dataProviderFLXS[indexPath.row]] )
    {
        cell.accessoryView = [[UIImageView alloc] initWithImage:checkedCheckBox];
    }
    else
    {
        cell.accessoryView = [[UIImageView alloc] initWithImage:unCheckedCheckBox];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // self.selectedIndex = indexPath.row;
    BOOL dispatch = NO;
    if(self.addAllItem )
    {
        if(indexPath.row==0 &&
                ![self isItemSelected: self.dataProviderFLXS[indexPath.row]])
        {
            NSMutableArray* dpArray=[self.dataProviderFLXS mutableCopy];
//            if(useTriState&&hasSearch)
//            {
//                [dpArray splice:0 :1];
//            }
            self.selectedItems= dpArray;
            dispatch=YES;
        }
        else if(indexPath.row==0 &&
                [self isItemSelected: self.dataProviderFLXS[indexPath.row]])
        {
            self.selectedItems= [[NSMutableArray alloc] initWithCapacity:0];
            dispatch=YES;
        }
        else if([FLXSUIUtils doesArrayContainObjectValue:self.selectedItems valueField:self.labelField compareVal:self.addAllItemText])
        {
            self.selectedItems= [[FLXSUIUtils removeFromArray:self.selectedItems itemToRemove:(self.dataProviderFLXS[0])] mutableCopy];
            dispatch=YES;
        }

     }
    if(indexPath.row!=0 || !self.addAllItem){
        if(![self isItemSelected: self.dataProviderFLXS[indexPath.row]])
        {
            [self.selectedItems addObject:self.dataProviderFLXS[indexPath.row]];
            dispatch=YES;
        }
        else if([self isItemSelected: self.dataProviderFLXS[indexPath.row]])
        {
            self.selectedItems= [[FLXSUIUtils removeFromArray:self.selectedItems itemToRemove:(self.dataProviderFLXS[indexPath.row])] mutableCopy];
            dispatch=YES;
        }
    }


    [self reloadData];
    if(dispatch)
    {

        [self dispatchEvent:[[FLXSEvent alloc] initWithType:[FLXSCheckBoxList EVENT_CHANGE]
                                              andCancelable:false
                                                 andBubbles:false] ];
    }


}



-(void)setDataProviderFLXS:(NSArray*)value
{
	_dataProviderFLXS = value;
	if(_addAllItem)
	{
		self.addAllItem = YES;
		[self setNeedsDisplay];
	}
	if(_selectedValues)
	{
		_selectedValuesDirty=YES;
		[self setNeedsDisplay];
	}
    [self reloadData];
}

-(void)clear
{
	if(self.addAllItem&&self.dataProviderFLXS && [self.dataProviderFLXS count] >0&& [[self itemToLabel:_dataProviderFLXS[0]] isEqualToString:self.addAllItemText])
	{
		NSMutableArray * items= [[NSMutableArray alloc] initWithCapacity:1];
		[items addObject:[self itemToData:_dataProviderFLXS[0]]];
		self.selectedValues = items;
        self.selectedItems = [[NSMutableArray alloc] initWithObjects:_dataProviderFLXS[0],nil];

    }
	else
	{
        self.selectedItems = [[NSMutableArray alloc] init];
	}
    [self reloadData];
}

-(NSObject*)getValue
{
	return self.selectedValues;
}

-(void)setValue:(NSObject*)val
{
	self.selectedValues= [val mutableCopy];
}


-(NSString*)dataFieldFLXS
{
	return self.filterControlInterface.dataFieldFLXS;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)setDataFieldFLXS:(NSString*)o
{
    self.filterControlInterface.dataFieldFLXS = o;
}

-(BOOL)isAllSelected
{
    if(_selectedValuesDirty){
        [self validateNow];
    }
	BOOL result= [self areAllButFirstSelected];
	return result;
}

-(BOOL)areAllButFirstSelected
{
	if(self.selectedValues && ([self.selectedValues count] ==1 )&& [self.dataProviderFLXS count] >0
		&& ([[self.selectedValues[0] description] isEqualToString:[self itemToData:_dataProviderFLXS[0]]]
        && [[self itemToData:_dataProviderFLXS[0]] isEqualToString:self.addAllItemText]))
	{
		return YES;
	}
	for(NSObject* item in self.dataProviderFLXS)
	{
		if(![[self selectedItems] containsObject:item] && ([_dataProviderFLXS indexOfObject:item]!=0))
		{
			return NO;
		}
	}
	return YES;
}

-(void)drawRect:(CGRect)rect {

    [self commitPropertiesAddAllItem];
    [self commitPropertiesSelectedValues];
    [super drawRect:rect];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self  _init];
    }
    return self;
}

-(void) _init{
    
    _addAllItem = NO;
    _addAllItemDirty = NO;
    _addAllItemText = FLXSFilter.ALL_ITEM;
    _selectedValuesDirty = NO;
    partiallySelectedCheckBox = [UIImage imageNamed:@"FLXSAPPLE_partially_selected_checkbox.png"];
    checkedCheckBox = [UIImage imageNamed:@"FLXSAPPLE_checked_checkbox.png"];
    unCheckedCheckBox = [UIImage imageNamed:@"FLXSAPPLE_unchecked_checkbox.png"];
    self.labelField=@"label";
    self.dataFieldFLXS =@"data";
    
    self.delegate=self;
    self.dataSource = self;
    self.dataProviderFLXS = [[NSMutableArray alloc] init];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self   _init];
    }
    return self;
    
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

@end

