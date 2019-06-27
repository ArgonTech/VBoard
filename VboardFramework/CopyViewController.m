//
//  popUp.m
//  myPlayground
//
//  Created by Dealjava on 11/28/16.
//  Copyright © 2016 proto. All rights reserved.
//

#import "CopyViewController.h"
#import "Settings.h"

@implementation CopyViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(receiveViewSize:) name:@"ViewSize" object:nil];
    _bgView.layer.cornerRadius = 10.0;
    _bgView.layer.masksToBounds = YES;
    [_activityIndicatorView startAnimating];
    [_tickView setHidden:YES];
    [self.view setUserInteractionEnabled:NO];
    _centerLabel.text = @"copying Gif to clipboard...";
    
    //    [_bgView setAlpha:.95];
//    _appIconImageView.layer.cornerRadius = 10;
//    _appIconImageView.layer.masksToBounds = YES;
//    _insertButton.backgroundColor = [self colorWithHexString:@"50e3c2"];
//    _preViewButton.backgroundColor = [self colorWithHexString:@"50e3c2"];
//    [self buttonLayout:_insertButton];
//    [self buttonLayout:_preViewButton];
    
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
-(void) receiveViewSize:(NSNotification*)notification
{
    if ([notification.name isEqualToString:@"ViewSize"])
    {
        NSDictionary* userInfo = notification.userInfo;
        
        NSString * receivedObject = [userInfo objectForKey:@"Presence Style"];
        
        if ([receivedObject isEqualToString:@"BIG"]) {
            
            self.positionYConstraint.constant = 110;
            
        }else if ([receivedObject isEqualToString:@"SMALL"]){
            
            self.positionYConstraint.constant = 30;
        }
        
    }
}
-(void)hideView{
    [_tickView setHidden:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (self.hideThisView) {
            
            self.hideThisView();
            
            NSLog(@"Cancelled Pressed////////////////");
        }    });
    
}



- (IBAction)previewButtonPressed:(id)sender{
    
    if (self.hideThisView) {
        
        self.hideThisView();
        
        NSDictionary* userInfo = @{@"buttonName": @"preview"};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"popUpButtonPressed"
                                                            object:self userInfo:userInfo];
    }
    
}

- (IBAction)insertButtonPressed:(id)sender{
    
    if (self.hideThisView) {
        self.hideThisView();
        NSDictionary* userInfo = @{@"buttonName": @"insert"};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"popUpButtonPressed"
                                                            object:self userInfo:userInfo];
        
    }
}


- (IBAction)cancelButtonPressed:(id)sender{
    
    if (self.hideThisView) {
        
        self.hideThisView();
        
        NSLog(@"Cancelled Pressed////////////////");
    }
    
}

-(void)buttonLayout:(UIButton *)button
{
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    
}

@end
