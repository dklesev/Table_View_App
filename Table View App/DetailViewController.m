//
//  DetailViewController.m
//  Table View App
//
//  Created by Mac on 17.12.13.
//  Copyright (c) 2013 macVM. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterModel.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textBox;
@property (strong, nonatomic) MasterModel *model;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize model = _model;

#pragma mark - Managing the detail item
- (IBAction)textBoxChanged:(id)sender {
    //self.model.test = self.textBox.text;
    self.model.objects[_detailItem.row] = self.textBox.text;
    //Update UITableView in MasterViewController
    UITableViewController *masterTableViewController = [self.navigationController.viewControllers objectAtIndex:0];
    [masterTableViewController.tableView reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textBox resignFirstResponder];
    
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        self.object = self.model.objects[_detailItem.row];
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = @"Artist: ";//[self.detailItem description]];
        [self.textBox setText:[self.object description]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    [self.textBox setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
