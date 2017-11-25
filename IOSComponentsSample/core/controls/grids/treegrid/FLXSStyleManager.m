#import "FLXSStyleManager.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFontInfo.h"

@implementation FLXSStyleManager {
    
@private
    NSMutableDictionary *_defaultStyles;
    NSString *_iconFilePrefix;
    NSString *_gridTheme;
}
@synthesize defaultStyles = _defaultStyles;
@synthesize iconFilePrefix = _iconFilePrefix;
@synthesize gridTheme = _gridTheme;
static FLXSStyleManager *_instance;

 +(NSString*)FLXS_GRID_THEME_DEFAULT
{
    return @"default";
}
+(NSString*)FLXS_GRID_THEME_OFFICE_BLUE
{
    return @"officeBlue";
}
+(NSString*)FLXS_GRID_THEME_OFFICE_GRAY
{
    return @"officeGray";
}
+(NSString*)FLXS_GRID_THEME_OFFICE_BLACK
{
    return @"officeBlack";
}
+(NSString*)FLXS_GRID_THEME_ANDROID_GRAY
{
    return @"androidGray";
}
+(NSString*)FLXS_GRID_THEME_APPLE_GRAY
{
    return @"appleGray";
}
+(NSString*)FLXS_GRID_THEME_APPLE_IVORY
{
    return @"appleIvory";
}
+(NSString*)FLXS_GRID_THEME_GREEN_COLORFUL
{
    return @"greenColorful";
}
+(NSString*)FLXS_GRID_THEME_PINK_COLORFUL
{
    return @"pinkColorful";
}
+(NSString*)FLXS_GRID_THEME_ITUNES
{
    return @"itunes";
}

+(NSString*)FLXS_GRID_THEME_IOS7
{
    return @"IOS7";
}

