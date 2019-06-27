//
//  KeyboardViewController.h
//  KeyBoard
//
//  Created by Ameer on 10/10/2017.
//  Copyright © 2017 Habib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIView.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "UIImageView+WebCache.h"
#import "WKYTPlayerView.h"
#import "GlobalVideo.h"
#import "AFNetworking.h"
#import "constants.h"
#import "popUp.h"
#import "Settings.h"
#import "PersonalVideo.h"
#import "channelCollectionViewDelegates.h"





@interface KeyboardViewController1 : UIInputViewController < UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UITextFieldDelegate,UIActionSheetDelegate>


{

    // copy & paste from iMessage
    
    BOOL ism3u8SnappyVideo;
    BOOL avPlayerErrorOccured;
    UIView *avPLayerContentOverlay;
    __weak AVPlayer* blockPlayer;
    __weak id obs;
    AVPlayerItem *playerItem;
    UILabel *playerErrorText;
    
    __weak IBOutlet UIView *videoView;
    
    NSString * vidoeId;
    NSString * videoShareURL;
    NSURL * videoPlayableURL;
    NSDictionary *selectedVideo;
    BOOL isMP4Video;
    UIImageView * bgImage;
    // Avplayer button
    UIButton * cancelPreview;
    UIButton * reportPreview;
    UIButton * cancelPlayingVideo;
    UIButton * sendButton;
    
    BOOL isLoadingMoreMain;
    BOOL isLoadingMoreTop;
    NSString *loadMoreUrlMainFeed;
    NSString *loadMoreUrlTopFeed;
    NSMutableArray * moreVideosArry;
    NSMutableArray * moreTopVideosArry;
    int  searchBarCounter;
    BOOL crossClicked;
    
}
@property (strong, nonatomic) IBOutlet UIView *keyButtonView;
@property (weak, nonatomic) IBOutlet UIView *landScapeKeyButtonView;

// iMessage
@property (weak, nonatomic) IBOutlet UIView *switchView;


//@property (weak, nonatomic) IBOutlet UIView *channelCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *topVideosCollection;

@property (atomic, strong) AVPlayerViewController *avPlayerViewcontroller;

@property (strong, nonatomic) IBOutlet UICollectionView *videosCollection;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *blinkingViewConstraintX;

@property (strong, nonatomic) IBOutlet UIView *channelView;
@property (strong, nonatomic) IBOutlet UIView *videoCollectionView;
@property (weak, nonatomic) IBOutlet channelCollectionViewDelegates *channelCollectionView;

@property (strong, nonatomic) IBOutlet UIView *ABFlatSwitchView;
@property (weak, nonatomic) IBOutlet UIButton *keyBoardBtn;
@property (weak, nonatomic) IBOutlet UIButton *backButton;


@property (weak, nonatomic) IBOutlet WKYTPlayerView *youtubeVideoView;



-(void)searchactivityIndicator;

-(void)fatchGlobalVideoswithLatitude:(NSString *)_latitude Logintitude:(NSString *)_longitude Distance:(NSString *)_distance searchText:(NSString *)_searchtext isFromIMesaage:(BOOL)_isFromIMesaage;

-(int)parseVideoReponse:(id)_response;

@property (weak, nonatomic) IBOutlet UIButton *channelButtonTapped;
@property (weak, nonatomic) IBOutlet UIView *bottomButtonsView;

- (IBAction)channelButtonTapped:(id)sender;
- (IBAction)keyBoardButtonTapped:(id)sender;

- (IBAction)worldGlobeButtonPressed:(id)sender;
- (IBAction)backSpaceBottomIconPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *openSettingslbl;

@end

