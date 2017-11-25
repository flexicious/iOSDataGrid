//
//  iPadEditableCellsViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/8/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadEditableCellsViewController.h"
#import "FLXSReferenceData.h"
#import "FLXSSystemConstants.h"
#import "FLXSOrganization.h"

@interface iPadEditableCellsViewController (){
}

@end

@implementation iPadEditableCellsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.flxsDataGrid.delegate=self;
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSEditableCells"];
    [self initializeTitleOfToolBar:@"Editable Cells"];

}
//here we validate the user input, and ensure that only valid
-(void)flexdatagridcolumn1_itemEditValueCommitHandler:(NSNotification*)ns
{
    FLXSFlexDataGridItemEditEvent* event = (FLXSFlexDataGridItemEditEvent*)[ ns.userInfo objectForKey:@"event"];

    if([event.columnFLXS.dataFieldFLXS isEqual:@"headquarterAddress.city.name"]){
        NSString* txt=[event.itemEditor valueForKey:@"text"];
        BOOL found=false;
        for (FLXSReferenceData  *city in FLXSSystemConstants.cities){
            if(city.name==txt){
                ((FLXSOrganization*)event.item).headquarterAddress.city=city;
                found=true;
                break;
            }
        }
        if(!found){
            UIAlertView* alert  = [[UIAlertView alloc] initWithTitle:@"" message:[@"Invalid City Entered:" stringByAppendingString:txt] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
           // Alert.show("Invalid City Entered: " + txt);
        }
        [event preventDefault];
        //we do this, so when the value is entered, we validate and apply ourselves, dont let the grid apply it..
    }
    
}
-(BOOL)getRowDisabled:(UIView<FLXSIFlexDataGridCell>*)cell :(NSObject*)data{

    return false;//do not disable by default.
}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
