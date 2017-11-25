//
// Created by FLEXICIOUS-MAC on 7/11/13.
// Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FLXSGridBackground.h"


@implementation FLXSGridBackground {

@private
    NSMutableArray *_lines;
    NSMutableArray *_rectangles;
}
@synthesize lines = _lines;
@synthesize rectangles = _rectangles;
-(id)init
{
    self = [super init];
    if (self)
    {
        ///self.clearsContextBeforeDrawing = YES;
        _lines = [[NSMutableArray alloc] init];
        _rectangles = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)addLineWithX1:(float)x1 andY1 :(float)y1 andX2:(float)x2 andY2:(float)y2 andColor:(UIColor *)color andThickness:(int)thickness {
    [self.lines addObject:[[NSArray alloc] initWithObjects:[NSValue valueWithCGRect:CGRectMake(x1, y1, x2, y2)], color,[NSNumber numberWithInt:thickness],nil]];
    [self setNeedsDisplay];
}

- (void)addRectWithX:(float)x andY :(float)y andWidth:(float)width andHeight:(float)height andColor:(UIColor *)color andThickness:(int)thickness {
    [self.rectangles addObject:[[NSArray alloc] initWithObjects:[NSValue valueWithCGRect:CGRectMake(x, y, width, height)], color,[NSNumber numberWithInt:thickness],nil]];
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
    self.lines = [self.lines.reverseObjectEnumerator.allObjects mutableCopy];
    self.rectangles = [self.rectangles.reverseObjectEnumerator.allObjects mutableCopy] ;

    CGContextRef context = UIGraphicsGetCurrentContext();

    for (NSArray * rectToDraw in self.rectangles){

        CGRect rectInfo = [[rectToDraw objectAtIndex:0] CGRectValue];
        CGColorRef darkColor = [(UIColor *)[rectToDraw objectAtIndex:1] CGColor];
        CGContextSetFillColorWithColor(context, darkColor);
        CGContextFillRect(context, CGRectMake(rectInfo.origin.x, rectInfo.origin.y, rectInfo.size.width, rectInfo.size.height));
    }
    [self.rectangles removeAllObjects];

    for (NSArray * line in self.lines){
        CGRect rectInfo = [[line objectAtIndex:0] CGRectValue];
        CGColorRef darkColor = [(UIColor *)[line objectAtIndex:1] CGColor];
        int thickness = [(NSNumber *)[line objectAtIndex:2] intValue];

        CGContextSetStrokeColorWithColor(context, darkColor);
        CGContextSetLineWidth(context, thickness);
        CGContextMoveToPoint(context,rectInfo.origin.x, rectInfo.origin.y);
        CGContextAddLineToPoint(context, rectInfo.size.width, rectInfo.size.height);
        CGContextStrokePath(context);
    }
    [self.lines removeAllObjects];;
}
@end