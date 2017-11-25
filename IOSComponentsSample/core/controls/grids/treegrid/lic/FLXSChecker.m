
#import "FLXSChecker.h"
#import "FLXSEvent.h"
#import "FLXSIEventDispatcher.h"
#import "FLXSUIUtils.h"
#import "FLXSDateUtils.h"
#import "IPhoneLicenseFormViewController.h"
#import <CommonCrypto/CommonCryptor.h>
#import <sys/sysctl.h>
#if TARGET_IPHONE_SIMULATOR
#include <sys/utsname.h>
#endif


static const NSString* version = @"3.0f.0.1303f";
static const NSString* version_date = @"MAY_05_2013";
static const NSString* serverName =@"IOSComponentsSample" ;//next version = NAMES::Servers;
static NSMutableArray* licensedDomains;
static NSObject* licenseCheck;
static NSString *licenseKey;
static NSString *secretKey = @"abracarabra";

@implementation FLXSChecker

@synthesize dispatcher;

-(id)init{
    self=[super init];
    return self;
}

+(BOOL)getIsLocal
{
#ifndef NDEBUG
    return YES;
#endif
    return NO;
}

-(void)validate:(float)port
{
    //next version
    //NSString* str=[Util make10:([Math random[] toString])];
    //str=[Util combine:([Util hash:str]) :str])]
    //    NSString* str=@"004.82316296c8689735f6201a660e95056165e7883";
    //	URLRequest* urlReq=[[URLRequest alloc] init:(@"http://localhost:" + [port toString]+@"?random=" + str;
    //    urlReq1=[[URLRequest alloc] init:(@"http://localhost:" + [port toString]+@"?random=VER_" + version+ @"_" + version_date)];


    //	URLLoader* loader = [[URLLoader alloc] init];
    //	[loader addEventListener:(@"complete") :onComplete :NO :0 :YES];
    //	[loader addEventListener:[HTTPStatusEvent HTTP_STATUS] :httpStatus];
    //	[loader addEventListener:[IOErrorEvent IO_ERROR] :ioErrorHandler];
    //	[loader addEventListener:[SecurityErrorEvent SECURITY_ERROR] :onSecurityError];
    //	[loader load:urlReq];

}

//-(void)onSecurityError:(SecurityErrorEvent*)event
//{
//}

-(void)onComplete:(FLXSEvent*)event
{
    //	NSString* hash = event.target.data;
    //	Array* nums=[Util breakup:hash];
    //	if([Util hash:(nums[0])]!=nums[1])
    //	{
    //		checkFailed=YES;
    //		throw [[Error alloc] init:(@"License hash failed - hashmatch!")];
    //	}
    //	else
    //	{
    //		gotResponse=YES;
    //		//here put code to send lic server what version you are.
    //		URLLoader* loader1 = [[URLLoader alloc] init];
    //		[loader1 addEventListener:(@"complete") :verComplete];
    //		[loader1 addEventListener:[HTTPStatusEvent HTTP_STATUS] :verHttpStatus];
    //		[loader1 addEventListener:[IOErrorEvent IO_ERROR] :verIoError];
    //		[loader1 addEventListener:[SecurityErrorEvent SECURITY_ERROR] :verSecError];
    //		[loader1 load:urlReq1];
    //		IEventDispatcher* lo=(event.currentTarget as IEventDispatcher);
    //		[lo removeEventListener:(@"complete") :onComplete];
    //		[lo removeEventListener:[HTTPStatusEvent HTTP_STATUS] :httpStatus];
    //		[lo removeEventListener:[IOErrorEvent IO_ERROR] :ioErrorHandler];
    //		[lo removeEventListener:[SecurityErrorEvent SECURITY_ERROR] :onSecurityError];
    //	}
}

//-(void)verComplete:(**)e
//{
//	IEventDispatcher* lo=(e.currentTarget as IEventDispatcher);
//	[lo removeEventListener:(@"complete") :verComplete];
//	[lo removeEventListener:[HTTPStatusEvent HTTP_STATUS] :verHttpStatus];
//	[lo removeEventListener:[IOErrorEvent IO_ERROR] :verIoError];
//	[lo removeEventListener:[SecurityErrorEvent SECURITY_ERROR] :verSecError];
//}
//
//-(void)verHttpStatus:(**)e
//{
//}
//
//-(void)verIoError:(**)e
//{
//}
//
//-(void)verSecError:(**)e
//{
//}

