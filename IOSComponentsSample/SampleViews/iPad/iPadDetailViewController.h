#import <UIKit/UIKit.h>
#import "iPadMasterTableViewController.h"
#import "AppDelegate.h"
#import "FLXSDemoVersion.h"

@class iPadMasterTableViewController;
@interface iPadDetailViewController : UIViewController< UIScrollViewDelegate , UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    FLXSComboBox *comboBox;
    //left side bar
    UIBarButtonItem *menuBtn;
    NSMutableArray  *arrayImages;
    iPadMasterTableViewController *masterTableView;
}

@property (readonly, nonatomic) NSArray * gridExamples;
@property (readonly, nonatomic) NSArray * controlExamples;

@property (weak, nonatomic) AppDelegate *delegate;
@property (weak, nonatomic) IBOutlet UIToolbar *iPadDetailViewToolbar;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
