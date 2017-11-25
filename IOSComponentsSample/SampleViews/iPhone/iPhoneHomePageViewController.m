//
//  iPhoneHomePageViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-111 on 6/20/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPhoneHomePageViewController.h"

@interface iPhoneHomePageViewController ()

@end

@implementation iPhoneHomePageViewController

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
    
    [self       initializeTitleOfToolBar];
    
     CGRect customTextInputFrame = CGRectMake(20.0f, 50.0f, 280.0f, 31.0f);
    
     //customTextInput = [[AutoCompleteTextInput alloc] initWithFrame:customTextInputFrame];
     customTextInput = [[FLXSTextInput alloc] initWithFrame:customTextInputFrame];
     NSMutableArray *myDataSource = [[NSMutableArray alloc] init];
     customTextInput.autoCompleteDropDownBorderWidth = 1.0;
     customTextInput.autoCompleteDropDownBorderColor = [UIColor blueColor].CGColor;
     //customTextInput.watermarkString = @"search";
     customTextInput.placeholder = @"test";
     customTextInput.autoCompleteMatchType = [FLXSTextInput AUTO_COMPLETE_MATCH_TYPE_BEGINS_WITH];
     //[customTextInput setInitialText:@"search"];
     [myDataSource addObject:@"one"];
     [myDataSource addObject:@"two"];
     [myDataSource addObject:@"three"];
     [myDataSource addObject:@"four"];
     [myDataSource addObject:@"five"];
     [myDataSource addObject:@"six"];
     [myDataSource addObject:@"seven"];
     [myDataSource addObject:@"eight"];
     [myDataSource addObject:@"nine"];
     [myDataSource addObject:@"ten"];
     [myDataSource addObject:@"eleven"];
     [myDataSource addObject:@"twelve"];
     [myDataSource addObject:@"thirteen"];
     customTextInput.autoCompleteSource = myDataSource;
     customTextInput.borderStyle = UITextBorderStyleRoundedRect;
     customTextInput.rightViewMode = UITextFieldViewModeAlways;
     customTextInput.clearButtonMode = UITextFieldViewModeWhileEditing;
     [self becomeFirstResponder];
     [self.view addSubview:customTextInput];
     CGRect buttonFrame = CGRectMake(20.0f, 90.0f, 200.0f, 31.0f);
     
     comboBox = [[FLXSComboBox alloc] initWithFrame:buttonFrame];
     comboBox.dataProviderFLXS = myDataSource;
     comboBox.addAllItem = YES;
     [self.view addSubview:comboBox];
     
     CGRect checkBoxFrame = CGRectMake(20.0f, 130.0f, 18.0f, 18.0f);
     myCheckBox = [[FLXSTriStateCheckBox alloc] initWithFrame:checkBoxFrame];
     //myCheckBox.allowUserToSelectMiddle = YES;
     myCheckBox.checked =YES;
     myCheckBox.radioButtonMode= YES;
     [self.view addSubview:myCheckBox];
     
     FLXSDateRange *range = [[FLXSDateRange alloc] initWithDateRangeType:[FLXSDateRange DATE_RANGE_LAST_7_DAYS] andStartDate:nil andEndDate:nil];
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     formatter.dateFormat = @"MM/dd/YYYY";
     
     NSString *startDate  = [formatter stringFromDate:range.startDate];
     NSString *endDate  = [formatter stringFromDate:range.endDate];
    
     NSArray *msg = [NSArray arrayWithObjects:startDate, @":" , endDate , nil];
     customTextInput.text = [msg componentsJoinedByString:@" "];
     
     dateComboBox =[[FLXSDateComboBox alloc]initWithFrame:CGRectMake(20, 150, 200, 31)];
     dateComboBox.addAllItem = YES;
     [dateComboBox addEventListenerOfType:[FLXSDateComboBox EVENT_CHANGE] usingTarget:self withHandler:@selector(onDateComboBoxChange:
     )];
     [self.view  addSubview:dateComboBox];
     
     
      checkBoxList =[[FLXSCheckBoxList alloc]initWithFrame:CGRectMake(20, 200, 200, 200)];
     checkBoxList.addAllItem = YES;
   //  [checkBoxList.layer setBorderWidth:2.0];
     //[checkBoxList.layer setBorderColor:[UIColor blueColor].CGColor];
     [checkBoxList addEventListenerOfType:[FLXSDateComboBox EVENT_CHANGE] usingTarget:self withHandler:@selector(onCheckBoxListChange:
     )];
     checkBoxList.dataProviderFLXS = myDataSource;
     
     [self.view  addSubview:checkBoxList];
     
     multiSelectComboBox =[[FLXSMultiSelectComboBox alloc]initWithFrame:CGRectMake(20, 420, 200, 30)];
     multiSelectComboBox.addAllItem = YES;
     [multiSelectComboBox addEventListenerOfType:[FLXSDateComboBox EVENT_CHANGE] usingTarget:self withHandler:@selector(onCheckBoxListChange:
     )];
     multiSelectComboBox.dataProviderFLXS = myDataSource;
     
     [self.view  addSubview:multiSelectComboBox];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)onCheckBoxListChange:(NSNotification*)notification {
//    FLXSEvent *evt = [notification.userInfo valueForKey:@"event"];
//    FLXSCheckBoxList *checkBoxListIn = (FLXSCheckBoxList *)evt.target;

}
- (void)onDateComboBoxChange:(NSNotification*)notification {
//    FLXSEvent *evt = [notification.userInfo valueForKey:@"event"];
//    FLXSDateComboBox *dateComboBox = (FLXSDateComboBox *)evt.target;
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark- Private methods
-(void)initializeTitleOfToolBar{
    // choose whatever width you need instead of 600
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 23)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
    label.textColor =[UIColor whiteColor];
    label.text = @"Home";
    label.font = [UIFont boldSystemFontOfSize:20.0];
    UIBarButtonItem *toolBarTitle = [[UIBarButtonItem alloc] initWithCustomView:label];
    
    // get Toolbar ..
    UIToolbar    *toolbar = (UIToolbar*)[self.view  viewWithTag:100];
    [toolbar    setItems:[NSArray arrayWithObjects:toolBarTitle, nil]];
    
}

@end
