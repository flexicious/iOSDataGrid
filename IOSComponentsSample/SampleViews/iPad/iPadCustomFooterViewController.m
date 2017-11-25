

#import "iPadCustomFooterViewController.h"
#import "SampleUIUtils.h"
#import "FLXSEmployee.h"

@interface CustomFooterRenderer_CustomFooter : UITextView
@property (nonatomic,weak) NSObject * data;
@end

@implementation CustomFooterRenderer_CustomFooter


-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.editable = NO;
        self.textColor = [UIColor grayColor];
    }
    return self;
}

-(void)setText:(NSString *)tVal {

    FLXSFlexDataGridFooterCell* cell = (FLXSFlexDataGridFooterCell*)self.superview;
    NSString * text = @"Average: ";
    text = [text stringByAppendingString:[SampleUIUtils formatCurrency:[FLXSUIUtils average:cell.level.grid.dataProviderFLXS fld:cell.columnFLXS.dataFieldFLXS]]];
    text = [text stringByAppendingString:@"\r\n"];
    text = [text stringByAppendingString:@"Min:"];
    text = [text stringByAppendingString:[SampleUIUtils formatCurrency:[((NSNumber *) [FLXSUIUtils min:cell.level.grid.dataProviderFLXS fld:cell.columnFLXS.dataFieldFLXS comparisonType:nil ]) floatValue]]];
    text = [text stringByAppendingString:@"\r\n"];
    text = [text stringByAppendingString:@"Sum:"];
    text = [text stringByAppendingString:[SampleUIUtils formatCurrency:[((NSNumber *) [FLXSUIUtils max:cell.level.grid.dataProviderFLXS fld:cell.columnFLXS.dataFieldFLXS comparisonType:nil ]) floatValue]]];
    [super setText:text];
}

@end

@interface iPadCustomFooterViewController ()


@end

@implementation iPadCustomFooterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flxsDataGrid.delegate = self;
   
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSCustomFooter"];
    [self initializeTitleOfToolBar:@"FLXSCustomFooter"];
    
    self.flxsDataGrid.dataProviderFLXS = [FLXSEmployee employees];
}


- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
