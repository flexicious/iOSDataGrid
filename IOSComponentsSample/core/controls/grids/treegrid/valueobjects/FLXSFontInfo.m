//
// Created by FLEXICIOUS-MAC on 7/21/13.
// Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FLXSFontInfo.h"


@implementation FLXSFontInfo {

@private
    NSString *_fontName;
    int _pointSize;
    UIColor *_textColor;
}
@synthesize fontName = _fontName;
@synthesize pointSize = _pointSize;
@synthesize textColor = _textColor;

-(id)init {
    self = [super init];

    return self;
}
- (void)applyFont:(UILabel *)lbl {
    UIFont * font = lbl.font;
    if(self.fontName){
        font = [UIFont fontWithName:self.fontName size:font.pointSize];
    }
    if(self.pointSize >0){
        font = [UIFont fontWithName:font.fontName size:self.pointSize];
    }
    [lbl setFont:font];
    if(self.textColor != nil){
        lbl.textColor = self.textColor;
    }

}

- (id)initWithFontName:(NSString *)fontName andPointSize :(NSNumber *)pointSize andTextColor:(UIColor *)uiColor {
    self = [super init];
    if(self){
        self.fontName = fontName;
        self.pointSize = [pointSize intValue];
        self.textColor = uiColor;
    }

    return self;
}


@end