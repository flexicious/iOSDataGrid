#import "FLXSVersion.h"

@interface FLXSFontInfo : NSObject

@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, assign) int pointSize;
@property (nonatomic, strong) UIColor * textColor;

-(void) applyFont:(UILabel *)lbl;
-(id)initWithFontName:(NSString *)fontName andPointSize:(NSNumber *)pointSize andTextColor:(UIColor *)uiColor;
@end