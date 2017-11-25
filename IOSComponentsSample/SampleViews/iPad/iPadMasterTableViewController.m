//
//  iPadMasterTableViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-111 on 6/21/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadMasterTableViewController.h"
#import "iPadJsonDataViewController.h"
#import "iPadiTunesViewController.h"


@interface iPadMasterTableViewController ()

@end

@implementation iPadMasterTableViewController
@synthesize gridExamples, controlExamples;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
       
        
        controlExamples = [[NSArray alloc] initWithObjects:
                              [[FLXSExampleData alloc] initWithIdentifier:@"AutoCompleteTextInput"
                                                andDescriptionInformation:@"The Auto complete UI text view adds Auto complete ability to the stock UI Text View."
                                                                  andName:@"Auto complete text input" andViewController:[iPadTextInputViewController new]],
                              [[FLXSExampleData alloc] initWithIdentifier:@"ComboBox"
                                                andDescriptionInformation:@"Renders a Combo box type UI. For iPad applications, uses a popover controller. For iPhone applications, renders the options with an action sheet, so the UI seems natural, even for a completely new paradigm of interacting with list based data."
                                                                  andName:@"Combo box" andViewController:[iPadComboBoxViewController new]],
                              [[FLXSExampleData alloc]initWithIdentifier:@"CheckBoxList"
                                               andDescriptionInformation:@"This is a customized table view, to support check box selection within list views. But not only that, it supports Excel-like selection of an All item, which is very handy on search screen type applications where you have to allow the user to pick from a list of items, or select all items quickly."
                                                                 andName:@"Check box list" andViewController:[iPadCheckBoxListViewController new]],
                              [[FLXSExampleData alloc] initWithIdentifier:@"MultiSelectComboBox"
                                                andDescriptionInformation:@"This component combines the power of the Check box list, with the compactness of the Combo box. It presents a dropdown list of values for your user to choose from, and manages the selection internally." andName:@"Multi select combo box" andViewController:[iPadMultiSelectComboBoxViewController new]],
                              [[FLXSExampleData alloc] initWithIdentifier:@"DateComboBox"
                                                andDescriptionInformation:@"Presents a configureable predefined set of date ranges, while at the same time exposes the ability to choose custom dates with a device specific UI."
                                                                  andName:@"Date combo box" andViewController:[iPadDateComboBoxViewController new]],
                        [[FLXSExampleData alloc]initWithIdentifier:@"RadioButton"
                                         andDescriptionInformation:@"For those of your users who are more comfortable with a Radio button UI as opposed to a On/ Off switch, we have the solution. The Radio button images are fully customizable to match your requirements." andName:@"Radio button/ Tristate" andViewController:[iPadRadioButtonViewController new]],
                        
                        nil];
        gridExamples = [[NSArray alloc] initWithObjects:
              
                [[FLXSExampleData alloc] initWithIdentifier:@"Simple" andDescriptionInformation:@"This example demonstrates a number of features of the iOS Tree grid, including  filter, footer, paging, multi column sort, locked columns, grouped headers, print, export, and preference persistence" andName:@"Simple" andViewController:[iPadSimpleViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"Nested" andDescriptionInformation:@"This example demonstrates support of nested tree grids, where each level contains its own set of columns." andName:@"Nested" andViewController:[iPadNestedViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"PartialLazyLoaded" andDescriptionInformation:@"This example demonstrates support for loading inner level details in a lazy fashion. It loads each item completely on demand (when the user clicks the expand icon." andName:@"Partial lazy loaded" andViewController:[iPadNestedDataPartialLazyLoadedViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"FullyLazyLoaded" andDescriptionInformation:@"This example demonstrates further extends the lazy loading concept to load each hierarchical level in a lazy fasion." andName:@"Fully lazy loaded" andViewController:[iPadNestedDataFullyLazyLoadedViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"GroupedData" andDescriptionInformation:@"This example demonstrates inner levels that share the same set of columns as the top level" andName:@"Grouped data" andViewController:[iPadGroupedDataViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"GroupedData2" andDescriptionInformation:@"This example demonstrates inner levels that share the same set of columns as the top level, as well a common name column." andName:@"Grouped data 2" andViewController:[iPadGroupedData_2ViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"OutlookGroupedData" andDescriptionInformation:@"This example shows usage of the built in styles to achieve an Outlook style grouping UI" andName:@"Outlook grouped data" andViewController:[iPadGrouped_Data_OutlookStyleViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"LevelRenderers" andDescriptionInformation:@"This example demonstrates inner levels that render a detail area as opposed to a inner table" andName:@"Level renderers" andViewController:[iPadLevelItemRenderersViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"LevelRenderers2" andDescriptionInformation:@"This example demonstrates immediate inner level that renders details." andName:@"Level renderers 2" andViewController:[iPadLevelItemRenderers_2ViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"ProgramaticCellFormatting" andDescriptionInformation:@"This example demonstrates support for programmatic formatting of cell text color,background color, etc." andName:@"Programatic cell formatting" andViewController:[iPadProgramaticCellFormattingViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"ItemRenderers" andDescriptionInformation:@"This example demonstrates usage of item renderers to generate the contents of cells programmatically." andName:@"Item renderers" andViewController:[iPadCustomItemRenderersViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"EditableCells" andDescriptionInformation:@"This example demonstrates support for inline cell editing. Each column supports an item editor which is a class factory that creates an editor component used to edit the data object assoicated with each cell." andName:@"Editable cells" andViewController:[iPadFullRowEditViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"DynamicColumns" andDescriptionInformation:@"This example demonstrates modifying the columns collection of the grid at runtime in a dynamic fasion." andName:@"Dynamic columns" andViewController:[iPadDynamicColumnsViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"LargeDataSet" andDescriptionInformation:@"This example demonstrates rendering a large dataset in the grid. The grid supports horizontal and vertical renderer recycling (Drawing only the visible area), there by achieving blazing fast performance, even with large datasets" andName:@"Large data set" andViewController:[iPadLargeDatasetViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"XmlData" andDescriptionInformation:@"This example demonstrates support for parsing flat XML data and rendering it inside the grid." andName:@"Xml data" andViewController:[iPadXmlDataViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"XMLGroupedData" andDescriptionInformation:@"This example support for parsing nested XML data and rendering it inside the grid" andName:@"Xml grouped data" andViewController:[iPadXmlGroupedDataViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"AutoResizingGrid" andDescriptionInformation:@"This example demonstrates support of autosizing the grid based upton number of rows being displayed." andName:@"Auto resizing grid" andViewController:[iPadAutoResizingGridViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"SelectionModes" andDescriptionInformation:@"This example demonstrates support for various selection modes like  Single cell, Multiple cell, Single row, multiple rows, multiple rows (CTRL-Click), and  None." andName:@"Selection modes" andViewController:[iPadSelectionModeViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"CustomMatchFilterControl" andDescriptionInformation:@"This example demonstrates usage of a custom filter control to embed custom logic in the filtering mechanism" andName:@"Custom match filter control" andViewController:[iPadCustomMatchFilterControlViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"ColumnLockMode" andDescriptionInformation:@"This example demonstrates support for various column lock modes, left locked, right locked and unlocked columns" andName:@"Column lock modes" andViewController:[iPadColumnLockModesViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"LargeDynamicGrid" andDescriptionInformation:@"This example demonstrates support for a large number of columns and rows " andName:@"Large dynamic grid" andViewController:[iPadLargeDynamicGridViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"DynamicLevels" andDescriptionInformation:@"This example demonstrates the concept of dynamic levels, where the hierarchical levels are created on basis of the data at runtime, as opposed to in markup at compile time." andName:@"Dynamic levels" andViewController:[iPadDynamicLevelsViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"IconColumns" andDescriptionInformation:@"This example demonstrates support for icons as well as showing icons by default,on row rollover, or on cell rollover" andName:@"Icon columns" andViewController:[iPadIconColumnsViewController new]],
                       
                       [[FLXSExampleData alloc] initWithIdentifier:@"DynamicGrouping" andDescriptionInformation:@"This example shows how to group data dynamically on basis of a property chosen by the user." andName:@"Dynamic grouping" andViewController:[iPadDynamicGroupingViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"SelectionUI1" andDescriptionInformation:@"This example demonstrates support changing the column in which the disclosure icon (expand collapse icon) appears." andName:@"Selection UI 1" andViewController:[iPadDisclosureIcon_NestedUIViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"SelectionUI2" andDescriptionInformation:@"This example demonstrates support changing the column in which the disclosure icon (expand collapse icon) appears, as well as showing labels along side the default checkboxes." andName:@"Selection UI 2" andViewController:[iPadDisclosureIcon_GroupedUIViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"ExternalFilter" andDescriptionInformation:@"This example demonstrates support applying an external filter to the grid." andName:@"External filter" andViewController:[iPadExternalFilterViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"ChangeTrackingAPI" andDescriptionInformation:@"This example demonstrates the Change tracking API. The grid tracks changes to the underlying data provider via the cell editors. This can be then used to synchronize with the backend datastore." andName:@"Change tracking API" andViewController:[iPadChangeTrackingAPIViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"RowSpanColSpan" andDescriptionInformation:@"This example demonstrates support for Row and Column Spans via the usage of colSpanFunction and row span function" andName:@"Row span Col span" andViewController:[iPadRowSpanandColSpanViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"TraderView" andDescriptionInformation:@"This example demonstrates refreshing the grid with rapidly changing data." andName:@"Trader view" andViewController:[iPadTraderViewViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"VariableRowHeight" andDescriptionInformation:@"This example demonstrates support for dynamic row height that is calculated on basis of the underlying data." andName:@"Variable row height" andViewController:[iPadVariableRowHeightViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"FilterComboBoxDataProvider" andDescriptionInformation:@"This example demonstrates how to provide a custom data provider for the filter combobox." andName:@"Filter combo box data provider" andViewController:[iPadFiltercomboboxdataproviderViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"Localization" andDescriptionInformation:@"This example demonstrates how to customize various places in the grid where we render text." andName:@"Localization" andViewController:[iPadLocalizationViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"OnlyOneItemOpen" andDescriptionInformation:@"This example demonstrates how to collapse all other items when a node is opened" andName:@"Only one item open" andViewController:[iPadOnlyOneItemOpenViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"SortNumeric" andDescriptionInformation:@"This example demonstrates how to sort string data on a numeric basis" andName:@"Sort numeric" andViewController:[iPadSortNumericViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"MultiSelectSetFilterValue" andDescriptionInformation:@"This example demonstrates prepopulating filter values." andName:@"Multi select set gilter Value" andViewController:[iPadMultiSelectSetFilterValueViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"VariableHeaderRowHeight" andDescriptionInformation:@"This example demonstrates support for headers of a dynamic size, where the size of the header is determined dynamically on basis of the header text and column width." andName:@"Variable header row height" andViewController:[iPadVariableHeaderRowHeightViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"MultipleGroupingManual" andDescriptionInformation:@"This example demonstrates transposing a flat dataprovider into a hierarchica one while at the same time gathering data to render at parent levels." andName:@"Multiple grouping Manual" andViewController:[iPadMultipleGroupingManualViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"CustomFooter" andDescriptionInformation:@"This example demonstrates support for creating dynamic column footers" andName:@"Custom footer" andViewController:[iPadCustomFooterViewController new]],
                       [[FLXSExampleData alloc] initWithIdentifier:@"ColumnWidthMode" andDescriptionInformation:@"This example demonstrates support for various column lock modes, none,fixed,percent,and fitToContent" andName:@"Column width mode" andViewController:[iPadColumnWidthModeViewController new]],
                          [[FLXSExampleData alloc] initWithIdentifier:@"JsonDataFromUrl" andDescriptionInformation:@"This example demonstrates loading information in json format from a url" andName:@"JSON Data Url" andViewController:[iPadiTunesViewController new]],
                        nil
                       ];

    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    controlExampleNames = [FLXSUIUtils extractPropertyValues:controlExamples propertyToExtract:@"name"];
    gridExampleNames = [FLXSUIUtils extractPropertyValues:gridExamples propertyToExtract:@"name"];
}


#pragma mark - Table view delegate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES; // support all types of orientation
}

@end