+(FLXSStyleManager*)instance
{
    if(!_instance){
        _instance     = [[FLXSStyleManager alloc] init];
        _instance.iconFilePrefix = @"FLXSAPPLE";
        _instance.gridTheme = @"officeBlue";
        
    }
    return _instance;
}
- (UIColor *)getUIColorObjectFromHexString:(unsigned int)hexint
{
    
    UIColor *color =
    [UIColor colorWithRed:((float) ((hexint & 0xFF0000) >> 16))/255
                    green:((float) ((hexint & 0xFF00) >> 8))/255
                     blue:((float) (hexint & 0xFF))/255
                    alpha:1];
    
    return color;
}
-(void) applyStylesToGrid:(FLXSFlexDataGrid*) grid{
    self.iconFilePrefix =@"FLXSAPPLE";

    grid.pagerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.footerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.headerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.columnGroupStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];

    grid.columnMoveResizeSeparatorColor = [self getUIColorObjectFromHexString: 0x000000 ];
    grid.columnMoveAlpha =  0.0;
    grid.backgroundColor = [self getUIColorObjectFromHexString: 0xEFF3FA ];
    grid.alternatingItemColors = [[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xEFF3FA],[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    
    grid.alternatingTextColors = [[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0x000000],[self getUIColorObjectFromHexString:0x000000],nil];
    grid.dragAlpha = 0.8;
    grid.dragRowBorderStyle = @"solid";
    grid.editItemColors =  [[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xF5F9FC],[self getUIColorObjectFromHexString:0xC5CED6],nil];
    grid.editTextColor = [self getUIColorObjectFromHexString: 0x000000 ];
    grid.errorBackgroundColor = [self getUIColorObjectFromHexString: 0xFCDCDF ];
    
    grid.errorBorderColor = [self getUIColorObjectFromHexString: 0xF23E2C ];
    grid.verticalGridLineColor = [self getUIColorObjectFromHexString:0x010101];
    grid.verticalGridLines = YES;
    grid.verticalGridLineThickness = 1;
    grid.horizontalGridLineColor = [self getUIColorObjectFromHexString:0x010101];
    grid.horizontalGridLines = YES;
    grid.horizontalGridLineThickness = 1;
    grid.textDisabledColor = [self getUIColorObjectFromHexString:0xAFAFAF];
    grid.columnGroupVerticalGridLineColor = [self getUIColorObjectFromHexString:0x666666];
    grid.columnGroupVerticalGridLines = YES;
    grid.columnGroupVerticalGridLineThickness = 1;
    
    grid.columnGroupHorizontalGridLineColor = [self getUIColorObjectFromHexString:0x666666];
    grid.columnGroupHorizontalGridLines = YES;
    grid.columnGroupHorizontalGridLineThickness = 1;
    grid.columnGroupDrawTopBorder = NO;
    
    grid.headerVerticalGridLineColor = [self getUIColorObjectFromHexString:0x666666];
    grid.headerVerticalGridLines = YES;
    grid.headerVerticalGridLineThickness = 1;
    
    grid.headerHorizontalGridLineColor = [self getUIColorObjectFromHexString:0x666666];
    grid.headerHorizontalGridLines = YES;
    grid.headerHorizontalGridLineThickness = 1;
    grid.headerDrawTopBorder = NO;
    grid.headerSortSeparatorRight = 16;
    
    
    grid.filterVerticalGridLineColor= [self getUIColorObjectFromHexString: 0x666666];
    grid.filterVerticalGridLines = YES;
    grid.filterVerticalGridLineThickness = 1;
    
    grid.filterHorizontalGridLineColor = [self getUIColorObjectFromHexString: 0x666666];
    grid.filterHorizontalGridLines = YES;
    grid.filterHorizontalGridLineThickness= 1;
    grid.filterDrawTopBorder=NO;
    
    grid.footerVerticalGridLineColor=[self getUIColorObjectFromHexString: 0x666666];
    grid.footerVerticalGridLines = YES;
    grid.footerVerticalGridLineThickness = 1;
    
    grid.footerHorizontalGridLineColor=[self getUIColorObjectFromHexString: 0x666666];
    grid.footerHorizontalGridLines = NO;
    grid.footerHorizontalGridLineThickness=1;
    grid.footerDrawTopBorder = NO;
    
    grid.pagerVerticalGridLineColor=[self getUIColorObjectFromHexString: 0x666666];
    grid.pagerVerticalGridLines=YES;
    grid.pagerVerticalGridLineThickness=1;
    
    grid.pagerHorizontalGridLineColor=[self getUIColorObjectFromHexString: 0x666666];
    grid.pagerHorizontalGridLines=YES;
    grid.pagerHorizontalGridLineThickness=1;
    
    
    grid.rendererVerticalGridLineColor=[self getUIColorObjectFromHexString: 0x666666];
    grid.rendererVerticalGridLines=YES;
    grid.rendererVerticalGridLineThickness=1;
    
    grid.rendererHorizontalGridLineColor=[self getUIColorObjectFromHexString: 0x666666];
    grid.rendererHorizontalGridLines =YES;
    grid.rendererHorizontalGridLineThickness=1;
    grid.rendererDrawTopBorder=NO;
    
    grid.rollOverColor=[self getUIColorObjectFromHexString: 0xCEDBEF];
    
    grid.headerRollOverColors= [[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xCEDBEF],[self getUIColorObjectFromHexString: 0xCEDBEF], nil];
    grid.headerColors= [[NSArray alloc] initWithObjects: [self getUIColorObjectFromHexString:0xE6E6E6],[self getUIColorObjectFromHexString: 0xFFFFFF], nil];
    
    grid.columnGroupRollOverColors=[[NSArray alloc] initWithObjects: [self getUIColorObjectFromHexString:0xCEDBEF],[self getUIColorObjectFromHexString: 0xCEDBEF],nil];
    grid.columnGroupColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xE6E6E6],[self getUIColorObjectFromHexString:0xFFFFFF], nil];
    
    grid.footerRollOverColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xCEDBEF],[self getUIColorObjectFromHexString: 0xCEDBEF],nil];
    grid.footerColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xBFBFBF],[self  getUIColorObjectFromHexString: 0xBFBFBF],nil];
    
    grid.fixedColumnFillColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xBFBFBF],[self getUIColorObjectFromHexString:0xBFBFBF],nil];
    
    grid.filterRollOverColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xCEDBEF], [self getUIColorObjectFromHexString:0xCEDBEF], nil];
    grid.filterColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xCFCFCF],[self getUIColorObjectFromHexString: 0xCFCFCF],nil];
    
    grid.activeCellColor=[self getUIColorObjectFromHexString: 0xB7DBFF];
    
    grid.pagerRollOverColors=[[NSArray alloc] initWithObjects:[ self getUIColorObjectFromHexString:0xE6E6E6],[self getUIColorObjectFromHexString: 0xFFFFFF],nil];
    grid.pagerColors=[[NSArray alloc] initWithObjects: [ self getUIColorObjectFromHexString:0xE6E6E6],[self getUIColorObjectFromHexString: 0xFFFFFF],nil];
    
    grid.rendererRollOverColors =[[NSArray alloc] initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self  getUIColorObjectFromHexString: 0xFFFFFF],nil];
    grid.rendererColors=[[NSArray alloc] initWithObjects:[ self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    
    grid.lockedSeparatorColor =[self getUIColorObjectFromHexString: 0x6f6f6f];
    grid.lockedSeparatorThickness = 2,
    
    //    grid.dropIndicatorColor=[self getUIColorObjectFromHexString: 0x000000];
    //grid.dropIndicatorThickness= 2;
    
    grid.textSelectedColor=[self getUIColorObjectFromHexString:0x000000];
    grid.textRollOverColor=[self getUIColorObjectFromHexString:0x000000];
    grid.selectionDisabledColor=nil;
    //    grid.selectionDisabledTextColor=[self getUIColorObjectFromHexString:0xDDDDDD];
    
    grid.disclosureClosedIcon= @"FLXSAPPLE_expandOne.png";
    grid.disclosureOpenIcon= @"FLXSAPPLE_collapseOne.png";
    
    grid.paddingBottomFLXS = 2;
    grid.paddingLeft= 2;
    grid.paddingRight= 2;
    grid.paddingTop= 2;
    
    grid.columnGroupPaddingBottom= 2;
    grid.columnGroupPaddingLeft= 2;
    grid.columnGroupPaddingRight= 2;
    grid.columnGroupPaddingTop= 2;
    
    grid.headerPaddingBottom= 2;
    grid.headerPaddingLeft= 2;
    grid.headerPaddingRight= 2;
    grid.headerPaddingTop= 2;
    
    grid.filterPaddingBottom= 2;
    grid.filterPaddingLeft= 2;
    grid.filterPaddingRight= 2;
    grid.filterPaddingTop= 2;
    
    grid.footerPaddingBottom= 2;
    grid.footerPaddingLeft= 2;
    grid.footerPaddingRight= 2;
    grid.footerPaddingTop= 2;
    
    grid.pagerPaddingBottom= 0;
    grid.pagerPaddingLeft=0;
    grid.pagerPaddingRight= 0;
    grid.pagerPaddingTop= 0;
    grid.rendererPaddingBottom= 2;
    grid.rendererPaddingLeft= 2;
    grid.rendererPaddingRight= 2;
    grid.rendererPaddingTop= 2;
    
    grid.borderSides= [[NSArray alloc] initWithObjects: @"left",@"right",@"top",@"bottom",nil];
    grid.borderThickness=1;
    grid.borderColor=[self getUIColorObjectFromHexString: 0x666666];
    
    grid.pagerStyleName= nil;
    grid.columnGroupClosedIcon= @"/expand.png";
    grid.columnGroupOpenIcon= @"/collapse.png";
    
    grid.multiColumnSortNumberStyleName=@"multiColumnSortNumberStyle";
    grid.multiColumnSortNumberHeight=15;
    grid.multiColumnSortNumberWidth=10;
//    grid.selectionColorFLXS= [self getUIColorObjectFromHexString:0x7FCEFF];
    grid.headerSortSeparatorColor=[self getUIColorObjectFromHexString:0xCCCCCC];

    if([self.gridTheme isEqualToString:[FLXSStyleManager FLXS_GRID_THEME_OFFICE_BLUE]]){
        [self applyOfficeBlueStyle:grid];
    }
    else if([self.gridTheme isEqualToString:[FLXSStyleManager FLXS_GRID_THEME_OFFICE_GRAY]]){
        [self applyOfficeGrayStyle:grid];
    }
    else if([self.gridTheme isEqualToString:[FLXSStyleManager FLXS_GRID_THEME_OFFICE_BLACK]]){
        [self applyOfficeBlackStyle:grid];
    }
    else if([self.gridTheme isEqualToString:[FLXSStyleManager FLXS_GRID_THEME_ANDROID_GRAY]]){
        [self applyAndroidGrayStyle:grid];
    }
    else if([self.gridTheme isEqualToString:[FLXSStyleManager FLXS_GRID_THEME_APPLE_GRAY]]){
        [self applyAppleGrayStyle:grid];
    }
    else if([self.gridTheme isEqualToString:[FLXSStyleManager FLXS_GRID_THEME_APPLE_IVORY]]){
        [self applyAppleIvoryStyle:grid];
    }
    else if([self.gridTheme isEqualToString:[FLXSStyleManager FLXS_GRID_THEME_GREEN_COLORFUL]]){
        [self applyGreenColorfulStyle:grid];
    }
    else if([self.gridTheme isEqualToString:[FLXSStyleManager FLXS_GRID_THEME_PINK_COLORFUL]]){
        [self applyPinkColorfulStyles:grid];
    }
    else if([self.gridTheme isEqualToString:[FLXSStyleManager FLXS_GRID_THEME_ITUNES]]){
        [self applyITunesStyles:grid];
    }
    else if([self.gridTheme isEqualToString:[FLXSStyleManager FLXS_GRID_THEME_IOS7]]){
        [self applyIOS7Style:grid];
    }

    if(![FLXSUIUtils isIPad]){
        //we are iPhone

        grid.filterVisible=NO;
        grid.footerVisible=NO;

    }

}

-(void) applyOfficeBlueStyle:(FLXSFlexDataGrid*) grid{
    self.iconFilePrefix =@"FLXSAPPLE";
    grid.pagerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.footerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.headerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.columnGroupStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];



    grid.rollOverColor=[self getUIColorObjectFromHexString: 0xCEDBEF];
    
    grid.headerRollOverColors= [[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xCEDBEF],[self getUIColorObjectFromHexString: 0xCEDBEF], nil];
    grid.headerColors= [[NSArray alloc] initWithObjects: [self getUIColorObjectFromHexString:0xBDCFEF],[self getUIColorObjectFromHexString: 0xD6E7F7], nil];
    
    grid.columnGroupRollOverColors=[[NSArray alloc] initWithObjects: [self getUIColorObjectFromHexString:0xBDCFEF],[self getUIColorObjectFromHexString: 0xD6E7F7],nil];
    grid.columnGroupColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xBDCFEF],[self getUIColorObjectFromHexString:0xD6E7F7], nil];
    
    grid.footerRollOverColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xBDCFEF],[self getUIColorObjectFromHexString: 0xD6E7F7],nil];
    grid.footerColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xBDCFEF],[self  getUIColorObjectFromHexString: 0xD6E7F7],nil];
    
    grid.fixedColumnFillColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xEFEFEF],[self getUIColorObjectFromHexString:0xEFEFEF],nil];
    
    grid.filterRollOverColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xBDCFEF], [self getUIColorObjectFromHexString:0xD6E7F7], nil];
    grid.filterColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xBDCFEF],[self getUIColorObjectFromHexString: 0xD6E7F7],nil];
    
    grid.activeCellColor=[self getUIColorObjectFromHexString: 0xB7DBFF];
    
    grid.pagerRollOverColors=[[NSArray alloc] initWithObjects:[ self getUIColorObjectFromHexString:0xBDCFEF],[self getUIColorObjectFromHexString: 0xD6E7F7],nil];
    grid.pagerColors=[[NSArray alloc] initWithObjects: [ self getUIColorObjectFromHexString:0xBDCFEF],[self getUIColorObjectFromHexString: 0xD6E7F7],nil];
    
    grid.rendererRollOverColors =[[NSArray alloc] initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self  getUIColorObjectFromHexString: 0xFFFFFF],nil];
    grid.rendererColors=[[NSArray alloc] initWithObjects:[ self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    
    grid.lockedSeparatorColor =[self getUIColorObjectFromHexString: 0x6f6f6f];
    grid.lockedSeparatorThickness = 2,
    
    //    grid.dropIndicatorColor=[self getUIColorObjectFromHexString: 0x000000];
    //grid.dropIndicatorThickness= 2;
    
    grid.textSelectedColor=[self getUIColorObjectFromHexString:0x000000];
    grid.textRollOverColor=[self getUIColorObjectFromHexString:0x000000];
    grid.selectionDisabledColor=nil;
    //    grid.selectionDisabledTextColor=[self getUIColorObjectFromHexString:0xDDDDDD];
    
    grid.disclosureClosedIcon= @"FLXSAPPLE_expandOne.png";
    grid.disclosureOpenIcon= @"FLXSAPPLE_collapseOne.png";

    grid.borderSides= [[NSArray alloc] initWithObjects: @"left",@"right",@"top",@"bottom",nil];
    grid.borderThickness=1;
    grid.borderColor=[self getUIColorObjectFromHexString: 0x666666];
    
    grid.pagerStyleName=nil;

    grid.multiColumnSortNumberStyleName=@"multiColumnSortNumberStyle";
    grid.multiColumnSortNumberHeight=15;
    grid.multiColumnSortNumberWidth=10;
    grid.selectionColorFLXS = [[NSArray alloc] initWithObjects:[ self getUIColorObjectFromHexString:0xFFEFB5],[self getUIColorObjectFromHexString:0xFFDF8C],nil];
    grid.headerSortSeparatorColor=[self getUIColorObjectFromHexString:0xCCCCCC];
    
}
 // from http://www.htmltreegrid.com/demo/Themes.js - see method above for example
-(void) applyOfficeGrayStyle:(FLXSFlexDataGrid*) grid{

    self.iconFilePrefix =@"FLXSAPPLE";
     grid.pagerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
     grid.footerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
     grid.headerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
     grid.columnGroupStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];


     grid.alternatingItemColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xF7F7F7],[self getUIColorObjectFromHexString: 0xE7E7E7], nil];
    grid.alternatingTextColors=[[NSArray alloc]initWithObjects:[self getUIColorObjectFromHexString:0x636163],[self getUIColorObjectFromHexString: 0x636163],nil];
    grid.rollOverColor=[self getUIColorObjectFromHexString: 0xCEDBEF];
    grid.headerRollOverColors = [[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.headerColors=[[NSArray alloc] initWithObjects:[self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.columnGroupRollOverColors= [[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF],[self getUIColorObjectFromHexString: 0xE7E7E7],nil];
    grid.columnGroupColors= [[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString: 0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.pagerRollOverColors=  [[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.pagerColors =  [[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF],[self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.footerRollOverColors=  [[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF],[self getUIColorObjectFromHexString: 0xE7E7E7],nil];
    grid.footerColors=  [[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.filterRollOverColors=  [[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.filterColors=  [[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF],[self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.fixedColumnFillColors=  [[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEFEFEF],[self getUIColorObjectFromHexString:0xEFEFEF],nil];
    grid.activeCellColor=[self getUIColorObjectFromHexString: 0xB7DBFF];
    grid.rendererRollOverColors=  [[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString: 0xFFFFFF],nil];
    grid.rendererColors=  [[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.textSelectedColor=[self getUIColorObjectFromHexString:0x000000];
    grid.textRollOverColor=[self getUIColorObjectFromHexString:0x000000];
    grid.borderColor=[self getUIColorObjectFromHexString: 0x666666];
    grid.selectionColorFLXS =[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFEFB5],[self getUIColorObjectFromHexString:0xFFDF8C], nil];
}
-(void) applyOfficeBlackStyle:(FLXSFlexDataGrid*) grid{
    self.iconFilePrefix =@"FLXSAPPLE";
    grid.alternatingItemColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x3f3f3f], [self getUIColorObjectFromHexString:0x111111],nil];
    grid.alternatingTextColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.rollOverColor=[self getUIColorObjectFromHexString: 0x848684];
    grid.headerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x3f3f3f], [self getUIColorObjectFromHexString:0x111111],nil];
    grid.headerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x3f3f3f],[self getUIColorObjectFromHexString: 0x111111],nil];
    grid.columnGroupRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x3f3f3f],[self getUIColorObjectFromHexString: 0x111111],nil];
    grid.columnGroupColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x3f3f3f], [self getUIColorObjectFromHexString:0x111111],nil];
    grid.pagerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x3f3f3f], [self getUIColorObjectFromHexString:0x111111],nil];
    grid.pagerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x3f3f3f], [self getUIColorObjectFromHexString:0x111111],nil];
    grid.footerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x3f3f3f],[self getUIColorObjectFromHexString: 0x111111],nil];
    grid.footerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x3f3f3f],[self getUIColorObjectFromHexString: 0x111111],nil];
    grid.filterRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x3f3f3f],[self getUIColorObjectFromHexString: 0x111111],nil];
    grid.filterColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x3f3f3f],[self getUIColorObjectFromHexString:0x111111],nil];
    grid.fixedColumnFillColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEFEFEF],[self getUIColorObjectFromHexString:0xEFEFEF],nil];
    grid.activeCellColor=[self getUIColorObjectFromHexString: 0x6f6f6f];
    grid.textSelectedColor=[self getUIColorObjectFromHexString:0x000000];
    grid.textRollOverColor=[self getUIColorObjectFromHexString:0x000000];
    grid.borderColor=[self getUIColorObjectFromHexString: 0x666666];
    grid.selectionColorFLXS =[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFEFB5],[self getUIColorObjectFromHexString:0xFFDF8C],nil];
    grid.headerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
    grid.footerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
    grid.columnGroupStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
    grid.pagerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
}
-(void)applyAndroidGrayStyle:(FLXSFlexDataGrid*)grid{
    /**
     * Usually the toolbar root is the same as the images root, but for some custom themes, we have their own icons.
     */
      self.iconFilePrefix =@"FLXSAPPLE";
    grid.alternatingItemColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFCF5],nil];
    grid.alternatingTextColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x000000], [self getUIColorObjectFromHexString:0x000000],nil];
    grid.rollOverColor=[self getUIColorObjectFromHexString: 0xCEDBEF];
    grid.headerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x1C1E1D], [self getUIColorObjectFromHexString:0x3A3B3D],nil];
    grid.headerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x1C1E1D], [self getUIColorObjectFromHexString:0x3A3B3D],nil];
