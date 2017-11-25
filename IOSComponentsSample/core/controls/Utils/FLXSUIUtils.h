#import "FLXSVersion.h"
@class FLXSEvent;

@interface FLXSUIUtils : NSObject
{
}

+ (BOOL)isPrimitive:(NSString *)input;


//
//+(NSObject*)getObjectProperty:(NSObject*)data :(NSString*)property;
//+(NSString*)labelObjectProperty:(NSObject*)item :(NSObject*)column;
//+(NSString*)concatenateList:(NSArray*)list :(NSString*)propertyName :(NSString*)delimiter;
//+(NSString*)labelObjectPropertyList:(NSObject*)item :(NSObject*)column;
//+(NSString*)dataGridFormatYesNoLabelFunction:(NSObject*)item :(NSObject*)dgColumn;
//+(NSString*)dataGridFormatDateLabelFunction:(NSObject*)item :(NSObject*)dgColumn;
//+(NSString*)dataGridFormatCurrencyLabelFunction:(NSObject*)item :(NSObject*)dgColumn;
//+(NSString*)formatBoolean:(BOOL)val;
//+(NSString*)formatDate:(NSDate*)date :(NSString*)formatString;
//+(NSString*)formatCurrency:(float)val :(NSString*)currencySymbol;

+ (NSObject<UIAppearanceContainer>  *)addPopUpController:(UIViewController *)controller parent:(UIView *)parent modal:(BOOL)modal;

//+(void)addPopUp:(IFlexUIView*)window :(UIView*)parent :(BOOL)modal :(NSString*)childList :(MouseEvent*)triggerEvent :(NSObject*)moduleFactory;
//+(void)positionBelow:(IFlexUIView*)popup :(UIView*)parent :(float)leftOffset :(float)topOffset :(BOOL)offScreenMath :(NSString*)where;
//+(Rectangle*)getScreen:(UIView*)parent;
//+(BOOL)isPrimitive:(id)input;
//+(void)ensureWithinView:(IFlexUIView*)popup :(UIView*)parent;
//+(void)removePopUp:(IFlexUIView*)window;
//+(NSObject*)resolveExpression:(NSObject*)host :(NSString*)expression;
+ (float)average:(NSArray *)dataProvider fld:(NSString *)fld;

//+(int)getLength:(NSObject*)arr;
+ (float)sum:(NSArray *)dataProvider fld:(NSString *)fld;

+ (NSObject *)min:(NSArray *)dataProvider fld:(NSString *)fld comparisonType:(NSString *)comparisonType;

+ (NSObject *)max:(NSArray *)dataProvider fld:(NSString *)fld comparisonType:(NSString *)comparisonType;
+(void)pasteToClipBoard:(NSString*)strToPaste;

//+(BOOL)isStringNumeric:(NSString*)str;
//+(void)onAlertCloseHandler:(CloseEvent*)event;
//+(void)showConfirm:(NSString*)msg :(SEL)result :(NSObject*)callingComponent :(NSString*)title :(int)flags :(Sprite*)parent;
+ (void)showError:(NSString *)errorMessage errorTitle:(NSString *)errorTitle;

+ (void)showMessage:(NSString *)message title:(NSString *)title;

+ (void)showToast:(NSString *)message title:(NSString *)title;
+ (void)showToast:(NSString *)message title:(NSString *)title duration:(int)duration;
//+(void)showValidationErrors:(NSArray*)errors :(NSString*)errorTitle;
//+(void)wrapLables:(Form*)form;
//+(NSMutableArray*)dictionaryToNSMutableArray:(NSObject*)obj;
//+(void)traceData:(NSObject*)obj;
//-(void)applyStyles:(NSArray*)properties :(NSObject*)sourceStyle :(NSObject*)targetStyle;
//+(void)handleError:(NSObject*)event;
+ (NSArray *)removeFromArray:(NSMutableArray *)array itemToRemove:(NSObject *)itemToRemove;

+ (NSObject *)doesArrayContainValue:(NSArray *)array valFld:(NSString *)valFld compareVal:(NSString *)compareVal;

+ (NSObject *)doesArrayContainStringValue:(NSArray *)array compareVal:(NSString *)compareVal;

+ (NSObject *)doesArrayContainObjectValue:(NSArray *)array valueField:(NSString *)valFld compareVal:(NSObject *)compareVal;
+(BOOL)nullOrEmpty:(NSString*)str;

//+(NSString*)getServerUrl;
//+(void)openBrowserPopup:(NSString*)url :(NSString*)options :(BOOL)useNew;
+ (BOOL)areArraysEqual:(NSArray *)a1 array2:(NSArray *)a2;

//+(FLXSClassFactory*)createRenderer:(Class*)renderer :(NSObject*)properties;
//+(NSObject*)getTopLevelApplication;
+ (void)addChild:(UIView *)parent child:(UIView *)child;

+ (void)removeChild:(UIView *)parent child:(UIView *)child;
+(void)removeAllChildren:(UIView*)parent;

+ (NSMutableArray *)extractPropertyValues:(NSArray *)source propertyToExtract:(NSString *)propertyToExtract;
//+(NSString*)toString:(NSObject*)host;
+(NSString*)toPersistenceString:(NSObject*)host;
+(id)fromPersistenceString:(NSString*)host;
//+(XML*)NSMutableArrayToXML:(NSObject*)val;
//+(NSMutableArray*)xmlToNSMutableArray:(XML*)val;
//+(NSObject*)processDeserializedObject:(NSObject*)obj;
//+(NSMutableArray*)getNSMutableArray:(id)val;
//+(FLXSFilter*)createDateFilter:(NSString*)description :(NSString*)fld :(NSString*)dateRange :(NSDate*)start :(NSDate*)end;
//+(FLXSFilter*)createListFilter:(NSString*)description :(NSString*)fld :(NSArray*)values;
//+(NSMutableArray*)getDateRange:(NSString*)val;
//+(NSObject*)getGroupForColumn:(NSObject*)grid :(NSObject*)col;
//+(BOOL)isChildRecursive:(NSObject*)grp :(NSObject*)col;
//+(NSString*)emptyIfNull:(NSObject*)val;
//+(void)transferPrimitiveProps:(NSObject*)from :(NSObject*)to :(NSArray*)propsToExclude;
//+(void)transferProps:(NSObject*)from :(NSObject*)to :(NSArray*)propsToTransfer;
//+(void)transferStyles:(NSObject*)from :(NSObject*)to :(NSArray*)stylesToTransfer;
//+(float)getRandom:(float)minNum :(float)maxNum;
//
//+ (NSObject*)expressionCache;
//+ (int)_openWindowCount;
+(void) raiseExceptionWithType: (NSString*)type andMessage:(NSString *)message;
+ (NSString *)concatenateStrings:(NSString *) firstString, ...;
+(NSString *)checkSelectorSuffix:(NSString*)value :(NSString*)params;
+(UIWindow*) getTopLevelWindow;

+(BOOL)dispatchEvent:(FLXSEvent *)event withSender:(NSObject *) sender;
+(void)removeEventListener:(NSString *)type withTarget:(NSObject *)target andHandler:(SEL)handler andSender:(NSObject *)sender;
+ (NSDictionary *)getClassInfoDictionary:(Class)paramClass;
+ (NSArray *)getClassInfo:(Class)paramClass;

+(void)addEventListenerOfType:(NSString *)type withTarget:(NSObject *)target andHandler:(SEL)handler andSender:(NSObject *)sender;
+(BOOL) isIPad;
+(BOOL)isRunningIOS8OrGreater;
+(UIViewController*)findFileOwnerForComponent:(UIView*)view;



@end



