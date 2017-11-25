//
//  iPadThemePickerViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-111 on 7/16/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadThemePickerViewController.h"

@interface iPadThemePickerViewController ()

@end

@implementation iPadThemePickerViewController
@synthesize tableView,arrayThemeData;
@synthesize theDelegate = _theDelegate;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource...

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger ) tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
    return [arrayThemeData    count];
}

-(UITableViewCell*) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tv  dequeueReusableCellWithIdentifier:@"SortCells"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SortCells"];
    }
    
    cell.textLabel.text = [arrayThemeData objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (selectedIndex == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tv cellForRowAtIndexPath:lastIndex];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        selectedIndex = indexPath.row;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    [_theDelegate didSelectIndex:(int)indexPath.row];
    [tableView  reloadData];
}

@end