//-(void)httpStatus:(HTTPStatusEvent*)e
//{
//	if(attempt<3)
//	{
//		if(e.status>0 && e.status!=200)
//		{
//			attempt++;
//			[self validate:(attempt==2?27446:11634)];
//		}
//	}
//	else
//	{
//		if(!gotResponse)
//		{
//			checkFailed=YES;
//			throw [[Error alloc] init:(@"License not found!")];
//		}
//	}
//}

//-(void)ioErrorHandler:(IOErrorEvent*)event
//{
//	if(!firstFailure && [event.text indexOf:(@"2032")])
//	{
//		firstFailure=YES;
//		checkDone=NO;
//	}
//	else
//	{
//		if(numFailures<2)
//		{
//			numFailures++;
//			[self setTimeout:([self function]:void{[self validate:17723];}) :2000];
//			return;
//		}
//		checkFailed=YES;
//		NSString* err=@"Could not validate license. Please ensure you have the Flexicious Console installed and running. If you do not have the Flexicious Console running, please download it from http://www.flexicious.com/[FlexiciousConsole air] and request a license prior to use. Unauthorized usage of any Flexicious product is illegal and extremely serious. Any attempt to circumvent the license check is also illegal. Application will now exit" + event.type + @";";
//		err+= @"txt:" +  event.text;
//		err+= @"type:" + event.type;
//		err+= @"errorID:" + [event hasOwnProperty:(@"errorID")]?event[@"errorID"]:@"";
//		if(dispatcher && (dispatcher[@"showToaster"]!=nil))
//		{
//			dispatcher[@"showToaster"](err,@"BOTTOM_RIGHT",nil,1000,4000)
//		}
//		[Alert show:err :(@"License not found") :[Alert OK] :nil :([self function:(e:Event)]:void{
//NSString* urlString = @"javascript:window.opener = self; [self close];";
//var request:URLRequest = [[URLRequest alloc] init:urlString];
//[flash.net navigateToURL:request :(@"_self")];
//while(1){
////die.
//};
//})];
//	}
//}

-(id)init:(UIView<FLXSIEventDispatcher>*)val
{
    self = [super init];
    if (self)
    {
        dispatcher=val;
        [self check:val];
    }
    return self;
}

-(void)onTimer:(NSTimer*)sdr{
    [sdr invalidate];
    sdr = nil;

}
-(void)check:(UIView<FLXSIEventDispatcher>*)val
{
    
}
- (void)alertView:(UIAlertView *)alertView
        clickedButtonAtIndex:(NSInteger)buttonIndex{
    while(1){

    }
}+(void)processFault:(NSObject*)response
{


}

-(NSObject*)createLicenseCheck
{
    if(!licenseCheck)
    {
        licenseCheck=[[NSObject alloc] init];
        if(serverName)
        {
            if([ serverName rangeOfString:@";"].location > 0)
            {
                for(NSString* svName in [serverName componentsSeparatedByString:(@";")])
                {
                    [licensedDomains addObject:svName];
                }
            }
            else
            {
                [licensedDomains addObject:serverName];
            }
        }
        NSBundle *bundle = [NSBundle mainBundle];
        NSDictionary *info = [bundle infoDictionary];
        NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
        NSString* url=prodName;
        for(NSString* domain in licensedDomains)
        {
            if(!domain)continue;
            if([[url lowercaseString] rangeOfString:[domain lowercaseString]].location != NSNotFound)
            {
                return licenseCheck;
            }
        }
        UIAlertView *alert = [[UIAlertView alloc]
                initWithTitle:@"Unlicensed Application"
                      message:[NSString stringWithFormat:@"Unlicensed Application!: (%@). You are seeing self message because the Flexicious product is deployed on an Application it is currently not licensed for. If you wish to license self Application, please submit a build request with the correct Application information shown in parantheses at http://www.flexicious.com/Home/RequestBuild. Application will now exit.", url]
                     delegate:self
            cancelButtonTitle:@"OK"
            otherButtonTitles: nil];
        [alert show];

    }
    return licenseCheck;
}

