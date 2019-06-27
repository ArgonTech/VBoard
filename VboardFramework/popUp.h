//
//  popUp.h
//  myPlayground
//
//  Created by Dealjava on 11/28/16.
//  Copyright © 2016 proto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popUp : UIViewController

@property (nonatomic, copy) void (^hideThisView) ();

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *positionYConstraint;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *insertButton;

@property (weak, nonatomic) IBOutlet UIButton *preViewButton;
@property (weak, nonatomic) IBOutlet UIImageView *appIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *centerLabel;


- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)insertButtonPressed:(id)sender;
- (IBAction)previewButtonPressed:(id)sender;

@end
