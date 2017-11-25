//
// Created by FLEXICIOUS-MAC on 7/11/13.
// Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "FLXSVersion.h"

#import <Foundation/Foundation.h>


@interface FLXSGridBackground : UIView

@property (nonatomic,strong) NSMutableArray *lines;
@property (nonatomic,strong) NSMutableArray *rectangles;


-(void)addLineWithX1:(float)x1 andY1:(float)y1  andX2:(float)x2 andY2 :(float)y2  andColor:(UIColor* )color  andThickness:(int)thickness;
-(void)addRectWithX:(float)x andY:(float)y  andWidth:(float)width andHeight :(float)h2  andColor:(UIColor* )color  andThickness:(int)thickness;

@end