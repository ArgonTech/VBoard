//
//  ReportPopUpViewController.h
//  KeyBoard
//
//  Created by Ameer on 04/01/2018.
//  Copyright © 2018 Habib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportPopUpViewController : UIViewController
@property (nonatomic, copy) void (^hideThisView) ();

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *positionYConstraint;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (weak, nonatomic) IBOutlet UIButton *NoButton;
@property (weak, nonatomic) IBOutlet UIImageView *appIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *centerLabel;



@end