grid.headerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
    grid.columnGroupRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x1C1E1D], [self getUIColorObjectFromHexString:0x3A3B3D],nil];
    grid.columnGroupColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x1C1E1D], [self getUIColorObjectFromHexString:0x3A3B3D],nil];
grid.columnGroupStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
    grid.pagerDrawTopBorder=YES;
    grid.pagerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x1C1E1D], [self getUIColorObjectFromHexString:0x3A3B3D] ,nil];
    grid.pagerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x1C1E1D], [self getUIColorObjectFromHexString:0x3A3B3D] ,nil];
    grid.pagerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];    grid.footerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x1C1E1D], [self getUIColorObjectFromHexString:0x3A3B3D] ,nil];
    grid.footerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x1C1E1D], [self getUIColorObjectFromHexString:0x3A3B3D],nil];
    grid.footerDrawTopBorder=YES;
    grid.footerVerticalGridLines=YES;
    grid.footerHorizontalGridLines=YES;
    grid.footerHorizontalGridLineColor=[self getUIColorObjectFromHexString: 0xFABB39];
    grid.footerHorizontalGridLineThickness=2;  
    grid.filterPaddingBottom= 4;
    grid.filterRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x1C1E1D],[self getUIColorObjectFromHexString: 0x3A3B3D],nil];
    grid.filterColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x1C1E1D], [self getUIColorObjectFromHexString:0x3A3B3D] ,nil];
    grid.filterHorizontalGridLineColor=[self getUIColorObjectFromHexString: 0xFABB39];
    grid.filterHorizontalGridLines=YES;
    grid.filterHorizontalGridLineThickness=2;
    grid.filterDrawTopBorder=YES;
    grid.fixedColumnFillColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEFEFEF],[self getUIColorObjectFromHexString:0xEFEFEF],nil];
    grid.activeCellColor=[self getUIColorObjectFromHexString: 0xB7DBFF];
    grid.rendererRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString: 0xFFFFFF],nil];
    grid.rendererColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.textSelectedColor=[self getUIColorObjectFromHexString:0x000000];
    grid.textRollOverColor=[self getUIColorObjectFromHexString:0x000000];
    grid.borderColor=[self getUIColorObjectFromHexString: 0x666666];
