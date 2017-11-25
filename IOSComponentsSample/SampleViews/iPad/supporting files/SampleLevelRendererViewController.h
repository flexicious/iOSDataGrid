
#import <UIKit/UIKit.h>
#import "FLXSDemoVersion.h"

@interface SampleLevelRendererViewController : UIViewController

@property (nonatomic, weak) id data; //this is the data being displayed
@property (weak, nonatomic) IBOutlet UILabel *lblOrgName;

@property (strong, nonatomic) IBOutlet UILabel *lblInVoiceDate;
@property (strong, nonatomic) IBOutlet UILabel *lblDealAmount;
@property (strong, nonatomic) IBOutlet UILabel *lblDealDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblClientName;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblDealStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblDueDate;

@end
