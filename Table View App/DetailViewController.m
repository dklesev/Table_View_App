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
    self.model.test = self.textBox.text;
    NSLog(@"DetailView: %@", self.model.test);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textBox resignFirstResponder];
    
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = @"Artist: ";//[self.detailItem description]];
        [self.textBox setText:[self.detailItem description]];
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
