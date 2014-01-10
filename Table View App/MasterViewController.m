//
//  MasterViewController.m
//  Table View App
//
//  Created by Mac on 17.12.13.
//  Copyright (c) 2013 macVM. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MasterModel.h"

@interface MasterViewController () {
    UIBarButtonItem *addButton;
    UIBarButtonItem *doneButton;
}
@property (strong, nonatomic) MasterModel *model;
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (!self.model) {
        self.model = [[MasterModel alloc] init];
    }
    
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
    if([self.model.objects count] == 0){
        [self.model.objects insertObject:@"NEW" atIndex:0];
        [self.tableView reloadData];
        [self performSegueWithIdentifier:@"showDetail" sender:nil];
    }
    
    if(self.tableView.editing) {
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        self.navigationItem.leftBarButtonItem = addButton;
        [self setEditing:NO animated:YES];
    }
    else{
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        self.navigationItem.leftBarButtonItem = doneButton;
        [self setEditing:YES animated:YES];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.model.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.model.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [self.model.objects insertObject:@"NEW" atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self performSegueWithIdentifier:@"showDetail" sender:nil];
        //[self performSegueWithIdentifier:@"showDetail" sender:(UITableViewCell *)[(UITableView *)self.tableView cellForRowAtIndexPath:0]];
        //[self performSegueWithIdentifier:@"showDetail" sender:[self tableView:self.tableView cellForRowAtIndexPath:indexPath]];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.navigationItem.rightBarButtonItem isEnabled] && ![self.navigationItem.leftBarButtonItem isEnabled]){
        return UITableViewCellEditingStyleDelete;
    }else{
           return UITableViewCellEditingStyleInsert;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"Desc: %@",[sender description]);
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSObject *object = self.model.objects[indexPath.row];
        [segue.destinationViewController setModel:self.model];
        [[segue destinationViewController] setDetailItem:indexPath];
    }
}

@end
