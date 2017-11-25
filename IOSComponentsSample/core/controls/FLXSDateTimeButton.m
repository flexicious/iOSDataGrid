//
//  FLXSDateTimeButton.m
//  IOSComponentsSample
//
//  Created by FLEXICIOUS-MAC on 6/17/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "FLXSDateTimeButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation FLXSDateTimeButton
@synthesize dtAttibute, buttonMode;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[self layer] setBorderColor:[[UIColor grayColor] CGColor]];
        [[self layer] setBorderWidth:1.0];
        [[self layer] setCornerRadius:8];
        [self.titleLabel setFont:[UIFont fontWithName:@"System" size:10]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
    
}


- (void)awakeFromNib;
{
    
    self.layer.cornerRadius = 10.0;
    self.layer.borderColor = [UIColor colorWithRed:0.52f
                                             green:0.52f
                                              blue:0.52f
                                             alpha:1.0].CGColor;
    self.layer.borderWidth = 1.0f;
//    self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
//    self.layer.shadowOpacity = 1.5f;
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowRadius = 2.5f;
//    self.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
   /* CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.anchorPoint = CGPointMake(0.0f, 0.0f);
    gradient.position = CGPointMake(0.0f, 0.0f);
    gradient.bounds = self.layer.bounds;
    gradient.cornerRadius = 10.0;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:0.82f
                                           green:0.82f
                                            blue:0.82f
                                           alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:0.52f
                                           green:0.52f
                                            blue:0.52f
                                           alpha:1.0].CGColor,
                       nil];
    
    CAGradientLayer *shineLayer = [CAGradientLayer layer];
    shineLayer.frame = gradient.bounds;
    shineLayer.cornerRadius = 10.0;
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         nil];
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    
    [gradient addSublayer:shineLayer];
    
    [self.layer addSublayer:gradient];
    */
}

-(id)init{
    self =[super    init];
    if (self) {
        // Initialization code
        [self   _init];
    }
    return self;
}

-(void)_init{
    [[self layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self layer] setBorderWidth:1.0];
    [[self layer] setCornerRadius:8];
    [self.titleLabel setFont:[UIFont fontWithName:@"System" size:10]];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self   _init];
    }
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
