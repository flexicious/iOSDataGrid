//
//  iPadProgramaticCellFormattingViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/8/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadProgramaticCellFormattingViewController.h"
#import "FLXSFlexiciousMockGenerator.h"

@interface iPadProgramaticCellFormattingViewController ()

@end

@implementation iPadProgramaticCellFormattingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.flxsDataGrid.delegate = self;
    
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSProgramaticCellFormatting"];
    [self initializeTitleOfToolBar : @"Programatic Cell Formatting"];

    self.flxsDataGrid.dataProviderFLXS = [[FLXSFlexiciousMockGenerator instance] getFlatOrgList];
}

-(NSObject *)ProgrammaticCellFormatting_getRowBackground:(UIView<FLXSIFlexDataGridCell>*)cell{
    FLXSOrganization * org = (FLXSOrganization *)cell.rowInfo.data;
    if([org.headquarterAddress.state.name isEqualToString:@"New York"]){
        return [[FLXSStyleManager instance] getUIColorObjectFromHexString:0xCFCFCF];
    }else if(cell.rowInfo.isFillRow){
        return [[NSArray alloc] initWithObjects:
                [[FLXSStyleManager instance] getUIColorObjectFromHexString:0xCFCFCF],
                        [[FLXSStyleManager instance] getUIColorObjectFromHexString:0xFFFFFF],nil
        ];
    }
    return nil;
}
-(UIColor *)ProgrammaticCellFormatting_getRowTextColor:(UIView<FLXSIFlexDataGridCell>*)cell{
    FLXSOrganization * org = (FLXSOrganization *)cell.rowInfo.data;

    if([org.headquarterAddress.state.name isEqualToString:@"New York"]){
        return [[FLXSStyleManager instance] getUIColorObjectFromHexString:0xCC3300];
    }
    return nil;
}

-(id)ProgrammaticCellFormatting_getColumnBackground:(UIView<FLXSIFlexDataGridCell>*) cell{
    
    if([cell.level.selectedKeys containsObject:[FLXSExtendedUIUtils resolveExpression:cell.rowInfo.data expression:cell.level.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]]){
        return [self.flxsDataGrid getStyle:@"selectionColorFLXS"];
    }
    id val = [FLXSExtendedUIUtils resolveExpression:cell.rowInfo.data expression:cell.columnFLXS.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
    if([val intValue]<10000){
        return [[FLXSStyleManager instance] getUIColorObjectFromHexString:0xCC3300];
    }else if([val intValue]>50000){
        return [[FLXSStyleManager instance] getUIColorObjectFromHexString:0x66BB88];
    }
    else {
        return nil;
    }
}
-(id)ProgrammaticCellFormatting_getColumnTextColor:(UIView<FLXSIFlexDataGridCell>*) cell{

    id val= [FLXSExtendedUIUtils resolveExpression:cell.rowInfo.data expression:cell.columnFLXS.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
    if([val intValue]<10000){
        return [[FLXSStyleManager instance] getUIColorObjectFromHexString:0xFFFFFF];
    }else if([val intValue]>50000){
        return [[FLXSStyleManager instance] getUIColorObjectFromHexString:0x000000];
    }
    else {
        return [[FLXSStyleManager instance] getUIColorObjectFromHexString:0x000000];
    }
}
-(NSNumber *)ProgrammaticCellFormatting_getRowDisabled:(UIView<FLXSIFlexDataGridCell>*)cell :(NSObject*)data{
    if([((FLXSOrganization*)data).legalName isEqual:@"Adobe Systems"]){
        return [NSNumber numberWithBool:YES];
    }

    return [NSNumber numberWithBool:NO];//do not disable by default.
}



- (void)viewDidUnload {
    [self setIPadToolBar:nil];
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
