//
//  iPadFullRowEditViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/16/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadFullRowEditViewController.h"
#import "FLXSFlexiciousMockGenerator.h"
#import "SampleUIUtils.h"
#import "FLXSDemoVersion.h"

@interface iPadFullRowEditViewController ()

@end

@implementation iPadFullRowEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.flxsDataGrid.delegate = self;
    self.flxsDataGrid.delegate=self;
        
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSEditableCells"];
    [self initializeTitleOfToolBar:@"Full Row Edit"];
    self.flxsDataGrid.dataProviderFLXS = [[FLXSFlexiciousMockGenerator instance] getFlatOrgList];
    
    
}


-(NSString*)dataGridFormatCurrencyLabelFunction:(NSObject *)rowData :(FLXSFlexDataGridColumn *)col{
    
    return [SampleUIUtils formatCurrency:[(NSNumber *) [FLXSExtendedUIUtils resolveExpression:rowData expression:col.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ] floatValue]];
}

-(void)grid_creationCompleteHandler:(NSNotification*)ns
{
    self.flxsDataGrid.rowEditBehavior.itemEditorsCommitFunction= @"onitemEditorsCommit:";
  self.flxsDataGrid.rowEditBehavior.itemEditorsValidatorFunction=@"onitemEditorsValidate:";
  self.flxsDataGrid.rowEditBehavior.itemEditorsInitializeFunction=@"onitemEditorsInitialize:";
    
  }

-(void)onitemEditorsInitialize:(NSMutableDictionary*)editors
{
//   for (var key:String in editors){
//       var editor:UIComponent = editors[key] as UIComponent;
//        var col:FlexDataGridColumn = this.grid.getColumnByUniqueIdentifier(key);
//        
//        editor.toolTip = "Editor for " + col.headerText;
//        }
    
    }


-(BOOL)onitemEditorsValidate:(NSMutableDictionary*)editors
{
//   NSDate* editor= (NSDate*)[editors objectForKey:dateCol.uniqueIdentifier];
//   if(editor.selectedDate<new Date()){
//       editor.errorString = "A Date is required, and please enter a date in the future";
//       return false;
//        }
   return YES;
    }

-(void)onitemEditorsCommit:(NSMutableDictionary*)editors
{
//  ((FLXSOrganization*)[self.flxsDataGrid getCurrentEditingCell].rowInfo.data).headquarterAddress.state=[editors objectForKey:stateCol.uniqueIdentifier].selectedItem;
    
}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
