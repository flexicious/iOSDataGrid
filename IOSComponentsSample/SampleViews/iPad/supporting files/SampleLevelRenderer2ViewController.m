
#import "SampleLevelRenderer2ViewController.h"
#import "FLXSOrganization.h"


@interface SampleLevelRenderer2ViewController ()

@end

@implementation SampleLevelRenderer2ViewController

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
    NSNumberFormatter* fmt = [[NSNumberFormatter alloc] init];
    fmt.minimumFractionDigits=2;
    FLXSOrganization* org= (FLXSOrganization*)_data;
    self.lblOrgName.text = org.legalName;
    self.lblAnnualRevenue.text =[fmt stringFromNumber:[NSNumber numberWithFloat:org.annualRevenue]];//[NSString stringWithFormat:@"%f", org.annualRevenue];
    self.lblEmployees.text = [fmt stringFromNumber:[NSNumber numberWithFloat:org.numEmployees]];//[NSString stringWithFormat:@"%f",org.numEmployees];
    self.lblSalesContact.text = org.salesContact.displayName;
    self.lblEPS.text =  [fmt stringFromNumber:[NSNumber numberWithFloat:org.earningsPerShare]];//[NSString stringWithFormat:@"%f",org.earningsPerShare];
    self.lblAddress.text = org.headquarterAddress.concatenatedAddress;
    self.lblSalesContactPhone.text = org.salesContact.telephone;
    self.lblLastStockPrice.text =[fmt stringFromNumber:[NSNumber numberWithFloat:org.lastStockPrice]];//[NSString stringWithFormat:@"%f", org.lastStockPrice];
   }

- (void)viewDidUnload {
    [self setLblOrgName:nil];
    [self setLblAnnualRevenue:nil];
    [self setLblEmployees:nil];
    [self setLblEPS:nil];
    [self setLblAddress:nil];
    [self setLblSalesContactPhone:nil];
    [self setLblLastStockPrice:nil];
    [self setLblSalesContact:nil];
    [super viewDidUnload];
}
@end
