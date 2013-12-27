//
//  MasterViewController.m
//  Table View App
//
//  Created by Mac on 17.12.13.
//  Copyright (c) 2013 macVM. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    UIBarButtonItem *addButton;
    UIBarButtonItem *doneButton;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _objects = [[NSMutableArray alloc] init];
    [_objects insertObject:@"The Beatles" atIndex:0];
    [_objects insertObject:@"The Who" atIndex:1];
    [_objects insertObject:@"The Kings" atIndex:2];
    [_objects insertObject:@"The Doors" atIndex:3];
    [_objects insertObject:@"Jimi Hendrix" atIndex:4];
    [_objects insertObject:@"Bee Gees" atIndex:5];
    [_objects insertObject:@"Iggy Pop" atIndex:6];
    [_objects insertObject:@"Stevie Wonder" atIndex:7];
    [_objects insertObject:@"BLaBelle" atIndex:8];
    
    addButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(insertNewObject:)];
    doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(insertNewObject:)];
    self.navigationItem.leftBarButtonItem = addButton;

    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = deleteButton;
}

-(void)toggleEditMode{
    if(self.tableView.editing) {
        [self.navigationItem.leftBarButtonItem setEnabled:YES];
        [self setEditing:NO animated:YES];
    }
    else if (self.tableView.numberOfSections!=0){
        [self.navigationItem.leftBarButtonItem setEnabled:NO];
        [self setEditing:YES animated:YES];
    }
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    if(self.tableView.editing) {
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        self.navigationItem.leftBarButtonItem = addButton;
        [self setEditing:NO animated:YES];
    }
    else if (self.tableView.numberOfSections!=0){
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        self.navigationItem.leftBarButtonItem = doneButton;
        [self setEditing:YES animated:YES];
    }
    
    // Hier wird eingefügt
    //[_objects insertObject:@"Peter" atIndex:0];
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        [_objects insertObject:@"Peter" atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.navigationItem.rightBarButtonItem isEnabled] && ![self.navigationItem.leftBarButtonItem isEnabled]){
        return UITableViewCellEditingStyleDelete;
    }else{
           return UITableViewCellEditingStyleInsert;
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
