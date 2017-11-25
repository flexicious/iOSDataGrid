#import "ViewController.h"
#import "iPhoneRadioButtonViewController.h"
#import "iPhoneCheckBoxListViewController.h"
#import "FLXSExampleData.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //setup toolbar
    [self initializeTitleOfToolBar];
    
    //these are the control examples - i.e. AutoComplete, ComboBox, etc
    iPhoneControlExamples = [[NSArray alloc] initWithObjects:
            [[FLXSExampleData alloc] initWithIdentifier:@"AutoCompleteTextInput"
                              andDescriptionInformation:@"The AutoCompleteUITextView adds AutoComplete ability to the stock UITextView."
                                                andName:@"Auto complete text input"
                                      andViewController:[[iPadTextInputViewController alloc] initWithNibName:@"iPhoneTextInputViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"ComboBox"
                              andDescriptionInformation:@"Renders a Combo box type UI. For iPad applications, uses a popover controller. For iPhone applications, renders the options with an action sheet, so the UI seems natural, even for a completely new paradigm of interacting with list based data."
                                                andName:@"Combo box"
                                      andViewController:[[iPadComboBoxViewController alloc] initWithNibName:@"iPhoneComboBoxViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"CheckBoxList"
                              andDescriptionInformation:@"This is a customized table view, to support checkbox selection within list views. But not only that, it supports Excel-like selection of an All item, which is very handy on search screen type applications where you have to allow the user to pick from a list of items, or select all items quickly."
                                                andName:@"Check box list"
                                      andViewController:[[iPhoneCheckBoxListViewController alloc] initWithNibName:@"iPhoneCheckBoxListViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"MultiSelectComboBox"
                              andDescriptionInformation:@"This component combines the power of the Check box list, with the compactness of the Combo box to present a fully customizable selection component for your search screens."
                                                andName:@"Multi select Combo box"
                                      andViewController:[[iPadMultiSelectComboBoxViewController alloc] initWithNibName:@"iPhoneMultiSelectComboBoxViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"DateComboBox"
                              andDescriptionInformation:@"Building on top of the excellent features of the Combo box, the Date combo box offers your users the ability to quickly select from a predefined set of date ranges, while at the same time exposes the ability to choose custom dates. In addition to smartly managing the UI to display options between iPhone and iPad applications, it also presents a beautiful UI to select the custom date range which is specific to the device."
                                                andName:@"Date combo box"
                                      andViewController:[[iPadDateComboBoxViewController alloc] initWithNibName:@"iPhoneDateComboBoxViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"RadioButton/Tristate"
                              andDescriptionInformation:@"For those of your users who are more comfortable with a Radio Button UI as opposed to a On/Off switch, we have the solution. The RadioButton images are fully customizable to match your requirements."
                                                andName:@"Radio button/ Tristate"
                                      andViewController:[[iPhoneRadioButtonViewController alloc] initWithNibName:@"iPhoneRadioButtonViewController" bundle:nil]],
            nil];
    //these are the grid examples
    iPhoneGridExamples = [[NSArray alloc] initWithObjects:
            [[FLXSExampleData alloc] initWithIdentifier:@"Simple"
                              andDescriptionInformation:@"This example demonstrates a number of features of the iOS TreeGrid, including  Filter, Footer, Paging, Multi Column Sort, Locked Columns, Grouped Headers, Print, Export, and Preference Persistence"
                                                andName:@"Simple"
                                      andViewController:[[iPadSimpleViewController alloc] initWithNibName:@"iPhoneSimpleViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"Nested"
                              andDescriptionInformation:@"This example demonstrates support of nested treegrids, where each level contains its own set of columns."
                                                andName:@"Nested"
                                      andViewController:[[iPadNestedViewController alloc] initWithNibName:@"iPhoneNestedViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"PartialLazyLoaded"
                              andDescriptionInformation:@"This example demonstrates support for loading inner level details in a lazy fashion. It loads each item completely on demand (when the user clicks the expand icon." andName:@"Partial Lazy Loaded" andViewController:[[iPadNestedDataPartialLazyLoadedViewController alloc] initWithNibName:@"iPhoneNestedDataPartialLazyLoadedViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"FullyLazy"
                              andDescriptionInformation:@"This example demonstrates further extends the lazy loading concept to load each hierarchical level in a lazy fasion."
                                                andName:@"Fully Lazy Loaded"
                                      andViewController:[[iPadNestedDataFullyLazyLoadedViewController alloc] initWithNibName:@"iPhoneNestedDataFullyLazyLoadedViewController" bundle:nil ]],
            [[FLXSExampleData alloc] initWithIdentifier:@"GroupedData"
                              andDescriptionInformation:@"This example demonstrates inner levels that share the same set of columns as the top level"
                                                andName:@"Grouped Data"
                                      andViewController:[[iPadGroupedDataViewController alloc] initWithNibName:@"iPhoneGroupedDataViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"GroupedData2"
                              andDescriptionInformation:@"This example demonstrates inner levels that share the same set of columns as the top level, as well a common name column."
                                                andName:@"Grouped Data 2"
                                      andViewController:[[iPadGroupedData_2ViewController alloc] initWithNibName:@"iPhoneGroupedData2ViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"OutlookGroupedData"
                              andDescriptionInformation:@"This example shows usage of the built in styles to achieve an Outlook style grouping UI"
                                                andName:@"Outlook Grouped Data"
                                      andViewController:[[iPadGrouped_Data_OutlookStyleViewController alloc] initWithNibName:@"iPhoneGroupedDataOutlookStyleViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"LevelRenderers2"
                              andDescriptionInformation:@"This example demonstrates immediate inner level that renders details."
                                                andName:@"Inner Level Renderers"
                                      andViewController:[[iPadLevelItemRenderers_2ViewController alloc] initWithNibName:@"iPhoneLevelItemRenderers2ViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"ProgramaticCellFormatting"
                              andDescriptionInformation:@"This example demonstrates support for programmatic formatting of cell text color,background color, etc."
                                                andName:@"Programatic Cell Formatting"
                                      andViewController:[[iPadProgramaticCellFormattingViewController alloc] initWithNibName:@"iPhoneProgramaticCellFormattingViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"ItemRenderers"
                              andDescriptionInformation:@"This example demonstrates usage of item renderers to generate the contents of cells programmatically."
                                                andName:@"Item Renderers"
                                      andViewController:[[iPadCustomItemRenderersViewController alloc] initWithNibName:@"iPhoneCustomItemRenderersViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"XmlGroupedData"
                              andDescriptionInformation:@"This example support for parsing nested XML data and rendering it inside the grid"
                                                andName:@"Xml Data"
                                      andViewController:[[iPadXmlGroupedDataViewController alloc] initWithNibName:@"iPhoneXmlGroupedDataViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"AutoResizingGrid"
                              andDescriptionInformation:@"This example demonstrates support of autosizing the grid based upton number of rows being displayed."
                                                andName:@"Auto Resizing Grid"
                                      andViewController:[[iPadAutoResizingGridViewController alloc] initWithNibName:@"iPhoneAutoResizingGridViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"SelectionModes"
                              andDescriptionInformation:@"This example demonstrates support for various selection modes like  Single Cell, Multiple Cell, Single Row, Multiple Rows, Multiple Rows (CTRL-Click), and  None."
                                                andName:@"Selection Modes"
                                      andViewController:[[iPadSelectionModeViewController alloc] initWithNibName:@"iPhoneSelectionModeViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"ColumnLockModes"
                              andDescriptionInformation:@"This example demonstrates support for various column lock modes, left locked, right locked and unlocked columns"
                                                andName:@"Column Lock Modes"
                                      andViewController:[[iPadColumnLockModesViewController alloc] initWithNibName:@"iPhoneColumnLockModesViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"DynamicLevels"
                              andDescriptionInformation:@"This example demonstrates the concept of dynamic levels, where the hierarchical levels are created on basis of the data at runtime, as opposed to in markup at compile time."
                                                andName:@"Dynamic Levels"
                                      andViewController:[[iPadDynamicLevelsViewController alloc] initWithNibName:@"iPhoneDynamicLevelsViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"IconColumns"
                              andDescriptionInformation:@"This example demonstrates support for icons as well as showing icons by default,on row rollover, or on cell rollover"
                                                andName:@"Icon Columns"
                                      andViewController:[[iPadIconColumnsViewController alloc] initWithNibName:@"iPhoneIconColumnsViewController" bundle:nil]],

            [[FLXSExampleData alloc] initWithIdentifier:@"DynamicGrouping"
                              andDescriptionInformation:@"This example shows how to group data dynamically on basis of a property chosen by the user."
                                                andName:@"Dynamic Grouping"
                                      andViewController:[[iPadDynamicGroupingViewController alloc] initWithNibName:@"iPhoneDynamicGroupingViewController" bundle:nil]],
            [[FLXSExampleData alloc] initWithIdentifier:@"ExternalFilter"
                              andDescriptionInformation:@"This example demonstrates support applying an external filter to the grid."
                                                andName:@"External Filter"
                                      andViewController:[[iPadExternalFilterViewController alloc] initWithNibName:@"iPhoneExternalFilterViewController" bundle:nil]],
             nil];

    //table views for home page
    [homeTableView setDelegate:self];
    [homeTableView setDataSource:self];
    [iPhoneHomeTableView setDelegate:self];
    [iPhoneHomeTableView setDataSource:self];

    [homeTableView reloadData];
}

#pragma mark- Private methods
- (void)initializeTitleOfToolBar {
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(200, 20, 120, 44)];
    navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth
            | UIViewAutoresizingFlexibleBottomMargin
            | UIViewAutoresizingFlexibleRightMargin;
    // [navBar setBarStyle:UIBarStyleBlack];
    UIBarButtonItem *themeBtn = [[UIBarButtonItem alloc] initWithTitle:@"Theme"
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self
                                                                action:@selector(themeItemsOn:)];
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    navItem.rightBarButtonItem = themeBtn;
    [navBar pushNavigationItem:navItem animated:YES];

}

#pragma mark- TableviewDelegates and datasource...
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return [iPhoneGridExamples count];
    else 
        return [iPhoneControlExamples count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"HomeTabelViewCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }

    if (indexPath.section == 0) {
        cell.textLabel.text = ((FLXSExampleData *) [iPhoneGridExamples objectAtIndex:indexPath.row]).name;
        return cell;
    }
    else {
        cell.textLabel.text = ((FLXSExampleData *) [iPhoneControlExamples objectAtIndex:indexPath.row]).name;
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return @"Grid Examples";
    } else if (section == 1)
        return @"Control Examples";
    else
        return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        //this is a grid example
        [self.navigationController                                                  pushViewController:((FLXSExampleData *)
                [iPhoneGridExamples objectAtIndex:(NSUInteger) indexPath.row]).viewController animated:YES];
        AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        delegate.currentExample = [iPhoneGridExamples objectAtIndex:(NSUInteger) indexPath.row];

    } else if (indexPath.section == 1) {
        //this is a control example
        [self.navigationController                                                     pushViewController:((FLXSExampleData *)
                [iPhoneControlExamples objectAtIndex:(NSUInteger) indexPath.row]).viewController animated:YES];
        AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        delegate.currentExample = [iPhoneControlExamples objectAtIndex:(NSUInteger) indexPath.row];

    }
}

- (void)viewDidUnload {
    homeTableView = nil;
    iPhoneHomeTableView = nil;
    [super viewDidUnload];
}
@end