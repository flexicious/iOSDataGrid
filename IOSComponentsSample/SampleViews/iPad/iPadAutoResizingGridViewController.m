

#import "iPadAutoResizingGridViewController.h"


@interface iPadAutoResizingGridViewController (){
    FLXSEvent* evt;
}

@end

@implementation iPadAutoResizingGridViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.flxsDataGrid.delegate=self;
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSAutoResizingGrid"];
    [self initializeTitleOfToolBar:@"Auto ResizingGrid"];

}



NSMutableArray * autoResizingGrid_listOfObjects;
int autoResizingGrid_number=1;

-(void)autoResizingGrid_newObject{
    NSMutableDictionary * obj = [[NSMutableDictionary alloc] init];
    [obj setObject:[NSNumber numberWithInt:autoResizingGrid_number++] forKey:@"number"];
    [obj setObject:[NSNumber numberWithInt:1] forKey:@"value"];
    [autoResizingGrid_listOfObjects addObject:obj];
    [self.flxsDataGrid rebuild];
};
-(void)autoResizingGrid_creationCompleteHandler:(NSNotification *)ns{
    autoResizingGrid_listOfObjects  = [[NSMutableArray alloc] init];
    for (int i=0;i<3;i++){
        [self autoResizingGrid_newObject];
    }
    self.flxsDataGrid.dataProviderFLXS =autoResizingGrid_listOfObjects;
}
- (IBAction)addItem:(id)sender {
    [self autoResizingGrid_newObject];

}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