grid.footerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
    grid.pagerHorizontalGridLineColor=[self getUIColorObjectFromHexString: 0xFABB39];
    grid.pagerHorizontalGridLines=YES;
    grid.pagerHorizontalGridLineThickness=4;
    grid.pagerDrawTopBorder=YES;
    grid.pagerVerticalGridLines=YES;
    grid.pagerVerticalGridLineThickness=4;
    grid.pagerVerticalGridLineColor=[self getUIColorObjectFromHexString: 0xFABB39];
    grid.selectionColorFLXS =[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFABB39],[self getUIColorObjectFromHexString:0xCD4602], nil];
}

-(void)applyIOS7Style:(FLXSFlexDataGrid*)grid{

    self.iconFilePrefix =@"FLXS_iOS7";
    grid.backgroundColor = [UIColor clearColor];

    grid.enableMultiColumnSort = NO;
    grid.enableSplitHeader=NO;
    grid.filterPaddingLeft=5;
    grid.filterPaddingRight=5;
    grid.filterPaddingTop=5;
    grid.filterPaddingBottom=5;

    grid.alternatingItemColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.alternatingTextColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x000000], [self getUIColorObjectFromHexString:0x000000],nil];

    grid.headerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString:0xFFFFFF] ,[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.headerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor blackColor]];

    grid.headerHorizontalGridLines=NO;

    grid.columnGroupStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor blackColor]];
    grid.columnGroupColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.columnGroupHorizontalGridLineColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.columnGroupHorizontalGridLines= YES;
    grid.columnGroupDrawTopBorder= YES;
    grid.columnGroupVerticalGridLines= YES;



    grid.pagerDrawTopBorder= YES;
    grid.footerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x333333], [self getUIColorObjectFromHexString:0x333333],nil];
    grid.footerDrawTopBorder=YES;
    grid.footerVerticalGridLines= YES;
    grid.footerHorizontalGridLines= YES;
    grid.footerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFFFF] ,nil];

    grid.filterColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFFFF] ,nil];
    grid.filterHorizontalGridLineColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.filterHorizontalGridLines=YES;
    grid.filterHorizontalGridLineThickness=1;
    grid.filterDrawTopBorder= NO;
    grid.filterVerticalGridLines=YES;

    grid.fixedColumnFillColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xe52929],[self getUIColorObjectFromHexString:0xe52929],nil];
    grid.activeCellColor=[self getUIColorObjectFromHexString: 0xe52929];
    grid.rendererColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xe52929],[self getUIColorObjectFromHexString:0xe52929],nil];
    grid.textSelectedColor=[self getUIColorObjectFromHexString:0x000000];
    grid.borderColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.footerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor blackColor]];

    //Start Pager
    grid.pagerHorizontalGridLineColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.pagerHorizontalGridLines=YES;
    grid.pagerHorizontalGridLineThickness=1;
    grid.pagerVerticalGridLines= YES;
    grid.pagerVerticalGridLineColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.pagerStyleName = [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor blackColor]];
    grid.pagerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFFFF],nil];
    //End Pager

    grid.headerHorizontalGridLines=YES;
    grid.headerVerticalGridLines= YES;
    grid.verticalGridLines= YES;
    grid.horizontalGridLineColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.verticalGridLineColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.headerHorizontalGridLineColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.headerVerticalGridLineColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.columnGroupHorizontalGridLineColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.columnGroupVerticalGridLineColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.headerSortSeparatorColor=[self getUIColorObjectFromHexString: 0x999999];
    grid.selectionColorFLXS =[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xe52929],[self getUIColorObjectFromHexString:0xe52929], nil];
    grid.horizontalGridLines=YES;
    grid.textSelectedColor= [UIColor whiteColor];
    grid.footerDrawTopBorder=NO;
    grid.pagerDrawTopBorder=NO;
}



