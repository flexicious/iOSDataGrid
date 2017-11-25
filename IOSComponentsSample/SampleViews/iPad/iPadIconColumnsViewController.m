//
//  iPadIconColumnsViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadIconColumnsViewController.h"
#import "FLXSBusinessService.h"

@interface iPadIconColumnsViewController ()

@end

@implementation iPadIconColumnsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.flxsDataGrid.delegate=self;
   
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSIconColumns"];
    [self initializeTitleOfToolBar:@"Icon Columns"];
    self.flxsDataGrid.dataProviderFLXS = [[FLXSFlexiciousMockGenerator instance] getFlatOrgList];
}

-(NSString*)dynamicTooltipFunction:(UIView<FLXSIFlexDataGridCell>*)cell{
    return [@"This is a dynamic tooltip for " stringByAppendingString: [cell.rowInfo.data valueForKey:@"legalName"]];
}
-(id)IconFunctions_dynamicIconFunction:(UIView<FLXSIFlexDataGridCell>*)cell :(NSString*)state{
    if(cell.rowInfo.isDataRow){
        return cell.rowInfo.rowPositionInfo.rowIndex%2==0?@"FLXSSampleUpIcon.png":@"FLXSSampleDownIcon.png";
    }
    return nil;
}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
