//
//  ReportPopUpViewController.m
//  KeyBoard
//
//  Created by Ameer on 04/01/2018.
//  Copyright © 2018 Habib. All rights reserved.
//

#import "ReportPopUpViewController.h"

@interface ReportPopUpViewController ()

@end

@implementation ReportPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(receiveViewSize:) name:@"ViewSize" object:nil];
    _bgView.layer.cornerRadius = 10.0;
    _bgView.layer.masksToBounds = YES;
    //    [_bgView setAlpha:.95];
    _appIconImageView.layer.cornerRadius = 10;
    _appIconImageView.layer.masksToBounds = YES;
    UILabel *label = (UILabel *)[self.view viewWithTag:200];
    UILabel *label1 = (UILabel *)[self.view viewWithTag:300];


    _okButton.backgroundColor = [self colorWithHexString:@"50e3c2"];
    _NoButton.backgroundColor = [self colorWithHexString:@"50e3c2"];
    label1.textColor = [self colorWithHexString:@"121E36"];
    label.textColor = [self colorWithHexString:@"121E36"];

    
    [self buttonLayout:_okButton];
    [self buttonLayout:_NoButton];

    // Do any additional setup after loading the view.
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
- (IBAction)okbuttonPressed:(id)sender {
    NSDictionary* userInfo = @{@"buttonName": @"Report"};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popUpButtonPressed"
                                                        object:self userInfo:userInfo];
    if (self.hideThisView) {
        
        self.hideThisView();
        
        NSLog(@"NobuttonPressed Pressed");
    }
}
- (IBAction)NobuttonPressed:(id)sender {
    
    if (self.hideThisView) {
        
        self.hideThisView();
        
        NSLog(@"NobuttonPressed Pressed");
    }
}
- (IBAction)closeButtonPressed:(id)sender {
    if (self.hideThisView) {
        
        self.hideThisView();
        
        NSLog(@"Cancelled Pressed");
    }

}


-(void)buttonLayout:(UIButton *)button
{
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
