//
//  IPhoneLicenseFormViewController.m
//  IOSComponentsSample
//
//  Created by Harigharan on 12/08/14.
//  Copyright (c) 2014 ___IOSComponents___. All rights reserved.
//

#import "IPhoneLicenseFormViewController.h"
#if TARGET_IPHONE_SIMULATOR
#include <sys/utsname.h>
#endif


@interface IPhoneLicenseFormViewController (){
    UIAlertView *alertView;
}

@end

@implementation IPhoneLicenseFormViewController

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
}

// Hides the keyboard when the return key is touched
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    if( sender.tag >=1 && sender.tag < 5){
        UIResponder* nextResponder = [sender.superview viewWithTag:sender.tag+1];
        if (nextResponder) {
            // next responder, so set it.
            [nextResponder becomeFirstResponder];
        } else {
            [sender resignFirstResponder];
            
        }
    }else {
        [sender resignFirstResponder];
        
    }
    return YES;
}

#if TARGET_IPHONE_SIMULATOR
- (NSString *)getDeviceName {
    struct utsname name = {};
    uname(&name);
    return [NSString stringWithFormat:@"%s", name.nodename];
}
#else
- (NSString *)getDeviceName {
    return [[UIDevice currentDevice] name];
}
#endif

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:YES];
}

- (IBAction)submit:(id)sender {
    
    if([self isTextFieldBlank:self.companyNameTF.text]){
        [self showAlertWithTitle:@"Info" message:@"Company name is empty" delegate:nil cancelButton:@"Ok" otherCancelButton:nil tag:0];
        return;
    }
    if([self isTextFieldBlank:self.developerNameTF.text]){
        [self showAlertWithTitle:@"Info" message:@"Developer name is empty" delegate:nil cancelButton:@"Ok" otherCancelButton:nil tag:0];
        return;
    }
    if([self isTextFieldBlank:self.developerEmailTF.text]){
        [self showAlertWithTitle:@"Info" message:@"Developer email is empty" delegate:nil cancelButton:@"Ok" otherCancelButton:nil tag:0];
        return;
    }
//    if([self isTextFieldBlank:self.flexVersionTF.text]){
//        [self showAlertWithTitle:@"Info" message:@"Flex version is empty" delegate:nil cancelButton:@"Ok" otherCancelButton:nil tag:0];
//        return;
//    }
    if([self isTextFieldBlank:self.purchaseReferenceTF.text]){
        [self showAlertWithTitle:@"Info" message:@"Purchase Reference is empty" delegate:nil cancelButton:@"Ok" otherCancelButton:nil tag:0];
        return;
    }
    long long secondsInUtc = [[NSDate date] timeIntervalSince1970];
    NSNumber *currenttimeInSec = [NSNumber numberWithLongLong:secondsInUtc];
    
    //NSDictionary* postParameter = @{@"Time:": currenttimeInSec, @"User Name:": self.developerNameTF.text,@"User Email:":self.developerEmailTF.text, @"Company:":self.companyNameTF.text, @"UUID:":[[[UIDevice currentDevice] identifierForVendor] UUIDString], @"Purchase Reference:": self.purchaseReferenceTF.text};
    NSString *time = [@"Time:" stringByAppendingString:currenttimeInSec.stringValue];
    NSString *userName = [@"UserName:" stringByAppendingString:self.developerNameTF.text];
    NSString *userEmail = [@"UserEmail:" stringByAppendingString:self.developerEmailTF.text];
    NSString *company = [@"Company:" stringByAppendingString:self.companyNameTF.text];
    NSString *UUID = [@"UUID:" stringByAppendingString:[self getDeviceName]];
    NSString *purchaseReference = [@"PurchaseReference:" stringByAppendingString:self.purchaseReferenceTF.text];
    //NSString *post = @"Time=val1&key2=val2";
//    NSString *post = [time stringByAppendingString:userName stringByAppendingString:userEmail stringByAppendingString:company stringByAppendingString:UUID stringByAppendingString:purchaseReference stringByAppendingString:purchaseReference];
    NSString *postParameter = [@[time, userName, userEmail, company, UUID, purchaseReference] componentsJoinedByString:@"\n"];
    //NSString *postString = [NSString stringWithFormat:@"Time:%@\r\nUser Name:%@\r\nUser Email:%@\r\nCompany:%@\r\nUUID:%@\r\nVersion:%@\r\nPurchase Reference:%@\r\n", currenttimeInSec, self.developerNameTF.text, self.developerEmailTF.text,self.companyNameTF.text,[[[UIDevice currentDevice] identifierForVendor] UUIDString], self.flexVersionTF.text, self.purchaseReferenceTF.text];
    [[self view] endEditing:YES];
    postParameter= [@"data=" stringByAppendingString:postParameter];
    NSLog(@"Post string:%@", postParameter);
    [self requestLicense:postParameter];
}

-(void)requestLicense:(NSString*)postParameter{
    //NSError* error;
    //NSData *postData = [NSJSONSerialization dataWithJSONObject:postParameter options:NSJSONWritingPrettyPrinted error:&error];
    NSData *postData = [postParameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://www.flexicious.com/Home/LicenseRequest"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];

    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if(connection)
        NSLog(@"Request send");
    else
        NSLog(@"Request not send");
    
    [self showAlertWithTitle:@"Info" message:@"The iOSComponents library is not licensed for debugging on this device." delegate:self cancelButton:nil otherCancelButton:@"Ok" tag:10];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView1{
    if(alertView1.tag == 10)
        return NO;
    else
        return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"License response:%@",result);
    
    [self showAlertWithTitle:@"Info" message:@"Request Sent successfully, once your account information is validated, an email with the license file will be sent to your registered email address. Once you get the license file, place it in the root folder of your app, next to your main storyboard. Once license file is placed, please relaunch the app. Application will now exit." delegate:self cancelButton:nil otherCancelButton:@"Ok" tag:10];
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [self showAlertWithTitle:@"Info" message:@"Could not send request" delegate:self cancelButton:nil otherCancelButton:@"Ok" tag:0];
    
}



// Validates that the text field is not blank
- (BOOL)isTextFieldBlank:(NSString *)textField {
    BOOL textFieldBlank = YES;
    
    if ([textField stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] != nil && ![[textField stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        
        textFieldBlank = NO;
    }
    return textFieldBlank;
}

-(void)showAlertWithTitle:(NSString*)title message:(NSString*)message delegate:(id)delegate cancelButton:(NSString*)cancelbutton otherCancelButton:(NSString*)otherButtontitle tag:(NSInteger)tag {
    
    if(alertView){
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        alertView = nil;
    }
    
    alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelbutton otherButtonTitles:otherButtontitle, nil];
    alertView.tag = tag;
    [alertView show];
}

@end
