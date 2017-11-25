#import "FLXSFlexDataGridCheckBoxColumn.h"
#import "FLXSTriStateCheckBox.h"
#import "FLXSFlexDataGridDataCell.h"

static FLXSClassFactory* static_TriStateCheckBox = nil;
static FLXSClassFactory* static_FLXSFlexDataGridDataCellUIComponent = nil;


@implementation FLXSFlexDataGridCheckBoxColumn {
@private
    BOOL _radioButtonMode;
    BOOL _allowSelectAll;
    BOOL _enableLabelAndCheckBox;
}

@synthesize radioButtonMode = _radioButtonMode;
@synthesize allowSelectAll = _allowSelectAll;
@synthesize enableLabelAndCheckBox = _enableLabelAndCheckBox;

-(id)generateInstance
{
    return [[FLXSFlexDataGridCheckBoxColumn alloc] init];
}

-(id)init
{
	self = [super init];
	if (self)
	{
		self.radioButtonMode = NO;
        self.allowSelectAll = YES;
		_enableLabelAndCheckBox = NO;

		[self setStyle:(@"paddingLeft") : [NSNumber numberWithInt:6]];
        [self setStyle:(@"headerPaddingLeft") :[NSNumber numberWithInt:6]];
        self.columnWidthMode=[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIXED];
        self.dataCellRenderer = [FLXSFlexDataGridCheckBoxColumn static_FLXSFlexDataGridDataCellUIComponent];
        self.itemRenderer=[FLXSFlexDataGridCheckBoxColumn static_TriStateCheckBox];
        self.headerRenderer = [FLXSFlexDataGridCheckBoxColumn static_TriStateCheckBox];
        self.width=50;
        self.sortable=NO;
        self.resizable=NO;
        self.excludeFromExport=YES;
        self.excludeFromPrint=YES;
        self.excludeFromSettings=YES;
        self.headerText=@"CheckBox Column";
        self.editable=NO;
        self.enableCellClickRowSelect=YES;
	}
	return self;
}


-(BOOL)enableSelectAll
{
	 return self.allowSelectAll;
}

-(void)setEnableSelectAll:(BOOL)value
{
	self.allowSelectAll = value;
}


-(void)setEnableLabelAndCheckBox:(BOOL)value
{
	_enableLabelAndCheckBox = value;
	if(value)
	{
		if([self.columnWidthMode isEqual:[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIXED]])
            self.columnWidthMode=[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_NONE];
		if(self.width==50)
            self.width=[FLXSFlexDataGridColumn DEFAULT_COLUMN_WIDTH];
        self.columnWidthMode=[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIXED];
        self.sortable=YES;
        self.resizable=YES;
        self.excludeFromExport=NO;
        self.excludeFromPrint=NO;
        self.excludeFromSettings=NO;
        self.editable=YES;
	}

}

-(BOOL)enableRadioButtonMode
{
	return self.radioButtonMode;
}

-(void)setEnableRadioButtonMode:(BOOL)value
{
	self.radioButtonMode = value;
}

+ (FLXSClassFactory*)static_TriStateCheckBox
{
    if(static_TriStateCheckBox==nil){
        static_TriStateCheckBox= [[FLXSClassFactory alloc] initWithClass:[FLXSTriStateCheckBox class] andProperties:nil ];
    }
	return static_TriStateCheckBox;
}
+ (FLXSClassFactory*)static_FLXSFlexDataGridDataCellUIComponent
{
    if(static_FLXSFlexDataGridDataCellUIComponent==nil){
        static_FLXSFlexDataGridDataCellUIComponent= [[FLXSClassFactory alloc] initWithClass:[FLXSFlexDataGridDataCell class] andProperties:nil ];
    }
    return static_FLXSFlexDataGridDataCellUIComponent;
}
@end

