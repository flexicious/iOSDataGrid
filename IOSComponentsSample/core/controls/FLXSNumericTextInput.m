//
// Created by FLEXICIOUS-MAC on 7/16/13.
// Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FLXSNumericTextInput.h"


@implementation FLXSNumericTextInput {

}

- (void)_init {
    [super _init];
    self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}
-(void)setText:(NSString *)text {
    if(![text isKindOfClass:[NSString class] ]){
        text = [text description];
    }
    [super setText:text];
}
@end