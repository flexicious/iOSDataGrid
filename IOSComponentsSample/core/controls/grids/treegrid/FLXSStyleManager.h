#import "FLXSVersion.h"
@class FLXSFlexDataGrid;

@interface FLXSStyleManager : NSObject

@property (nonatomic,strong) NSMutableDictionary * defaultStyles;
@property (nonatomic,strong) NSString *iconFilePrefix;
@property (nonatomic,strong) NSString *gridTheme;

+ (FLXSStyleManager *)instance;

- (UIColor *)getUIColorObjectFromHexString:(unsigned int)hexint;

- (void)applyStylesToGrid:(FLXSFlexDataGrid *)grid;

- (void)applyOfficeBlueStyle:(FLXSFlexDataGrid *)grid;

-(void)applyITunesStyles:(FLXSFlexDataGrid*)grid;

-(void)applyPinkColorfulStyles:(FLXSFlexDataGrid*)grid;

-(void)applyGreenColorfulStyle:(FLXSFlexDataGrid*)grid;

-(void)applyAppleIvoryStyle:(FLXSFlexDataGrid*)grid;

-(void)applyAppleGrayStyle:(FLXSFlexDataGrid*)grid;

-(void)applyAndroidGrayStyle:(FLXSFlexDataGrid*)grid;

-(void) applyOfficeBlackStyle:(FLXSFlexDataGrid*) grid;

-(void) applyOfficeGrayStyle:(FLXSFlexDataGrid*) grid;

-(void) applyIOS7Style:(FLXSFlexDataGrid*) grid;



+(NSString*)FLXS_GRID_THEME_DEFAULT;
+(NSString*)FLXS_GRID_THEME_OFFICE_BLUE;
+(NSString*)FLXS_GRID_THEME_OFFICE_GRAY;
+(NSString*)FLXS_GRID_THEME_OFFICE_BLACK;
+(NSString*)FLXS_GRID_THEME_ANDROID_GRAY;
+(NSString*)FLXS_GRID_THEME_APPLE_GRAY;
+(NSString*)FLXS_GRID_THEME_APPLE_IVORY;
+(NSString*)FLXS_GRID_THEME_GREEN_COLORFUL;
+(NSString*)FLXS_GRID_THEME_PINK_COLORFUL;
+(NSString*)FLXS_GRID_THEME_ITUNES;
+(NSString*)FLXS_GRID_THEME_IOS7;

@end