-(void)applyAppleGrayStyle:(FLXSFlexDataGrid*)grid{
    self.iconFilePrefix =@"FLXS_iOSBLUE";


    grid.pagerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];

    grid.alternatingItemColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF9F9F9], [self getUIColorObjectFromHexString:0xF3F3F3],nil];
    grid.alternatingTextColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x111111], [self getUIColorObjectFromHexString:0x111111],nil];
    grid.rollOverColor=[self getUIColorObjectFromHexString: 0xCEDBEF];
    grid.headerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.headerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF2F2F4], [self getUIColorObjectFromHexString:0x9898A4],nil];
    grid.columnGroupRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.columnGroupColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF2F2F4], [self getUIColorObjectFromHexString:0x9898A4],nil];
    grid.pagerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.pagerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x908F9D], [self getUIColorObjectFromHexString:0x12122C],nil];
    grid.footerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.footerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x908F9D], [self getUIColorObjectFromHexString:0x12122C],nil];
grid.footerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
    grid.filterRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF],[self getUIColorObjectFromHexString: 0xE7E7E7],nil];
    grid.filterColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x908F9D],[self getUIColorObjectFromHexString: 0x12122C],nil];
grid.footerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
    grid.fixedColumnFillColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEFEFEF],[self getUIColorObjectFromHexString:0xEFEFEF],nil];
    grid.activeCellColor=[self getUIColorObjectFromHexString: 0xB7DBFF];
    grid.rendererRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.rendererColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.textSelectedColor=[self getUIColorObjectFromHexString:0x000000];
    grid.textRollOverColor=[self getUIColorObjectFromHexString:0x000000];
    grid.borderColor=[self getUIColorObjectFromHexString: 0x666666];
    grid.selectionColorFLXS =[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xC7C8CD],[self getUIColorObjectFromHexString:0xC7C8CD], nil];
}
-(void)applyAppleIvoryStyle:(FLXSFlexDataGrid*)grid
{
    self.iconFilePrefix =@"FLXS_iOSBLACK";

    grid.pagerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.footerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.headerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.columnGroupStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];


    grid.alternatingItemColors =[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEFF0F2], [self getUIColorObjectFromHexString:0xF1F1F1],nil];
    grid.alternatingTextColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x020202], [self getUIColorObjectFromHexString:0x020202],nil];
    grid.rollOverColor=[self getUIColorObjectFromHexString: 0x9E9E9E];
    grid.headerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.headerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF],[self getUIColorObjectFromHexString: 0xE7E7E7 ],nil];
    grid.columnGroupRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFEFEFE], [self getUIColorObjectFromHexString:0xECEDEF],nil];
    grid.columnGroupColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFEFEFE], [self getUIColorObjectFromHexString:0xECEDEF],nil];
    grid.pagerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.pagerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xECEDEF],[self getUIColorObjectFromHexString: 0xF1F1F1],nil];
    grid.footerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF],[self getUIColorObjectFromHexString: 0xE7E7E7],nil];
    grid.footerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFEFEFE],[self getUIColorObjectFromHexString: 0xECEDEF],nil];
    grid.selectionColorFLXS =[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xB5B5B5],[self getUIColorObjectFromHexString:0xB5B5B5],nil];
    grid.filterRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.filterColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFEFEFE], [self getUIColorObjectFromHexString:0xECEDEF],nil];
    grid.fixedColumnFillColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEFEFEF],[self getUIColorObjectFromHexString:0xEFEFEF],nil];
    grid.activeCellColor=[self getUIColorObjectFromHexString: 0x9E9E9E];
    grid.rendererRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.rendererColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.textSelectedColor=[self getUIColorObjectFromHexString:0x000000];
    grid.textRollOverColor=[self getUIColorObjectFromHexString:0x000000];
    grid.borderColor=[self getUIColorObjectFromHexString: 0x666666];
}
-(void)applyGreenColorfulStyle:(FLXSFlexDataGrid*)grid
{
    self.iconFilePrefix =@"FLXSAPPLE";

    grid.pagerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.footerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.headerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];
    grid.columnGroupStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor darkGrayColor]];


    grid.alternatingItemColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xB7F5F4],[self getUIColorObjectFromHexString: 0xDAFAF9],nil];
    grid.alternatingTextColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x111111], [self getUIColorObjectFromHexString:0x111111],nil];
    grid.rollOverColor=[self getUIColorObjectFromHexString:0xF7F7EF];
    grid.headerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEBE27D], [self getUIColorObjectFromHexString:0xDFCD4D] ,nil];
    grid.headerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEBE27D], [self getUIColorObjectFromHexString:0xDFCD4D],nil];
    grid.columnGroupRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEBE27D], [self getUIColorObjectFromHexString:0xDFCD4D],nil];
    grid.columnGroupColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEBE27D], [self getUIColorObjectFromHexString:0xDFCD4D],nil];
    grid.pagerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.pagerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x75B837], [self getUIColorObjectFromHexString:0x5F9929],nil];
    grid.footerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF],[self getUIColorObjectFromHexString: 0xE7E7E7],nil];
    grid.footerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x75B837], [self getUIColorObjectFromHexString:0x5F9929] ,nil];
    grid.filterRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF],[self getUIColorObjectFromHexString: 0xE7E7E7],nil];
    grid.filterColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F4C1], [self getUIColorObjectFromHexString:0xF9F3BF],nil];
    grid.fixedColumnFillColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEFEFEF],[self getUIColorObjectFromHexString:0xEFEFEF],nil];
    grid.activeCellColor=[self getUIColorObjectFromHexString: 0xB7DBFF];
    grid.rendererRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.rendererColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.textSelectedColor=[self getUIColorObjectFromHexString:0x000000];
    grid.textRollOverColor=[self getUIColorObjectFromHexString:0x000000];
    grid.borderColor=[self getUIColorObjectFromHexString: 0x666666];
}
-(void)applyPinkColorfulStyles:(FLXSFlexDataGrid*)grid{
    self.iconFilePrefix =@"FLXSAPPLE";

    grid.pagerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];grid.headerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
    grid.columnGroupStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
    grid.footerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];

    grid.alternatingItemColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xE7BEFA], [self getUIColorObjectFromHexString:0xF3DEFD ],nil];
    grid.alternatingTextColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x111111], [self getUIColorObjectFromHexString:0x111111],nil];
    grid.rollOverColor=[self getUIColorObjectFromHexString: 0xCEDBEF];
    grid.headerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x9F73E6], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.headerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x9F73E6], [self getUIColorObjectFromHexString:0x402A58],nil];
    grid.columnGroupRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x9B6FE0], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.columnGroupColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x986CDB], [self getUIColorObjectFromHexString:0x402A58],nil];
    grid.pagerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x268CD4],[self getUIColorObjectFromHexString: 0x092940],nil];
    grid.pagerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x268CD4 ], [self getUIColorObjectFromHexString:0x092940],nil];
    grid.footerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x268CD4], [self getUIColorObjectFromHexString:0xE7E7E7],nil];
    grid.footerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x268CD4 ], [self getUIColorObjectFromHexString:0x092940],nil];
    grid.filterRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F7EF],[self getUIColorObjectFromHexString: 0xE7E7E7],nil];
    grid.filterColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xF7F4C1],[self getUIColorObjectFromHexString: 0xF7F6C0],nil];
    grid.fixedColumnFillColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEFEFEF],[self getUIColorObjectFromHexString:0xEFEFEF],nil];
    grid.activeCellColor=[self getUIColorObjectFromHexString: 0xB7DBFF];
    grid.rendererRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.rendererColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.textSelectedColor=[self getUIColorObjectFromHexString:0x000000];
    grid.textRollOverColor=[self getUIColorObjectFromHexString:0x000000];
    grid.borderColor=[self getUIColorObjectFromHexString: 0x666666];
}
-(void)applyITunesStyles:(FLXSFlexDataGrid*)grid{
    self.iconFilePrefix =@"FLXSAPPLE";

    grid.pagerStyleName= [[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];grid.headerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
grid.columnGroupStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
grid.footerStyleName=[[FLXSFontInfo alloc] initWithFontName:nil andPointSize:nil andTextColor:[UIColor whiteColor]];
    grid.alternatingItemColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xD8DAD9], [self getUIColorObjectFromHexString:0xD8DAD9],nil];
    grid.alternatingTextColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x111111], [self getUIColorObjectFromHexString:0x111111],nil];
    grid.selectionColorFLXS =[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEAF1F9],[self getUIColorObjectFromHexString:0xEFF6FF],nil];
    grid.rollOverColor=[self getUIColorObjectFromHexString: 0xEDF4FE];
    grid.headerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x616169], [self getUIColorObjectFromHexString:0x9598A1],nil];
    grid.headerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x616169], [self getUIColorObjectFromHexString:0x9598A1],nil];
    grid.columnGroupRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x616169], [self getUIColorObjectFromHexString:0x9598A1],nil];
    grid.columnGroupColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x616169], [self getUIColorObjectFromHexString:0x9598A1],nil];
    grid.pagerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x616169], [self getUIColorObjectFromHexString:0x9598A1],nil];
    grid.pagerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x616169], [self getUIColorObjectFromHexString:0x9598A1],nil];
    grid.footerRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x616169], [self getUIColorObjectFromHexString:0x9598A1],nil];
    grid.footerColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x616169], [self getUIColorObjectFromHexString:0x9598A1],nil];
    grid.filterRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x616169],[self getUIColorObjectFromHexString: 0x9598A1],nil];
    grid.filterColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0x33342F], [self getUIColorObjectFromHexString:0x363435],nil];
    grid.fixedColumnFillColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xEFEFEF],[self getUIColorObjectFromHexString:0xEFEFEF],nil];
    grid.activeCellColor=[self getUIColorObjectFromHexString: 0xB7DBFF];
    grid.rendererRollOverColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF], [self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.rendererColors=[[NSArray alloc]initWithObjects: [self getUIColorObjectFromHexString:0xFFFFFF],[self getUIColorObjectFromHexString:0xFFFFFF],nil];
    grid.textSelectedColor=[self getUIColorObjectFromHexString:0x000000];
    grid.textRollOverColor=[self getUIColorObjectFromHexString:0x000000];
    grid.borderColor=[self getUIColorObjectFromHexString: 0x666666];

}


@end