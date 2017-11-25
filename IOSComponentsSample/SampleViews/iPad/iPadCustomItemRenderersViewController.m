

#import "iPadCustomItemRenderersViewController.h"
#import "FLXSFlexiciousMockGenerator.h"

@interface iPadCustomItemRenderersViewController (){
}

@end

@implementation iPadCustomItemRenderersViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.flxsDataGrid.delegate = self;
    
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSItemRenderers"];
    [self initializeTitleOfToolBar : @"Custom Item Renderers"];

    self.flxsDataGrid.dataProviderFLXS = [[FLXSFlexiciousMockGenerator instance] getDeepOrgList];
}

-(void)ItemRenderers_grid_itemClickHandler:(NSNotification*)ns
{
}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end


@interface ItemRenderers_HyperLinkRenderer : UIButton
@property (nonatomic,assign) id data;
@end
@implementation ItemRenderers_HyperLinkRenderer
- (id)init {
    self = [super init];
    if(self){
    }
    return self;
}
-(void)setData:(id)data {
    _data=data;
    [self setTitle:@"View Link" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    //here we can do custom work to configure our renderer
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    FLXSOrganization * org = (FLXSOrganization *)self.data;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"http://www.google.com?q=" stringByAppendingString:org.legalName]]];
}
@end


@interface ItemRenderers_StockChartImage : UIImageView
@property (nonatomic,assign) id data;
@end
@implementation ItemRenderers_StockChartImage
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){

    }
    return self;
}

-(void)setData:(id)data {
    _data=data;
    FLXSOrganization * org = (FLXSOrganization *)self.data;
    //here we can do custom work to configure our renderer
    //in this case we are loading image. We do this asynchronously to avoid
    //delays while scrolling.
    __weak NSURL *url = [NSURL URLWithString:org.chartUrl];
    __weak UIImageView* blockSafeSelf = self;

    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void)
    {
        NSData * data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage * image = [[UIImage alloc] initWithData:data];
        dispatch_async( dispatch_get_main_queue(), ^(void){
            if( image != nil )
            {
                [blockSafeSelf setImage:image];
                [blockSafeSelf setActualSizeWithWidth:image.size.width andHeight:image.size.height];
                [blockSafeSelf moveToX:40 y:20];
            } else {

            }
        });
    });
}

@end


@interface ItemRenderers_CheckBoxRenderer : UIView
@end
@implementation ItemRenderers_CheckBoxRenderer

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        NSArray *itemArray = [NSArray arrayWithObjects: @"Yes", @"No", @"NA", nil];
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        segmentedControl.frame = CGRectMake(0, 0, 250, 50);
        segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        segmentedControl.selectedSegmentIndex = 1;
        [self addSubview:segmentedControl];
    }
    return self;
}

@end


@interface ItemRenderers_CheckBoxHeaderRenderer : UISwitch

@end
@implementation ItemRenderers_CheckBoxHeaderRenderer
- (id)init {
    self = [super init];
    if(self){
    }
    return self;
}
@end