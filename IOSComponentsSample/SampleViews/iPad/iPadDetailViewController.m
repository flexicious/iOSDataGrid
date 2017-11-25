#import "iPadDetailViewController.h"
#import "FLXSFlexiciousMockGenerator.h"
#import "iPadDemoHomeCollectionViewCell.h"

@interface

iPadDetailViewController () {
    UIPopoverController *masterPopOverController;
    NSMutableArray *uiCollectionView_section1item;
}

@end

@implementation iPadDetailViewController
@synthesize delegate = _delegate;

// Setup cell identifier
static NSString *cellIdentifier = @"MY_CELL";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    //Assign object of navigation..from appdelegate..

    _delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];

    self.navigationItem.title = @"iOSComponents Demo Console";

    masterTableView = [[iPadMasterTableViewController alloc] init];
    NSArray *allImages = [FLXSUIUtils extractPropertyValues:masterTableView.gridExamples propertyToExtract:@"imageName"];
    NSArray *allImages1 = [FLXSUIUtils extractPropertyValues:masterTableView.controlExamples propertyToExtract:@"imageName"];


    [self.collectionView registerClass:[iPadDemoHomeCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    arrayImages = [[NSMutableArray alloc] initWithObjects:allImages,allImages1, nil];

    // Configure layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(288, 450)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView setCollectionViewLayout:flowLayout];

}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)viewDidUnload {
    [self setIPadDetailViewToolbar:nil];
    [self setCollectionView:nil];
    [super viewDidUnload];
}
#pragma mark - CollectionView Delegates...

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //return [arrayImages count];
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section == 0) {
        return [masterTableView.gridExamples count];
    } else if (section == 1) {
        return [masterTableView.controlExamples count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {


    /* Uncomment this block to use subclass-based cells */
    //[self.collectionView registerClass:[UICollectionView class] forCellWithReuseIdentifier:cellIdentifier];
    iPadDemoHomeCollectionViewCell *cell = (iPadDemoHomeCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        FLXSExampleData *fLXSExampleData = ((FLXSExampleData *) [masterTableView.gridExamples objectAtIndex:indexPath.row]);
        [self prepareCell:indexPath cell:cell fLXSExampleData:fLXSExampleData];
        return cell;
    } else if (indexPath.section == 1) {
        FLXSExampleData *fLXSExampleData = ((FLXSExampleData *) [masterTableView.controlExamples objectAtIndex:indexPath.row]);
        [self prepareCell:indexPath cell:cell fLXSExampleData:fLXSExampleData];
        return cell;
    }
return nil;
}

- (void)prepareCell:(NSIndexPath *)indexPath cell:(iPadDemoHomeCollectionViewCell *)cell fLXSExampleData:(FLXSExampleData *)fLXSExampleData {
    NSMutableArray *data = [arrayImages objectAtIndex:indexPath.section];
    NSString *cellData = [data objectAtIndex:indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:cellData]];
    
    [cell.cellTitle setText:fLXSExampleData.name];
    cell.cellTitle.font = [UIFont boldSystemFontOfSize:22];

    CGSize labelSize = [cell.cellTitle.text sizeWithFont:cell.cellTitle.font constrainedToSize:CGSizeMake(cell.imageView.image.size.height, 999) lineBreakMode:cell.cellTitle.lineBreakMode];
    cell.cellTitle.frame = CGRectMake(20, cell.imageView.image.size.height+50, 268, labelSize.height);

    [cell.cellDescription setText:fLXSExampleData.descriptionInformation];
    cell.cellDescription.font = [UIFont systemFontOfSize:16];
    CGSize labelSize1 = [cell.cellDescription.text sizeWithFont:cell.cellDescription.font constrainedToSize:CGSizeMake(268, 999) lineBreakMode:cell.cellDescription.lineBreakMode];
    cell.cellDescription.frame = CGRectMake(20, cell.imageView.image.size.height+50 + labelSize.height, 268, labelSize1.height);

    cell.backgroundColor = [UIColor clearColor];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(300.0, 70);
}
/*
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        //UICollectionReusableView *rv = [[UICollectionReusableView alloc] init];
        UICollectionReusableView *rv = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        rv.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(rv.frame.origin.x, rv.frame.origin.y, 200.00, 60.0)];
        label.font = [UIFont fontWithName:@"Arial" size:25.0];
        label.backgroundColor = [UIColor groupTableViewBackgroundColor];
        if (indexPath.section == 0) {
             label.text = @"Grid Examples";
        } else if (indexPath.section == 1) {
           
            label.text = @"Control Examples";
        }
        [rv addSubview:label];
        return rv;
    }
    //
    return nil;
} */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(300.0, 450.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FLXSExampleData *fLXSExampleData = ((FLXSExampleData *) [masterTableView.gridExamples objectAtIndex:indexPath.row]);
        iPadExampleViewControllerBase *controller = fLXSExampleData.viewController;
        [self.delegate.navController pushViewController:controller animated:YES];
        self.delegate.currentExample = fLXSExampleData;
        [controller initializeTitleOfToolBar:fLXSExampleData.name];
    } else if (indexPath.section == 1) {
        FLXSExampleData *fLXSExampleData = ((FLXSExampleData *) [masterTableView.controlExamples objectAtIndex:indexPath.row]);
        iPadExampleViewControllerBase *controller = fLXSExampleData.viewController;
        [self.delegate.navController pushViewController:controller animated:YES];
        self.delegate.currentExample = fLXSExampleData;
        [controller initializeTitleOfToolBar:fLXSExampleData.name];
    }
}

-(NSArray *)gridExamples {
    return masterTableView.gridExamples;
}
-(NSArray *)controlExamples {
    return masterTableView.controlExamples;
}
@end
