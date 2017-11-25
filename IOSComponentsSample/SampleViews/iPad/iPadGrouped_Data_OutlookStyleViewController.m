//
//  iPadGrouped Data-OutlookStyleViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/8/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadGrouped_Data_OutlookStyleViewController.h"
#import "FLXSBusinessService.h"
#import "SampleUIUtils.h"

@interface iPadGrouped_Data_OutlookStyleViewController ()

@end

@implementation iPadGrouped_Data_OutlookStyleViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeTitleOfToolBar:@"Outlook Style"];
    self.flxsDataGrid.delegate = self;
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSOutlookGroupedData"];
    

    self.flxsDataGrid.verticalGridLines = NO;
    self.flxsDataGrid.horizontalGridLines=YES;
    self.flxsDataGrid.headerColors = [[NSArray alloc] initWithObjects:[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xEEEEEE],
                    [[FLXSStyleManager instance] getUIColorObjectFromHexString:0xEEEEEE],nil];

    self.flxsDataGrid.verticalGridLines = NO;
    
    self.flxsDataGrid.horizontalGridLines=YES;
    self.flxsDataGrid.headerColors = [[NSArray alloc] initWithObjects:[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xEEEEEE],[[FLXSStyleManager instance]getUIColorObjectFromHexString:0xEEEEEE], nil];
    self.flxsDataGrid.headerRollOverColors=[[NSArray alloc] initWithObjects:[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xEEEEEE],[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xEEEEEE], nil]; 
    self.flxsDataGrid.headerVerticalGridLineColor= [[FLXSStyleManager instance] getUIColorObjectFromHexString:0xD0D0D0 ];
    self.flxsDataGrid.filterColors=[[NSArray alloc]initWithObjects:[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xEEEEEE],[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xEEEEEE ], nil] ;
    self.flxsDataGrid.filterRollOverColors=[[NSArray alloc] initWithObjects:[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xEEEEEE],[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xEEEEEE ], nil];
    self.flxsDataGrid.filterVerticalGridLineColor = [[FLXSStyleManager instance] getUIColorObjectFromHexString:0xD0D0D0]; 
    self.flxsDataGrid.footerColors =[[NSArray alloc]initWithObjects:[[FLXSStyleManager instance] getUIColorObjectFromHexString: 0xFFFFFF],[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xFFFFFF ],nil];
    self.flxsDataGrid.footerRollOverColors=[[NSArray alloc]initWithObjects:[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xFFFFFF],[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xFFFFFF ] ,nil];
    self.flxsDataGrid.footerVerticalGridLines = NO;
    self.flxsDataGrid.footerHorizontalGridLineColor=[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xEDEDED];
    self.flxsDataGrid.headerHorizontalGridLineColor=[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xD0D0D0];
    self.flxsDataGrid.selectionColorFLXS =(NSArray*)[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xCEDBEF];
    self.flxsDataGrid.alternatingItemColors=[[NSArray alloc]initWithObjects:[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xFFFFFF],[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xFFFFFF],nil];
    self.flxsDataGrid.rollOverColor=[[FLXSStyleManager instance] getUIColorObjectFromHexString:0xFFFFFF];
            self.flxsDataGrid.disclosureOpenIcon=@"/minus.png";//make sure you put these images in flexiciousNmsp.Constants.IMAGE_PATH
            self.flxsDataGrid.disclosureClosedIcon=@"/plus.png",//make sure you put these images in flexiciousNmsp.Constants.IMAGE_PATH
    self.flxsDataGrid.horizontalGridLineColor=[[FLXSStyleManager instance] getUIColorObjectFromHexString:0x99BBE8];

}
FLXSExtendedFilterPageSortChangeEvent* evt1;
-(void)outlookGroupedData_CreationComplete:(NSNotification*)ns
{
    evt1 = (FLXSExtendedFilterPageSortChangeEvent*)[ ns.userInfo objectForKey:@"event"];

    [[FLXSBusinessService getInstance] getDeepOrgList:@selector(getDeepOrgList_result:) :self];
}
-(void)getDeepOrgList_result:(NSArray*)result
{
    [self.flxsDataGrid setDataProviderFLXS:result];
}
-(BOOL)outlookGroupedData_returnFalse:(UIView<FLXSIFlexDataGridCell>*)cell :(id)data{
    return false;
}
-(NSString*)outlookGroupedData_getInvoiceAmount:(NSObject*)data :(FLXSFlexDataGridColumn*)col{
    float val=0;
    if([data isKindOfClass:[ FLXSDeal class]])
        val=((FLXSDeal*)data).dealAmount;
    else if([data isKindOfClass:[FLXSOrganization class]])
        val= ((FLXSOrganization*)data).relationshipAmount;
    return [SampleUIUtils formatCurrency:val];
}
-(int)outlookGroupedData_amountSortCompareFunction:(NSObject*)obj1 :(NSObject*)obj2{
    if([obj1 isKindOfClass:[FLXSOrganization class]] && [obj2 isKindOfClass:[FLXSOrganization class]]){
        return ((FLXSOrganization*)obj1).relationshipAmount > ((FLXSOrganization*)obj2).relationshipAmount;
    }
    else if([obj1 isKindOfClass:[FLXSDeal class]] && [obj2 isKindOfClass:[FLXSDeal class]]){
        return ((FLXSDeal*)obj1).dealAmount>((FLXSDeal*)obj2).dealAmount;
    }
    else if([obj1 isKindOfClass:[FLXSInvoice class]] && [obj2 isKindOfClass:[FLXSInvoice class]]){
        return ((FLXSInvoice*)obj1).invoiceAmount>((FLXSInvoice*)obj2).invoiceAmount;
    }
    return 0;
    
}

-(UIColor *)outlookGroupedData_getBlueColor:(UIView<FLXSIFlexDataGridCell>*)cell
{
    return [[FLXSStyleManager instance] getUIColorObjectFromHexString:0x3764A0];
}
-(void)outlookGroupedData_gridrendererInitializedHandler:(NSNotification*)ns
{
    FLXSFlexDataGridEvent *event = (FLXSFlexDataGridEvent*)[ ns.userInfo objectForKey:@"event"];

    UIView<FLXSIFlexDataGridCell>* cell=event.cellFLXS;
    if(([cell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)])){//the dg has various types of cells. we only want to style the data cells...
        if(cell.level.nestDepth==1){
            //at the first level, we want font to be bold ...
            [cell setStyle:@"fontWeight" value:@"bold"];

        }
        else{
            [cell setStyle:@"fontWeight" value:@"normal"];
        }

    }
}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
