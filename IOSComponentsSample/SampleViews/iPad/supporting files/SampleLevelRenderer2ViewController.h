#import <UIKit/UIKit.h>
#import "FLXSDemoVersion.h"

@interface SampleLevelRenderer2ViewController : UIViewController
@property(weak, nonatomic) id data;
@property (strong, nonatomic) IBOutlet UILabel *lblOrgName;
@property (strong, nonatomic) IBOutlet UILabel *lblAnnualRevenue;
@property (strong, nonatomic) IBOutlet UILabel *lblEmployees;
@property (strong, nonatomic) IBOutlet UILabel *lblEPS;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblSalesContactPhone;
@property (strong, nonatomic) IBOutlet UILabel *lblLastStockPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblSalesContact;

@end
