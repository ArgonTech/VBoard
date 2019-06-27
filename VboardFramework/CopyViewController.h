//
//  CopyViewController.h
//  KeyBoard
//
//  Created by Rabia on 09/04/2019.
//  Copyright © 2019 Habib. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CopyViewController : UIViewController
@property (nonatomic, copy) void (^hideThisView) ();
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIImageView *tickView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *positionYConstraint;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@end

NS_ASSUME_NONNULL_END
