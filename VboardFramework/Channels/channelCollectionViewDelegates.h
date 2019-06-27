//
//  channelCollectionViewDelegates.h
//  Centric
//
//  Created by Ameer Chand on 28/08/2017.
//  Copyright © 2017 Habib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelCollectionViewCell.h"
#import "PersonalVideo.h"
#import "Settings.h"
#import "AFNetworking.h"
#import "constants.h"

@interface channelCollectionViewDelegates : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate>

{
    ChannelCollectionViewCell *cell;
    UIScreen *mainScreen;
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGRect screenRect;
    
// array for channel data
    
    NSMutableArray * unselectedChannelsArray;
    NSMutableArray * seletedChannelsArray;
    NSMutableArray * channelIDArray;
    NSMutableArray * channelNameArray;
    
    int selectedChannelIndex;

}

@end
