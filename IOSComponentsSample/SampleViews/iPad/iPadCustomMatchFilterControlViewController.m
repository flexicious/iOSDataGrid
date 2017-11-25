
#import "iPadCustomMatchFilterControlViewController.h"
#import "FLXSEmployee.h"

@interface CustomMatchFilterControl_CustomMatchTextBoxRenderer : FLXSTextInput <FLXSICustomMatchFilterControl>
//    //we need to implement ICustomMatchFilterControl because we want to tell the grid to call our isMatch method to do the filter
//    //we need to implement (FLXSTextInput already does) IFilterControl to tell the grid that we are actually a filter control, and not a placeholder for non-filterable columns
//    //we need to implement iDelayedChange (FLXSTextInput already does)  so that the grid listens to our "delayedChange" event, and not the regular change method.
//    //if we had set filterTriggerEvent on the column to "enterKeyUp", we would not have had to implement IDelayedChange, but then the
//    //user would have had to hit the enter key to run the filter.
@end

@implementation CustomMatchFilterControl_CustomMatchTextBoxRenderer


-(BOOL)isMatch:(FLXSEmployee*) emp {

    if(emp && self.text.length>0){
        return [[emp.firstName lowercaseString] rangeOfString:[self.text lowercaseString]].location != NSNotFound
            ||[[emp.lastName lowercaseString] rangeOfString:[self.text lowercaseString]].location != NSNotFound;
    }
    return true;
};

@end

@interface iPadCustomMatchFilterControlViewController (){
}

@end

@implementation iPadCustomMatchFilterControlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flxsDataGrid.delegate = self;
   
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSCustomMatchFilterControl"];
    [self initializeTitleOfToolBar:@"Custom Match Filter Control"];
    self.flxsDataGrid.dataProviderFLXS = [FLXSEmployee employees];
}
-(NSString*)CustomMatchFilterControl_getFullName:(FLXSEmployee *)item :(FLXSFlexDataGridColumn *)col{
    return [[item.firstName stringByAppendingString:@" "] stringByAppendingString:item.lastName];
}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
