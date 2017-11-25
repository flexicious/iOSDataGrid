
#import "SampleLevelRendererViewController.h"
#import "FLXSOrganization.h"


@interface SampleLevelRendererViewController ()

@end

@implementation SampleLevelRendererViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}
-(void)setData:(id)data{
    _data=data;
    FLXSInvoice* inv= (FLXSInvoice*)_data;
    self.lblOrgName.text = inv.deal.customer.legalName;
    self.lblInVoiceDate.text = [FLXSDateUtils dateToString:inv.deal.dealDate withFormat:@"MM-dd-YYYY"];
    self.lblDealAmount.text = [NSString stringWithFormat:@"%f",inv.deal.dealAmount];
    self.lblDealDescription.text = inv.deal.dealDescription;
    self.lblClientName.text = inv.deal.customer.name;
    self.lblAddress.text = inv.deal.customer.headquarterAddress.concatenatedAddress;
    self.lblDealStatus.text =inv.deal.dealStatus.name;

    self.lblDueDate.text = [FLXSDateUtils dateToString:inv.dueDate withFormat:@"MM-dd-YYYY"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLblOrgName:nil];
       [self setLblInVoiceDate:nil];
    [self setLblDealAmount:nil];
    [self setLblDealDescription:nil];
    [self setLblClientName:nil];
    [self setLblAddress:nil];
    [self setLblDealStatus:nil];
    [self setLblDueDate:nil];
    [super viewDidUnload];
}
@end
