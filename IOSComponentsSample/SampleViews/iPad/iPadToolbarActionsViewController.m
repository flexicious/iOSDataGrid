//
//  iPadToolbarActionsViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadToolbarActionsViewController.h"
#import "FLXSBusinessService.h"
@interface iPadToolbarActionsViewController ()

@end

@implementation iPadToolbarActionsViewController


//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    NSString *filePath;
//    filePath = [[NSBundle mainBundle] pathForResource:@"FLXSToolbarActions" ofType:@"xml"];
//    self.flxsDataGrid.delegate=self;
//    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
//    [self.flxsDataGrid buildFromXML:fileData];
//
//}
//-(void)hbox2_creationCompleteHandler:(NSNotification*)ns
//{
//    [ self.flxsDataGrid.toolbarActions addObject:[[FLXSToolbarAction alloc] initWithName:@"Edit" andLevel:1 andCode:@"" andToolTip:@"Edit Record" andIcon:@"assets/images/edit.png" andSeparatorBefore:YES andSeparatorAfter:NO andSubActions:nil andRequiresSelection:NO andRequiresSingleSelection:NO andDisabledIconUrl:nil andEnabledFunction:nil andExecutedFunction:nil andDelegate:nil]];
//    [self.flxsDataGrid.toolbarActions addObject:[[FLXSToolbarAction alloc]
//                                                 initWithName:@"Delete"
//                                                 andLevel:1
//                                                 sandCode:@""
//                                                 andToolTip:@"Delete Record"
//                                                 andIcon:@"assets/images/delete.png"
//                                                 andSeparatorBefore:NO
//                                                 andSeparatorAfter:YES
//                                                 andSubActions:nil
//                                                 andRequiresSelection:nil
//                                                 andRequiresSingleSelection:NO
//                                                 andDisabledIconUrl:nil
//                                                 andEnabledFunction:nil
//                                                 andExecutedFunction:nil
//                                                 andDelegate:nil ]];
//    [[FLXSBusinessService getInstance] getFlatOrgList:@selector(getFlatOrgList_result:) :self];
//                                                 
//}
//-(void)getFlatOrgList_result:(NSArray*)result{
//    self.flxsDataGrid.dataProviderFLXS=result;
//}
//-(BOOL)isValidToolbarAction:(FLXSToolbarAction*)action :(NSObject *)currentTarget :(UIView<FLXSIExtendedPager>*)extendedPager{
//    return [self.flxsDataGrid.selectedKeys count]==1;
//}
//-(void)onExecuteToolbarAction:(FLXSToolbarAction*)action :(NSObject*)currentTarget :(UIView<FLXSIExtendedPager>*)extendedPager{
//    if([action.code isEqual:@"Edit"]){
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Launch Edit Window" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        alertView.tag = 0;
//        [alertView show];
//        //Alert.show("Launch Edit Window")
//    }
//    else if([action.code isEqual:@"Delete"]){
//        UIAlertView* alertView1 = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure you wish to delete this record?Confirm Delete" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
//        alertView1.tag = 1;
//        [alertView1 show];
//    }else{
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Invalid action!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alertView show];
//       // Alert.show("Invalid action!")
//
//    }
//    
//                }
//
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if(alertView.tag == 1 && buttonIndex == 1){
//        UIAlertView* alertView1 = [[UIAlertView alloc] initWithTitle:@"" message:@"Trigger delete on the backend" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alertView1 show];
//
//    }
//}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
