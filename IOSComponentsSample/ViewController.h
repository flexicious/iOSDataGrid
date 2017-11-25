

#import <UIKit/UIKit.h>
#import "FLXSDemoVersion.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>
{
    IBOutlet UITableView *homeTableView;
    IBOutlet UITableView *iPhoneHomeTableView;

    NSArray*iPhoneControlExamples;
    NSArray *iPhoneGridExamples;

}
@end