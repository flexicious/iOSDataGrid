//
//  iPadErrorHandlingViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

 #import "iPadErrorHandlingViewController.h"

@interface iPadErrorHandlingViewController ()

@end

@implementation iPadErrorHandlingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.flxsDataGrid.delegate=self;
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSErrorHandling"];
    [self initializeTitleOfToolBar:@"Error Handling"];

}


-(BOOL)validate:(UIView*)editor
{
    UIView<FLXSIFlexDataGridCell>* cell =[self.flxsDataGrid getCurrentEditingCell];
    //UIView<FLXSITextInput>* txt = editor as ITextInput;
    UITextField* txt = (UITextField*)editor;
    if(txt.text.length<3){
        [self.flxsDataGrid setErrorByObject:cell.rowInfo.data fld:cell.columnFLXS.dataFieldFLXS errorMsg:@"Legal name must be greater than 3 characters"];
    }else{
        [self.flxsDataGrid clearErrorByObject:cell.rowInfo.data fld:@""];
    }
    
    //If you return true, the grid will highlight the error in red and move on to the next row.
    //If you return false, the edit box would stay in place and not let the user move forward
    //unless the error is corrected.
    
    return (txt.text.length>=3);
}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
