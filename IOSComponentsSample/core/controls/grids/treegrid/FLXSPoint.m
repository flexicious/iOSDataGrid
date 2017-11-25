//
//  FLXSPoint.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 6/29/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "FLXSPoint.h"

@implementation FLXSPoint
@synthesize x=_x,y=_y;


-(id)initWithX:(float)xValue  andY:(float)yValue{
    
    self = [super  init];
    if (self) {
        self.x = xValue;
        self.y = yValue;
    }
    return self;
}

@end
