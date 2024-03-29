//
//  DetailViewController.h
//  Table View App
//
//  Created by Mac on 17.12.13.
//  Copyright (c) 2013 macVM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSIndexPath* detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) NSString* object;
@end