//Checking Degugging License
+(BOOL)isValidDebuggingLicense{
    BOOL isValid = YES;
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"FLXSLicense" ofType:@"txt"];
    if(!licenseKey && [[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        licenseKey = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    }
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
    NSString *bundleidenfier = [info objectForKey:@"CFBundleIdentifier"];
    NSLog(@"ProductName:%@bundleidenfier:%@",prodName,bundleidenfier);
    
    
    if( [prodName caseInsensitiveCompare:@"gcstation"] == NSOrderedSame ) {
        return isValid;
    } else if( [prodName caseInsensitiveCompare:@"golfsalespos"] == NSOrderedSame ) {
        return isValid;
    } else if( [prodName caseInsensitiveCompare:@"IOSComponentsSample"] == NSOrderedSame ) {
        return isValid;
    } else if([bundleidenfier rangeOfString:@"gov.la"].location != NSNotFound) {
        return isValid;
    }
    
    //BOOL iprodName	__NSCFString *	@"IOSComponentsSample"	0x7a78d1d0sDebuggerAttached = [self isDebuggerAttached];
    //NSLog(@"Is debuger attached:%d", isDebuggerAttached);
    if([self isDebuggerAttached]){
        NSString* decryptedUUID = [FLXSChecker decryptUUID:licenseKey];
        NSString *deviceUUID = [FLXSChecker getDeviceName];
        if( !decryptedUUID || [decryptedUUID rangeOfString:deviceUUID].location == NSNotFound){
            NSLog(@"DC:%@",decryptedUUID);
            NSLog(@"DI:%@",deviceUUID);
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"The iOSComponents library is not licensed for debugging on this device. Click this button to send request for a license" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            [alertView show];

            isValid = NO;
        }
    }

    return isValid;
}

+(NSString*)licenseKey{
    return licenseKey;
}

+(NSData*) encryptString:(NSString*)plaintext withKey:(NSString*)key {
    NSData *data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    return [FLXSChecker AES256EncryptWithKey:key data:data];
}

+(NSString*) decryptData:(NSData*)ciphertext withKey:(NSString*)key {
    NSData* decryptedData = [FLXSChecker AES256DecryptWithKey:key encryptedData:ciphertext];
    return [[NSString alloc] initWithData:decryptedData
                                 encoding:NSUTF8StringEncoding];
}

+(NSString*)decryptUUID:(NSString*)encryptedBase64UUID{
    if(encryptedBase64UUID){
        NSData *decodedBase64String = [[NSData alloc] initWithBase64EncodedString:encryptedBase64UUID options:0];
        NSString* decryptedUUID = [FLXSChecker decryptData:decodedBase64String withKey:secretKey];
        return decryptedUUID;
    }
    return nil;
}

+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        //[self showLicenseFormVC];
    }else{
        while (1) {

        }
    }
}

+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [FLXSChecker showLicenseFormVC];
    }
}

+(void)showLicenseFormVC{
    NSString *nibName = @"IPhoneLicenseFormViewController";
    if([FLXSUIUtils isIPad])
        nibName = @"IPadLicenseFormViewController";
    IPhoneLicenseFormViewController* vc = [[IPhoneLicenseFormViewController alloc] initWithNibName:nibName bundle:nil];

    [FLXSUIUtils addPopUpController:vc parent:[UIApplication sharedApplication].delegate.window modal:YES];
}

//Encrypt
+ (NSData *)AES256EncryptWithKey:(NSString *)key data:(NSData*)plainData{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));

    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [plainData length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
            keyPtr, kCCKeySizeAES256,
            NULL /* initialization vector (optional) */,
            [plainData bytes], dataLength, /* input */
            buffer, bufferSize, /* output */
            &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }

    free(buffer);
    return nil;
}

//Decrypt
+ (NSData *)AES256DecryptWithKey:(NSString *)key encryptedData:(NSData*)encryptedData{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));

    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [encryptedData length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
            keyPtr, kCCKeySizeAES256,
            NULL /* initialization vector (optional) */,
            [encryptedData bytes], dataLength, /* input */
            buffer, bufferSize, /* output */
            &numBytesDecrypted);

    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }

    free(buffer);
    return nil;
}

//Checking debugger status
+(BOOL)isDebuggerAttached{
    int                 junk;
    int                 mib[4];
    struct kinfo_proc   info;
    size_t              size;

    info.kp_proc.p_flag = 0;

    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = getpid();

    size = sizeof(info);
    junk = sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0);
    assert(junk == 0);

    return ( (info.kp_proc.p_flag & P_TRACED) != 0 );
}

//Fetch the device UUID
+(NSString*)getDeviceUUID{
    //NSString* deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *UUID = [UIDevice currentDevice].identifierForVendor.UUIDString;

    return UUID;
}
#if TARGET_IPHONE_SIMULATOR
+ (NSString *)getDeviceName {
    struct utsname name = {};
    uname(&name);
    return [NSString stringWithFormat:@"%s", name.nodename];
}
#else
+ (NSString *)getDeviceName {
    return [[UIDevice currentDevice] name];
}
#endif


@end

