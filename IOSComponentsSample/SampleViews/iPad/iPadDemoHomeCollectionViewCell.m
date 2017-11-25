#import "iPadDemoHomeCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>



@implementation iPadDemoHomeCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 3.0f;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowRadius = 3.0f;
        self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
        self.layer.shadowOpacity = 0.5f;
        //make sure we rasterize nicely for retina
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 0, 288, 260)];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];

        self.cellTitle =[[UILabel    alloc]initWithFrame:CGRectMake(20, 290, 268, 60)];
        self.cellTitle.numberOfLines = 0;
        self.cellTitle.textAlignment = NSTextAlignmentLeft;

        self.cellTitle.backgroundColor  = [UIColor  clearColor];
        [self.contentView   addSubview:self.cellTitle];

        self.cellDescription =[[UILabel    alloc]initWithFrame:CGRectMake(20, 300 , 268, 100)];
        self.cellDescription.numberOfLines = 0;
        self.cellDescription.textAlignment = NSTextAlignmentLeft;
        self.cellDescription.backgroundColor  = [UIColor  clearColor];
        [self.contentView   addSubview:self.cellDescription];
    }
    return self;
}


- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.imageView.image = nil;
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
