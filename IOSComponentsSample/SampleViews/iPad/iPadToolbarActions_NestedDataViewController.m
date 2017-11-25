//
//  iPadToolbarActions-NestedDataViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadToolbarActions_NestedDataViewController.h"
#import "FLXSDemoVersion.h"
#import "FLXSBusinessService.h"


@interface iPadToolbarActions_NestedDataViewController (){
    UIView<FLXSIExtendedPager>* extendedPager1;
}

@end

@implementation iPadToolbarActions_NestedDataViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *filePath;
    filePath = [[NSBundle mainBundle] pathForResource:@"FLXSNestedToolbarActions" ofType:@"xml"];
    self.flxsDataGrid.delegate=self;
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [self.flxsDataGrid buildFromXML:fileData];

}

-(void)vbox1_creationCompleteHandler:(NSNotification*)ns
{
    [self.flxsDataGrid.toolbarActions addObject:[[FLXSToolbarAction alloc] initWithName:@"Edit" andLevel:-1 andCode:@"" andToolTip:@"Edit Record" andIcon:@"assets/images/edit.png" andSeparatorBefore:YES andSeparatorAfter:NO andSubActions:nil andRequiresSelection:NO andRequiresSingleSelection:NO andDisabledIconUrl:nil andEnabledFunction:nil andExecutedFunction:nil andDelegate:nil]];
    [self.flxsDataGrid.toolbarActions addObject:[[FLXSToolbarAction alloc] initWithName:@"Delete" andLevel:-1 andCode:@"" andToolTip:@"Delete Record" andIcon:@"assets/images/delete.png" andSeparatorBefore:NO andSeparatorAfter:YES andSubActions:nil andRequiresSelection:NO andRequiresSingleSelection:NO andDisabledIconUrl:nil andEnabledFunction:nil andExecutedFunction:nil andDelegate:nil]];
    [[FLXSBusinessService getInstance] getDeepOrgList:@selector(getDeepOrgList_result:) :self];
}
-(void)getDeepOrgList_result:(NSArray*)result
{
    self.flxsDataGrid.dataProviderFLXS =result;
}
-(BOOL)isValidToolbarAction:(FLXSToolbarAction*)action :(NSObject*)currentTarget :(UIView<FLXSIExtendedPager>*)extendedPager{
    return [extendedPager.level.selectedKeys count] ==1;
}
-(void)onExecuteToolbarAction:(FLXSToolbarAction*)action :(NSObject*)currentTarget :(UIView<FLXSIExtendedPager>*)extendedPager{
    if([action.code isEqual:@"Edit"]){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Launch Edit Window:%@\t with id%@",extendedPager.level.levelName ,extendedPager.level.selectedKeys[0]  ] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //Alert.show("Launch Edit Window: " + extendedPager.level.levelName + " with id " + extendedPager.level.selectedKeys[0] )
        alert.tag = 0;
        [alert show];
    }
    else if([action.code isEqual:@"Delete"]){
         UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure you wish to delete this record? Confirm Delete" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.tag = 1;
        [alert show];
        
        extendedPager1 = extendedPager;
//            FLXSAlert.show("Are you sure you wish to delete this record?","Confirm Delete",Alert.OK|Alert.CANCEL,this,
//                       function(event:CloseEvent):void
//                       {
//                           if(event.detail==Alert.OK){
//                               Alert.show("Trigger delete for: " + extendedPager.level.levelName + " with id " + extendedPager.level.selectedKeys[0] )
//                           }
//                       }
//                       )
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Invalid action!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 2;
        [alert show];
        //Alert.show("Invalid action!")
    }
    
                }
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1 && buttonIndex == 1){
        UIAlertView* alertView1 = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Trigger delete for:\t%@\t with id \t %@",extendedPager1.level.levelName,extendedPager1.level.selectedKeys[0]] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView1 show];
        
    }
}


- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
