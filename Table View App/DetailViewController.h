//
//  DetailViewController.h
//  Table View App
//
//  Created by Mac on 17.12.13.
//  Copyright (c) 2013 macVM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
