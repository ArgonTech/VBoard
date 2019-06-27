//
//  KeyboardViewController.m
//  KeyBoard
//
//  Created by Ameer on 10/10/2017.
//  Copyright © 2017 Habib. All rights reserved.
//
#import "KeyboardViewController1.h"
#import "Settings.h"
#import "GlobalVideos/GlobalVideo.h"
#import "ReportPopUpViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "jsonParser/JsonParserClass.h"
#import "CopyViewController.h"

#define TRANSFORM_CELL_VALUE CGAffineTransformMakeScale(1.0, 1.0)
#define ANIMATION_SPEED 0.1
@interface KeyboardViewController1() <UIGestureRecognizerDelegate,UITextFieldDelegate,NSFilePresenter,UIImagePickerControllerDelegate,WKYTPlayerViewDelegate>
{

    WKYTPlayerState lastState;
    NSMutableArray* tagsArray;
    UILabel *timelbl;
    UIView *tagsParentView;
    UILabel *userName;
    IBOutlet UICollectionView *videosssCollection;
    UICollectionViewCell *loadMoreCell ;
    CGRect screenRect;
    CGFloat screenWidth;
    CGFloat screenHeight;
    NSString  *latitude;
    NSString  *longitude;
    NSString *searchBy;
    AFHTTPRequestOperationManager *videoIdManager;
    NSMutableArray *latestglobalVideo;
    NSMutableArray *allGlobalvideos;
    GlobalVideo *personalObj;
    GlobalVideo *globalObj;

    NSMutableArray * thumbnailsArray;
    Boolean isMessageTapped;
    BOOL iskeyboard;
    BOOL isVideoDeletedOnTap;
    BOOL isVideoPasted;
    BOOL isYoutubeVideoPlaying;
    BOOL isSearchTapped;
    BOOL isSearchTop;
    BOOL isSearchHit;
    NSString * searchBarTextString;
    BOOL isChannelSelected;
    UICollectionViewFlowLayout  *videosflowLayout;
    UILabel *trending;
    BOOL isTvIconTapped;
    BOOL isVideoFromSearch;
    BOOL isThereInternetAvailable;
    BOOL isReportButtonTapped;
    BOOL isVideosLoaded;
    NSMutableArray * reportedVideosArray;
    NSUserDefaults *userDefaults;
    NSTimer *timer;
    NSNotificationCenter *notificationCenter;
    BOOL openaccess;
    BOOL isFromLandscape;
    BOOL isDotPressed,isSpacePressed;
    BOOL isDotPressedInSearch,isSpacePressedInSearch;
    BOOL isSearchFroMainVideos;
    BOOL isSpaceRemovedFromWord;
    BOOL isWordMatching;
    BOOL isTrendingVideosShown;
    BOOL playerHidden;
    NSLayoutConstraint *_heightConstraint ;
    BOOL isVideoTapped;
    BOOL isLabelTappedWhilePlayingVideo;
    BOOL isVideoResumed;
    BOOL isVideoPlayed;
    BOOL isfirstTimeTransform;
    BOOL isChannelVideoTapped;
    BOOL isGreenIconTapped;
    BOOL isVideoFromTop;
    NSDate *startTime;
    BOOL isFirstTime;
    BOOL isFromCrossTapped;
    NSMutableArray * colorArry;
    __weak IBOutlet UIButton *goBtn;
    NSInteger lastSelectdIndexMain;
    __weak IBOutlet UILabel *searchLbl;
    UISwipeGestureRecognizer *swipeRight;
    UISwipeGestureRecognizer *swipeLeft;
    UILabel *loadingLabel;
    BOOL isFromAboveTextTapped;
    BOOL iskeyboardLoaded;
    BOOL isviewOpen;
    CGSize CellSize;
    NSIndexPath * path;
    BOOL isLabelTapped;
    BOOL isBackPressed;
    
    __weak CopyViewController * copyVC;
    
}

@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property (strong, nonatomic) IBOutlet UIView *keyboardAccessStatusView;
@property (strong, nonatomic) IBOutlet UIView *searchBarView;
@property (strong, nonatomic) IBOutlet UIView *blinkingView;
@property (weak, nonatomic) IBOutlet UIButton *aaBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (strong, nonatomic) IBOutlet UILabel *customTextFieldLabel;

@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *globeBtn;
@property (weak, nonatomic) IBOutlet UIView *mixChannelView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImg;
@property (weak, nonatomic) IBOutlet UILabel *selectedChannelNamelbl;

@property (weak, nonatomic) IBOutlet UILabel *currentUserNamelbl;
@property (weak, nonatomic) IBOutlet UIButton *channelMixBtn;
@property (assign, nonatomic) NSTimeInterval timeout;
@property (strong, nonatomic)  UIView *loadingView;
@property (strong, nonatomic)  UIActivityIndicatorView *activityView;


- (IBAction)channelButton:(id)sender;

@end

@implementation KeyboardViewController1

@synthesize searchBar;

NSUserDefaults *myDefaults;
int counter=0;
bool isFromMessageTapped;
NSDictionary *videoIDs;
NSUserDefaults * userDefaults;
AFHTTPRequestOperationManager *videoIdManager;
UILabel *loadingLabel;
NSUserDefaults * myDefaults ;

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat _expandedHeight;
    if (mainScreen.bounds.size.height == 736)
    {
        if (isTrendingVideosShown || !_keyboardAccessStatusView.isHidden) {
            _expandedHeight = 420;
        }else if(isFromAboveTextTapped){
            _expandedHeight = 370;
            isFromAboveTextTapped = NO;
    
        }else{
            _expandedHeight = 370;
        }
    }
    else if (mainScreen.bounds.size.height == 667){
        if (isTrendingVideosShown) {
            _expandedHeight = 400;
        }else if(!_keyboardAccessStatusView.isHidden){
            _expandedHeight = 400;
        }else if(isFromAboveTextTapped){
            _expandedHeight = 350;
            isFromAboveTextTapped = NO;
        }
        else{
            _expandedHeight = 350;
        }
    }else if (mainScreen.bounds.size.height == 812){
        if (isTrendingVideosShown || !_keyboardAccessStatusView.isHidden) {
            NSLog(@"abc.............");
            _expandedHeight = 400;
        }
        else{
            NSLog(@"ghi.............");
            
            _expandedHeight = 350;
        }
    }else{
        if (isTrendingVideosShown || !_keyboardAccessStatusView.isHidden) {
            _expandedHeight = 400;
        }else if(isFromAboveTextTapped){
            _expandedHeight = 350;
            isFromAboveTextTapped = NO;
            
        }else{
            _expandedHeight = 350;
        }
    }
    
    [self.view removeConstraint:_heightConstraint];
    _heightConstraint =
    [NSLayoutConstraint constraintWithItem: self.view
                                 attribute: NSLayoutAttributeHeight
                                 relatedBy: NSLayoutRelationEqual
                                    toItem: nil
                                 attribute: NSLayoutAttributeNotAnAttribute
                                multiplier: 0.0
                                  constant: _expandedHeight];
    
    
    [self.view addConstraint: _heightConstraint];
    
    _menuView.translatesAutoresizingMaskIntoConstraints=YES;
    _topVideosCollection.translatesAutoresizingMaskIntoConstraints=YES;
    
    if (!isTrendingVideosShown) {
        if (_keyboardAccessStatusView.isHidden) {
            [_menuView setUserInteractionEnabled:YES];
            
            CGRect frame = self.menuView.frame;
            frame.origin.y =0;
            frame.size.width= self.view.frame.size.width;
            self.menuView.frame = frame;
            
            CGRect frame1 = self.topVideosCollection.frame;
            frame1.origin.y =45;
            frame1.size.width= self.view.frame.size.width;
            self.topVideosCollection.frame = frame1;
        }else{
            [_menuView setUserInteractionEnabled:NO];
            CGRect frame = self.menuView.frame;
            frame.size.width= self.view.frame.size.width;
            self.menuView.frame = frame;
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"entered in didload...............");
    isfirstTimeTransform = YES;
    isYoutubeVideoPlaying = NO;
    _channelMixBtn.hidden = YES;
    isLabelTapped = NO;
    isBackPressed = NO;
    videosssCollection.contentOffset = CGPointMake(videosssCollection.contentOffset.x, videosssCollection.contentOffset.y);
    
    searchBy=@"";
    isFirstTime = YES;
    isVideoPlayed = NO;
 
    _selectedChannelNamelbl.textColor = [UIColor colorWithRed:199/255.0 green:80/255.0 blue:151/255.0 alpha:1.0];
    
    [_keyButtonView setHidden:YES];
    [_bottomButtonsView setHidden:NO];
    NSLog(@"//////////////////////did load calllled//////////////////////////////////");
    openaccess=[self isOpenAccessGranted];
    
    if (isThereInternetAvailable) {
//        [FBSDKAppEvents logEvent:@"Keyboard Opened"];
    }
    [_topVideosCollection setHidden:YES];
    //    [_channelCollectionView setHidden:YES];
    isFromAboveTextTapped = NO;
    _menuView.translatesAutoresizingMaskIntoConstraints=YES;
    _topVideosCollection.translatesAutoresizingMaskIntoConstraints=YES;
    goBtn.layer.cornerRadius = 5; // this value vary as per your desire
    goBtn.clipsToBounds = YES;
    if (_keyboardAccessStatusView.isHidden) {
        [_menuView setUserInteractionEnabled:YES];
        CGRect frame = self.menuView.frame;
        frame.origin.y =0;
        frame.size.width= self.view.frame.size.width;
        self.menuView.frame = frame;
        CGRect frame1 = self.topVideosCollection.frame;
        frame1.origin.y = 45;
        frame1.size.width= self.view.frame.size.width-10;
        self.topVideosCollection.frame = frame1;
        [_aaBtn setUserInteractionEnabled:YES];
        [_playBtn setUserInteractionEnabled:YES];
        [_globeBtn setUserInteractionEnabled:YES];
        [_backButton setUserInteractionEnabled:YES];
    }else{
        [_menuView setUserInteractionEnabled:NO];
        CGRect frame = self.menuView.frame;
        frame.size.width= self.view.frame.size.width;
        self.menuView.frame = frame;
        [_aaBtn setUserInteractionEnabled:NO];
        [_playBtn setUserInteractionEnabled:NO];
        [_globeBtn setUserInteractionEnabled:NO];
        [_backButton setUserInteractionEnabled:NO];
        
    }
    isSearchTop = NO;
    iskeyboardLoaded = NO;
    _youtubeVideoView.delegate=self;
    _youtubeVideoView.backgroundColor=[UIColor blackColor];
 
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(connectivityStatusChanged:)
                                                     name:AFNetworkingReachabilityDidChangeNotification
                                                   object:nil];

    isChannelVideoTapped = NO;
  
    isVideoFromTop = NO;
    isSpaceRemovedFromWord =NO;
    isWordMatching =NO;
    isTrendingVideosShown =NO;
    isFromLandscape =NO;
    isVideoPasted=NO;
    _topVideosCollection.delegate= self;
    _topVideosCollection.dataSource= self;
    [_topVideosCollection setHidden:YES];
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    isSearchFroMainVideos=NO;
    isVideoDeletedOnTap=NO;
    isDotPressed=NO;
    isDotPressedInSearch=NO;
    isSpacePressedInSearch=NO;
    isSpacePressed=NO;
    isVideosLoaded = NO;
    vidoeId = @"7165617";
    isMP4Video = FALSE;
    playerHidden= NO;
    isVideoTapped = NO;
    //    [self loadingViewforChannel];
    [_blinkingView setHidden:YES];
    [Settings setSelecetedChannelId:@"16"];
    isChannelSelected= NO;
    latitude=@"";
    longitude=@"";
    allGlobalvideos=[[NSMutableArray alloc]init];
    latestglobalVideo = [[NSMutableArray alloc]init];
    iskeyboard= NO;
    isMessageTapped=NO;
    searchBar.delegate=self;
    isReportButtonTapped = NO;
    isGreenIconTapped = NO;
    isFromCrossTapped = NO;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    isVideoResumed = NO;
    notificationCenter = [NSNotificationCenter defaultCenter];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"KeyTyped" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyActionPerformed:)
                                                 name:@"keyTyped"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(channelisSelected)
                                                 name:@"channelTapped"
                                               object:nil];
    
    isSearchTapped=NO;
    searchBar.userInteractionEnabled=NO;
    searchBar.enablesReturnKeyAutomatically=NO;
    isVideoFromSearch = false;
    
    if (searchBar.text.length>0) {
        searchBar.showsCancelButton = YES;
        [searchBar setTintColor:[UIColor lightGrayColor]];
    }
    reportedVideosArray=[[NSMutableArray alloc]init];
    searchBar.placeholder=@" Find Videos";
    isTvIconTapped = YES;
    
    //    [_videoCollectionView setHidden:YES];
    //    [videosssCollection setHidden:YES];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(receivePopUpButtonPressed:) name:@"popUpButtonPressed" object:nil];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(backKeyLongPress:)];
    [self.backButton addGestureRecognizer:longPress];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OpenSettingsTapped)];
    [_openSettingslbl setUserInteractionEnabled:YES];
    [_openSettingslbl addGestureRecognizer:gesture];
    
    [videosssCollection setShowsHorizontalScrollIndicator:NO];
    [videosssCollection setShowsVerticalScrollIndicator:NO];
    [_topVideosCollection setShowsVerticalScrollIndicator:NO];
    [_topVideosCollection setShowsHorizontalScrollIndicator:NO];
    
    moreVideosArry=[[NSMutableArray alloc] init];
    moreTopVideosArry = [[NSMutableArray alloc]init];
    
    [self.avPlayerViewcontroller.player pause];
    [_blinkingView setHidden:YES];
    colorArry = [NSMutableArray arrayWithObjects:
                 [UIColor colorWithRed:246/255.0 green:222/255.0 blue:45/255.0 alpha:1.0],
                 [UIColor colorWithRed:65/255.0 green:148/255.0 blue:245/255.0 alpha:1.0],
                 [UIColor colorWithRed:203/255.0 green:88/255.0 blue:153/255.0 alpha:1.0],
                 [UIColor colorWithRed:112/255.0 green:214/255.0 blue:178/255.0 alpha:1.0],
                 [UIColor colorWithRed:212/255.0 green:39/255.0 blue:49/255.0 alpha:1.0],
                 [UIColor colorWithRed:135/255.0 green:95/255.0 blue:31/255.0 alpha:1.0],
                 [UIColor colorWithRed:30/255.0 green:130/255.0 blue:128/255.0 alpha:1.0],
                 [UIColor colorWithRed:0/255.0 green:255/255.0 blue:255/255.0 alpha:1.0],
                 [UIColor colorWithRed:229/255.0 green:70/255.0 blue:41/255.0 alpha:1.0],
                 [UIColor colorWithRed:51/255.0 green:51/255.0 blue:255/255.0 alpha:1.0],
                 [UIColor colorWithRed:38/255.0 green:163/255.0 blue:183/255.0 alpha:1.0],
                 [UIColor colorWithRed:255/255.0 green:0/255.0 blue:255/255.0 alpha:1.0],nil];


}

- (IBAction)mixChannelPressed:(id)sender {
    
//    _channelCollectionView.hidden = NO;
//    _mixChannelView.hidden = YES;
    _channelMixBtn.hidden = YES;
    isChannelSelected = NO;
    isSearchTapped = NO;
    isVideoFromSearch=NO;
    isSearchHit = NO;
    [Settings setIsSearchTapped:NO];
    [Settings setSelecetedChannelId:@"16"];
    _customTextFieldLabel.text=@"";
    searchBar.placeholder=@" Find Videos";
    [Settings setIsMixChannelBtnTapped: YES];
    
    [_channelCollectionView reloadData];
    [Settings setSelectedChannelImg:@"https://www.centric.nyc:443/centric/images_public/life_s_kb.png"];
    [Settings setSelecetedChannelName:@"Life"];
    _selectedChannelNamelbl.textColor = [UIColor colorWithRed:199/255.0 green:80/255.0 blue:151/255.0 alpha:1.0];
    _selectedChannelNamelbl.text = [NSString stringWithFormat:@"Fresh Now from -%@ ", globalObj.channelName];

    [self fatchGlobalVideoswithLatitude:latitude Logintitude:longitude Distance:@"" searchText:searchBarTextString isFromIMesaage:YES];
    
}

-(UIColor*) generateRandomPastelColor
{
    // Randomly generate numbers
    CGFloat red  = ( (CGFloat)(arc4random() % 256) ) / 256;
    CGFloat green  = ( (CGFloat)(arc4random() % 256) ) / 256;
    CGFloat blue  = ( (CGFloat)(arc4random() % 256) ) / 256;
    
    // Mix with light-blue
    CGFloat mixRed = 1+0xad/256, mixGreen = 1+0xd8/256, mixBlue = 1+0xe6/256;
    red = (red + mixRed) / 3;
    green = (green + mixGreen) / 3;
    blue = (blue + mixBlue) / 3;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}
- (UIColor *)getRandomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *randomColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.5];
    return randomColor;
}

- (IBAction)searchIconTaped:(id)sender {
    searchBy=@"SearchIcon";
    if (_customTextFieldLabel.text.length>0) {
        if(isTrendingVideosShown){
            isGreenIconTapped = NO;
//            [self showTrendingVideos:@"abc"];
        }
//        [_keyButtonView setHidden:YES];
        videosssCollection.hidden = NO;
        [Settings setIsSearchTapped:YES];
        [_channelCollectionView reloadData];
        [self loadingViewforChannel];
        [_videoCollectionView setHidden:NO];
        [_channelCollectionView setHidden:NO];
        [_keyBoardBtn setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
        [_blinkingView setHidden:YES];
        isVideoFromSearch = true;
        searchBarTextString= _customTextFieldLabel.text;
        isSearchFroMainVideos = YES;
        [_bottomButtonsView setHidden:NO];
        [self sendRequestonDummyEnterButtonForTextField];
    }
    
}

-(void)OpenSettingsTapped{
    NSURL *url1 = [NSURL URLWithString:@"CentricVBoard://display/word?example"];
    [[UIApplication sharedApplication] openURL:url1];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    //    [self.avPlayerViewcontroller removeFromParentViewController];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"popUpButtonPressed" object:nil];   [[NSNotificationCenter defaultCenter] removeObserver:self name:@"KeyTyped" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:AFNetworkingReachabilityDidChangeNotification];
    
    // This is added to avoid duplicate notifications when the view is presented again
    [self.avPlayerViewcontroller.player pause];
    self.avPlayerViewcontroller.player = nil;
}
-(BOOL) isOpenAccessGranted
{
    NSOperatingSystemVersion osv = [NSProcessInfo processInfo].operatingSystemVersion;
    if(osv.majorVersion >= 10) {
        
        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        
        if (@available(iOS 10.0, *)) {
            if(pb.hasStrings || pb.hasURLs || pb.hasColors || pb.hasImages)
            {
                return YES;
            }
            else {
                NSString *ustr = pb.string;
                pb.string = @"777-TEST-123";
                if(pb.hasURLs ) {
                    pb.string = ustr;
                    return YES;
                }
                else {
                    return NO;
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    else if([UIPasteboard generalPasteboard] != nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    return NO;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height){
        //Keyboard is in Portrait
        
        NSLog(@"portrait");
        if (isFromLandscape) {
//            [self displayContentController:keyViews];
        }
    }
    else{
        //Keyboard is in Landscape
        NSLog(@"Landscape");
        isFromLandscape=YES;
//        [self displayContentController:keyViews];
    }
    
}
-(NSString*) myUUID
{
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    NSString *guid = (__bridge NSString *)newUniqueIDString;
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    return([guid lowercaseString]);
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"entered in willappear...............");

    isviewOpen = YES;
    
    openaccess=[self isOpenAccessGranted];
    
    NSLog(@"//////////////////////viewWillAppear////////////////////:%d", openaccess);
    
    [self updateViewConstraints];
    
    UIDevice *device = [UIDevice currentDevice];
    
    NSLog(@"//////////////////////will appear calllled//////////////////////////////////:%d",openaccess);
    
    myDefaults = [[NSUserDefaults alloc]
                  initWithSuiteName:@"group.centric.vboard"];
    [myDefaults setBool:openaccess forKey:@"isAllowedAccess"];
    
    [myDefaults synchronize];
    //    UITextField *txtSearchField = [searchBar valueForKey:@"_searchField"];
    //    [txtSearchField setBorderStyle:UITextBorderStyleRoundedRect];
    //    _menuView.layer.cornerRadius = 10;
    _menuView.layer.borderWidth =2.0f;
    _menuView.layer.borderColor = [[UIColor colorWithRed:94.0/255.0 green:193.0/255.0 blue:12.0/255.0 alpha:1.0] CGColor];
    
    if (openaccess) {

        NSLog(@"//////////////////////will appear calllled//////////////////////////////////");
        
        [_keyButtonView setHidden:YES];
        
        
        if (isThereInternetAvailable) {
//            [FBSDKAppEvents logEvent:@"Keybard Enabled"];
            
            UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customLabelTaped)];
            tapAction.delegate =self;
            tapAction.numberOfTapsRequired = 1;
            _customTextFieldLabel.userInteractionEnabled = YES;
            [_customTextFieldLabel addGestureRecognizer:tapAction];
        }else{
            _customTextFieldLabel.userInteractionEnabled = NO;
        }
        
        [_keyboardAccessStatusView setHidden:YES];
        [_keyboardAccessStatusView removeFromSuperview];
        
        [_mixChannelView setUserInteractionEnabled:YES];
        [_aaBtn setUserInteractionEnabled:YES];
        [_playBtn setUserInteractionEnabled:YES];
        [_globeBtn setUserInteractionEnabled:YES];
        [_backButton setUserInteractionEnabled:YES];
        
    }else{
        [_keyButtonView setHidden:NO];
        
        NSLog(@"//////////////////////will appear nitcalllled//////////////////////////////////");
        if (isThereInternetAvailable) {
//            [FBSDKAppEvents logEvent:@"Keybard Disabled"];
        }
        _customTextFieldLabel.userInteractionEnabled = NO;
        [_keyboardAccessStatusView setHidden:NO];
        [_bottomButtonsView setHidden:NO];
        //        [_mixChannelView setUserInteractionEnabled:NO];
        [_aaBtn setUserInteractionEnabled:NO];
        [_playBtn setUserInteractionEnabled:NO];
        [_blinkingView setHidden:YES];
        [_globeBtn setUserInteractionEnabled:NO];
        [_backButton setUserInteractionEnabled:NO];
//        [self displayContentController:keyViews];
        [_keyButtonView setHidden:NO];
        
    }
    
    NSLog(@"switch is off");
    
    if ([[Settings getSelectedChannelId]isEqualToString:@"000"])
    {
        searchBar.placeholder = @" Find Videos";
    }
    
    [_blinkingView setHidden:YES];
    //    _keyButtonView.hidden = YES;
    NSLog(@"exit from didload...............");
    
}

-(void)viewDidAppear:(BOOL)animated
{
//    [self scrollViewDidScroll:videosssCollection];

    NSLog(@"//////////////////////did appear calllled//////////////////////////////////");
//    if #available(iOS 10.0, *) {videosssCollection.isPrefetchingEnabled = false}
    if (@available(iOS 10.0, *)) {
        [videosssCollection setPrefetchingEnabled:NO];
    } else {
        // Fallback on earlier versions
    }
    if(openaccess){
        [self loadingViewforChannel];}
    
    [_menuView setHidden:NO];
    //    [_keyButtonView setHidden:YES];
    
    if (_keyboardAccessStatusView.hidden){
        //        [self showTrendingVideos:@"abc"];
        
    }
    
    //    [_topVideosCollection setHidden:NO];
    
    //    [_keyBoardBtn setImage:[UIImage imageNamed:@"channel"] forState:UIControlStateNormal];
    
    cancelPlayingVideo = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelPlayingVideo addTarget:self
                           action:@selector(hideAvplayer)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [cancelPlayingVideo setTitle:@"Close" forState:UIControlStateNormal];
    
    cancelPlayingVideo.frame = CGRectMake(videoView.frame.size.width-80, videoView.frame.origin.y + 10, 80, 35); // set your own position
    [cancelPlayingVideo setBackgroundImage:[UIImage imageNamed:@"avPlayerButtonBg"] forState:UIControlStateNormal];
    cancelPlayingVideo.layer.cornerRadius = 3;
    cancelPlayingVideo.clipsToBounds = YES;

    NSLog(@"exited from didappear...............");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"<<<<<<<<<<< MEMORY WARNING >>>>>>>>>>>>");
    
    // Dispose of any resources that can be recreated
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //    activeField = nil;
}


// Custome key Work.
- (IBAction)crossButtonPressed:(id)sender {
    if(_customTextFieldLabel.text.length >0){
        crossClicked = TRUE;
        isFromCrossTapped = YES;
        isSearchHit = NO;
        isChannelSelected = NO;
        isSearchTapped = NO;
        
        _customTextFieldLabel.text=@"";
        searchBar.placeholder=@" Find Videos";
        CGRect frame = self.blinkingView.frame;
        frame.origin.x =_customTextFieldLabel.frame.origin.x;
        self.blinkingView.frame = frame;

        if (!videosssCollection.hidden) {
//            [_keyBoardBtn setImage:[UIImage imageNamed:@"channel"]
            _keyButtonView.hidden= NO;
            _channelView.hidden = NO;
        }
    }
    
}
- (void) displayContentController: (UIViewController*) content;
{
    //    if (isviewOpen){
    [self addChildViewController:content];                 // 1
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    NSLog(@"mainScreen.bounds.size.height  is :%f",mainScreen.bounds.size.height);
    
    
    if (mainScreen.bounds.size.height == 736)
    {
        content.view.frame = CGRectMake(self.keyButtonView.frame.origin.x,0, self.keyButtonView.frame.size.width,278);
        
    } else if (mainScreen.bounds.size.height == 812 || mainScreen.bounds.size.height == 667)
    {
        content.view.frame = CGRectMake(self.keyButtonView.frame.origin.x,0, self.keyButtonView.frame.size.width,255);
        
    }
    else{
        content.view.frame = CGRectMake(self.keyButtonView.frame.origin.x,0, self.keyButtonView.frame.size.width,260);

//        content.view.frame = CGRectMake(self.keyButtonView.frame.origin.x,0, self.keyButtonView.frame.size.width,380-_menuView.frame.size.height-_topVideosCollection.frame.size.height
//                                        );
    }
    
    [self.keyButtonView addSubview:content.view];
    
    [content didMoveToParentViewController:self];
    
    iskeyboardLoaded = YES;
    isviewOpen = NO;
    //    }
    
}


- (void) hideContentController: (UIViewController*) content
{
    [content willMoveToParentViewController:nil];  // 1
    [content.view removeFromSuperview];            // 2
    [content removeFromParentViewController];      // 3
}

-(void)deleteAllText:(UIButton *)sender{
    
    if (isSearchTapped) {
        if (_customTextFieldLabel.text.length>0) {
            [self deleteSearchTextOnLongPress:NULL];
            
        }
        
    }else{
        
        if (self.textDocumentProxy.documentContextBeforeInput.length > 0) {
            [self deleteTextOnTextAreaOnLongPress:nil];
            
        }
    }
    
}


-(void)deleteSearchTextOnLongPress:(NSTimer *)timer
{
    
    NSLog(@"Search text length is :%lu",_customTextFieldLabel.text.length);
    if ([Settings getIsLongPressed]) {
        
        //
        //        if (_customTextFieldLabel.text.length > 0)
        //        {
        ////
        NSString *text = _customTextFieldLabel.text;
        [_customTextFieldLabel setText:[text substringToIndex:[text length] - 1]];
        
        CGFloat width =  [_customTextFieldLabel.text sizeWithFont:[UIFont systemFontOfSize:17 ]].width;
        if (width>0) {
            searchBar.placeholder=@"";
        }else{
            searchBar.placeholder=@" Find Videos";
            //                 [[NSNotificationCenter defaultCenter] postNotificationName:@"capKeyOnSearch" object:nil];
        }
        
        if (width > _customTextFieldLabel.frame.size.width) {
            
        }else{
            CGRect frame = self.blinkingView.frame;
            frame.origin.x =_customTextFieldLabel.frame.origin.x+ width;
            self.blinkingView.frame = frame;
        }
        
        
    }
    else{
       
        [timer invalidate];
        
    }
    
}
-(void)deleteTextOnTextAreaOnLongPress:(NSTimer *)timer
{
    if ([Settings getIsLongPressed]) {
        
        //        if (self.textDocumentProxy.documentContextBeforeInput.length > 0)
        //        {
        NSString *text = self.textDocumentProxy.documentContextBeforeInput;
        
        NSString *lastWord = [text substringFromIndex: [text length] - 1];
        
        [self clearAppleDefaultKeyboardTextField:lastWord];
        
       
    }else{
        [timer invalidate];
    }
    
}

// coading copy from iMessage
-(void)hitSearch{
    
    if ([Settings getIsKeyPressed]) {
        [_keyBoardBtn setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
        
        [self sendRequestonDummyEnterButtonForTextField];
        [_blinkingView setHidden:YES];
        searchBar.placeholder=@"  Find Videos";
        _customTextFieldLabel.text= @"";
        
    }
}
-(void)initABFlatSwitch
{
    
    
}

-(UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
- (void)showCopyViewController{
    
    copyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CopyViewController"];
    
    copyVC.view.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] initWithFrame:copyVC.view.frame];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [copyVC.view addSubview:view];
    [copyVC.view sendSubviewToBack:view];
    
    CGRect tframe = copyVC.view.frame;
    tframe.origin.y = self.view.frame.size.height;
    copyVC.view.frame = tframe;
    
    CGRect oframe = copyVC.view.frame;
    oframe.origin.y = 0.0;
    
    [self animateView:copyVC WithFrame:oframe remove:NO];
    
    
//     Remove View on back Button
    copyVC.hideThisView =^ {
        copyVC.tickView.hidden = NO;
        copyVC.activityIndicatorView.hidden = YES;
        copyVC.centerLabel.text = @"COPIED! paste now...";

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            self.view.userInteractionEnabled = YES;

            [self animateView:copyVC WithFrame:tframe remove:YES];

               });
    };
    
    [self addChildViewController:copyVC];
    [self.view addSubview:copyVC.view];
    [self.view bringSubviewToFront:copyVC.view];
    [copyVC didMoveToParentViewController:copyVC];
    if (isMP4Video) {
        
    } else
    {
        
    }
    
}

- (void)showCommentsViewController{
    
    __weak popUp * commentsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"popUp"];
    
    commentsVC.view.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] initWithFrame:commentsVC.view.frame];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [commentsVC.view addSubview:view];
    [commentsVC.view sendSubviewToBack:view];
    
    CGRect tframe = commentsVC.view.frame;
    tframe.origin.y = self.view.frame.size.height;
    commentsVC.view.frame = tframe;
    
    CGRect oframe = commentsVC.view.frame;
    oframe.origin.y = 0.0;
    
    [self animateView:commentsVC WithFrame:oframe remove:NO];
    
    
    // Remove View on back Button
    commentsVC.hideThisView =^ {
        [self animateView:commentsVC WithFrame:tframe remove:YES];
    };
    
    [self addChildViewController:commentsVC];
    [self.view addSubview:commentsVC.view];
    [self.view bringSubviewToFront:commentsVC.view];
    [commentsVC didMoveToParentViewController:commentsVC];
    if (isMP4Video) {
        
    } else
    {
        
    }
    
}
- (void)showReportVideoPopUpViewController{
    
    __weak ReportPopUpViewController * commentsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportPopUpViewController"];
    
    commentsVC.view.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] initWithFrame:commentsVC.view.frame];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [commentsVC.view addSubview:view];
    [commentsVC.view sendSubviewToBack:view];
    
    CGRect tframe = commentsVC.view.frame;
    tframe.origin.y = self.view.frame.size.height;
    commentsVC.view.frame = tframe;
    
    CGRect oframe = commentsVC.view.frame;
    oframe.origin.y = 0.0;
    
    [self animateView:commentsVC WithFrame:oframe remove:NO];
    
    
    // Remove View on back Button
    commentsVC.hideThisView =^ {
        [self animateView:commentsVC WithFrame:tframe remove:YES];
    };
    
    [self addChildViewController:commentsVC];
    [self.view addSubview:commentsVC.view];
    [self.view bringSubviewToFront:commentsVC.view];
    [commentsVC didMoveToParentViewController:commentsVC];
}

- (void) animateView:(UIViewController *)view WithFrame:(CGRect )frame remove:(BOOL) remove{
    [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.view.frame = frame;
    } completion:^(BOOL handled) {
        if (remove) {
            
            [view.view removeFromSuperview];
            [view didMoveToParentViewController:nil];
        }
    } ];
}

- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    
}

- (void)keyboardDidHide: (NSNotification *) notif{
    // Do something here
}

-(void)setFrames{
   
    
}


-(void)customLabelTaped{
//    [self hideAvplayer];
    isLabelTappedWhilePlayingVideo = NO;
    isSearchTapped = YES;
    isLabelTapped = YES;
//    isVideoTapped = NO;
    
    if(!isTrendingVideosShown){
        isGreenIconTapped = NO;
        isTvIconTapped = NO;
//        [self showTrendingVideos:@"abc"];
    }

    if (_customTextFieldLabel.text.length==0) {
        //        [[NSNotificationCenter defaultCenter]
        //         postNotificationName:@"notifyme"
        //         object:nil];
    }
    //  [self displayContentController:keyViews1];
    
    [_blinkingView setHidden:NO];
    //    [_bottomButtonsView setHidden:YES];
    
    CGFloat width =  [_customTextFieldLabel.text sizeWithFont:[UIFont systemFontOfSize:17 ]].width;
    
    [_blinkingView setTranslatesAutoresizingMaskIntoConstraints:YES];
    if (width == 0) {
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"capKeyOnSearch" object:nil];
    }
    if (width > _customTextFieldLabel.frame.size.width) {
        
    }else{
        CGRect frame = self.blinkingView.frame;
        frame.origin.x =_customTextFieldLabel.frame.origin.x+ width;
        self.blinkingView.frame = frame;
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setFromValue:[NSNumber numberWithFloat:1.0]];
    [animation setToValue:[NSNumber numberWithFloat:0.0]];
    [animation setDuration:0.5f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:20000];
    [[_blinkingView layer] addAnimation:animation forKey:@"opacity"];
    
    [_keyBoardBtn setImage:[UIImage imageNamed:@"channel"] forState:UIControlStateNormal];
    
}

-(void)searchBarViewTapped
{
    //    [_blinkingView setHidden:NO];
    [_customTextFieldLabel setHidden:NO];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setFromValue:[NSNumber numberWithFloat:1.0]];
    [animation setToValue:[NSNumber numberWithFloat:0.0]];
    [animation setDuration:0.5f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:20000];
    [[_blinkingView layer] addAnimation:animation forKey:@"opacity"];
    
    if (_keyButtonView.hidden) {
        
        _videoCollectionView.hidden = YES;
        //        _keyButtonView.hidden = NO;
        _landScapeKeyButtonView.hidden=NO;
        //        [_bottomButtonsView setHidden:YES];
        
        if (searchBarTextString.length > 0 || [searchBarTextString isEqualToString:@""]) {
            searchBar.placeholder = @"";
        }else{
            //        searchBar.placeholder = @"Search Centric";
        }
    }
}

-(void)fatchGlobalVideoswithLatitude:(NSString *)_latitude Logintitude:(NSString *)_longitude Distance:(NSString *)_distance searchText:(NSString *)_searchtext isFromIMesaage:(BOOL)_isFromIMesaage{
    
    //    self.view.userInteractionEnabled = false;
    
    NSDate *csrfmethodStart = [NSDate date];
    
    NSURL *dataUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/csrftoken",SERVER_ADDRESS]];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:dataUrl];
    
    NSDictionary *sheaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    NSLog(@" WebServices  cookies dictionary is  : %@",sheaders);
    
    for (NSOperation *operation in videoIdManager.operationQueue.operations) {
        [operation cancel];
        //        [_loadingView removeFromSuperview];
        //        [_activityIndicator stopAnimating];
        //        [_activityIndicator setHidesWhenStopped:YES];
        //        [loadingLabel removeFromSuperview];
        
    }
    
    videoIdManager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"Remember Found....!");
    
    [videoIdManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [videoIdManager.requestSerializer setValue:@"centric-mobile" forHTTPHeaderField:@"User-Agent"];
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"token"];
    [videoIdManager.requestSerializer setValue:token forHTTPHeaderField:@"X-CSRF-TOKEN"];
    [videoIdManager.requestSerializer setValue:[sheaders valueForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    
    NSLog(@" WebServices  Csrf Token is : %@",token);
    
    if (![AFNetworkReachabilityManager sharedManager].reachable){
        videoIdManager.requestSerializer.cachePolicy=NSURLRequestReturnCacheDataElseLoad;
    }
    
    NSDate *csrfmethodFinish = [NSDate date];
    NSTimeInterval executionTime = [csrfmethodFinish timeIntervalSinceDate:csrfmethodStart];
    NSLog(@"csrf executionTime = %f", executionTime);
    
    NSString *date=[NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSince1970]];
    NSString *finalString = [_searchtext stringByReplacingOccurrencesOfString:@" " withString: @"%20"];
    
    NSString *encoded = [_searchtext stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString * url;
    
    _latitude = @"40.730610";
    _longitude = @"-73.935242";
    searchLbl.text = _customTextFieldLabel.text;
    
    
    if (finalString.length > 0 && (isSearchTapped || isSpacePressed)) {
        
        url = [NSString stringWithFormat:@"%@api/fetchpublicvideos?longitude=%@&latitude=%@&distance=%@&searchtext=%@&ts=%@&isFromIMesaage=%d&isKeyBoard=%d",SERVER_ADDRESS,_longitude,_latitude,@"",encoded,date,0,1];
    }
    
    else
    {
        if([[Settings getSelectedChannelId]isEqualToString:@"5"]){
             url  = [NSString stringWithFormat:@"%@api/fetchallvideosofaInfotainmentfornewbuild/%@?latitude=%@&longitude=%@&distance=%@&ts=%@&isFromIMesaage=%d&isKeyBoard=%d&isLocal=%d",SERVER_ADDRESS,[Settings getSelectedChannelId],_latitude,_longitude,@"50",@"22.0",0,1,0];
        }else{
             url  = [NSString stringWithFormat:@"%@api/fetchallvideosofaInfotainmentfornewbuild/%@?latitude=%@&longitude=%@&distance=%@&ts=%@&isFromIMesaage=%d&isKeyBoard=%d&isLocal=%d",SERVER_ADDRESS,[Settings getSelectedChannelId],_latitude,_longitude,@"50",@"22.0",0,1,0];
        }
       
    }
    //    }
    
    NSLog(@"Thumbnails WebService///////////////////////////: %@",url);
    
    NSURL *urlApi = [NSURL URLWithString:url];
    
    __block NSURLRequest *urlString = [NSURLRequest requestWithURL:urlApi];
    __block NSURLRequest *request = nil;
    __block NSNumber *result;
    NSDate *thumbnailsMethodStart = [NSDate date];
    
    [videoIdManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@" WebServices ResponseObject info :%@",responseObject);
        NSLog(@"HEADERS: %@", operation.response.allHeaderFields);
        
        NSDate *thumnailsmethodFinish = [NSDate date];
        NSTimeInterval executionTime = [thumnailsmethodFinish timeIntervalSinceDate:thumbnailsMethodStart];
        NSLog(@"thumnails executionTime = %f", executionTime);
        NSLog(@"About to fetch response successfully...............");
        
        
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        int number=[self parseGlobalVideoReponse:responseObject];
        if (number==0) {
            
            
            result = [NSNumber numberWithInt:number];
            
            
            [self requestSuccessful:result];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSInteger statusCode;
        statusCode = operation.response.statusCode;
        
        NSData *data;
        _keyBoardBtn.userInteractionEnabled=YES;
        
        NSLog(@"request failedddddddddddddddd...............%ld", (long)statusCode);
        
        NSLog(@"data is:%@",data);
        
        if (data)
        {
            NSDictionary *jsonObject=[NSJSONSerialization
                                      JSONObjectWithData:data
                                      options:NSJSONReadingMutableLeaves
                                      error:nil];
            
            NSLog(@"response cache data:%@",jsonObject);
            
            int number=[self parseGlobalVideoReponse:jsonObject];
            if (number==0) {
                
                
                result = [NSNumber numberWithInt:number];
                
                
                [self requestSuccessful:result];
                
            }
        }else{
            
            [self requestFailed:result];
            
        }
        
    }];
    
    //    @try {
    //        [videosssCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    //    } @catch (NSException *exception) {
    //        NSLog(@"exception is %@", exception);
    //    }
}

- (int)parseGlobalVideoReponse:(id)_response{
    self.view.userInteractionEnabled = true;
    [Settings setGlobalMainLoadMoreUrl:@""];
    
    NSLog(@"JsonParserClass enter parseGlobalVideoReponse");
    //PersonalVideo *perVideoObj;
    NSMutableArray *lastesVideoArray,*allVideoArray;
    //    NSLog(@"response: %@",_response);
    NSDictionary *jsonDictionary=[[NSDictionary alloc] initWithDictionary:_response];
    
    BOOL tutorialValue=[[jsonDictionary objectForKey:@"tutorialOn"] boolValue];
    //    [Settings setGlobalTutorialValue:tutorialValue];
    NSLog(@"tutorial value is %d",tutorialValue);
    NSString *distanceListIsEmpty=[jsonDictionary objectForKey:@"distanceListIsEmpty"];
    NSString *listIsEmpty=[jsonDictionary objectForKey:@"listIsEmpty"];
    //    NSString *totalNotificationCount=[jsonDictionary objectForKey:@"totalNotificationsCount"];
    //    [Settings setTotalNotificationCount:[totalNotificationCount integerValue]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"totalNotificationsCount"
                                                        object:nil];
    NSString *userNameSearched=[jsonDictionary objectForKey:@"userNameSearched"];
    NSLog(@"listIsEmpty value is %@ ",listIsEmpty);
    
    if ([jsonDictionary valueForKey:@"allvideoListLoadMoreUrl"]&& ![[jsonDictionary objectForKey:@"allvideoListLoadMoreUrl"] isKindOfClass:[NSNull class]]) {
        NSString *loadMore=[jsonDictionary objectForKey:@"allvideoListLoadMoreUrl"];
        
        if (![loadMore isEqualToString:@"null"]) {
            isLoadingMoreMain=YES;
            NSLog(@"load more url is :%@",[jsonDictionary valueForKey:@"allvideoListLoadMoreUrl"]);
            [Settings setGlobalMainLoadMoreUrl:[jsonDictionary valueForKey:@"allvideoListLoadMoreUrl"]];
        }else{
            [Settings setGlobalMainLoadMoreUrl:@""];
            isLoadingMoreMain= NO;
        }
    }else{
        [Settings setGlobalMainLoadMoreUrl:@""];
        isLoadingMoreMain= NO;
    }
    
    if ([jsonDictionary objectForKey:@"latestvideoList"] || [jsonDictionary objectForKey:@"allvideoList"]) {
        
        if ([jsonDictionary objectForKey:@"allvideoList"]) {
            
            NSMutableArray *lastedVideoArray=[jsonDictionary objectForKey:@"allvideoList"];
            NSLog(@"enter into Allvideo Array ");
            
            allVideoArray=[[NSMutableArray alloc] init];
            
            for (NSDictionary *videoObjectDic in lastedVideoArray) {
                
                NSLog(@"enter into Allvideo Loop:");
                
                GlobalVideo *perVideoObj=[[GlobalVideo alloc] init];
                perVideoObj.videoId=[NSString stringWithFormat:@"%zd",[[videoObjectDic objectForKey:@"videoId"] integerValue]];
                perVideoObj.cdnUrl=[videoObjectDic objectForKey:@"cdnUrl"];
                perVideoObj.cdnThumbnail=[videoObjectDic objectForKey:@"cdnThumbnail"];
                perVideoObj.description=[videoObjectDic objectForKey:@"description"];

                
                
                //                perVideoObj.location=[videoObjectDic objectForKey:@"location"];
                //                perVideoObj.uploadingDate=[videoObjectDic objectForKey:@"uploadingDate"];
                //                perVideoObj.views=[videoObjectDic objectForKey:@"views"];
                //                perVideoObj.city=[videoObjectDic objectForKey:@"city"];
                //                perVideoObj.country=[videoObjectDic objectForKey:@"country"];
                //                perVideoObj.ispublic=[[videoObjectDic objectForKey:@"public"] boolValue];
                //                perVideoObj.anonymous=[[videoObjectDic objectForKey:@"anonymous"] boolValue];
                //                perVideoObj.videoFavroute=[[videoObjectDic objectForKey:@"videoFavroute"] boolValue];
                //                perVideoObj.videoOwnerInFollowing=[[jsonDictionary valueForKey:@"videoOwnerInFollowing"]boolValue];
                //                perVideoObj.loggedInUserOwnVideo=[[jsonDictionary valueForKey:@"loggedInUserOwnVideo"]boolValue];
                perVideoObj.tags=[videoObjectDic valueForKey:@"tags"];
                //                if ([perVideoObj.channelThumbnail isKindOfClass:[NSString class]]){
                perVideoObj.channelThumbnail = [videoObjectDic valueForKey:@"channelThumbnail"];
                perVideoObj.channelName = [videoObjectDic valueForKey:@"channelName"];
                
                perVideoObj.isSocial=[[videoObjectDic valueForKey:@"social"] boolValue];
                perVideoObj.socialUrl=[videoObjectDic valueForKey:@"socialLink"];
                //                NSLog(@"social url is %@",perVideoObj.socialUrl);
                perVideoObj.userName=[videoObjectDic valueForKey:@"userName"];
                //
                perVideoObj.isYoutubeVideo=[[videoObjectDic valueForKey:@"youTube"] boolValue];
                perVideoObj.isInstagramVideo=[[videoObjectDic valueForKey:@"insta"] boolValue];
                perVideoObj.isTwitchGameVideo=[[videoObjectDic valueForKey:@"twitch"] boolValue];
                perVideoObj.isTwitterVideo=[[videoObjectDic valueForKey:@"twitter"] boolValue];
                perVideoObj.isGif=[[videoObjectDic valueForKey:@"gif"] boolValue];
                perVideoObj.isPeriscopeVideo=[[videoObjectDic valueForKey:@"periscope"] boolValue];
                perVideoObj.isFacebookLive = [[videoObjectDic valueForKey:@"facebookLive"] boolValue];
                perVideoObj.isCentric = [[videoObjectDic valueForKey:@"centric"] boolValue];
                
                //                NSLog(@" Thumnil value : %@",perVideoObj.cdnThumbnail);
                
                [allVideoArray addObject:perVideoObj];
                [Settings setVideoObject:perVideoObj];
            }
            NSLog(@"All Video Array number : %lu",(unsigned long)allVideoArray.count);
            
            [Settings setGlobalAllVideos:allVideoArray];
        }
        NSLog(@"JsonParserClass exit parseGlobalVideoReponse with return 0");
        return 0;
        
    }
    
    NSLog(@"JsonParserClass exit parseGlobalVideoReponse with return 1");
    return 1;
}

-(void)requestSuccessful:(NSNumber *)result{
    NSLog(@"About to call requestSuccessful...............");
    _keyboardAccessStatusView.hidden = YES;
    [_keyboardAccessStatusView removeFromSuperview];
    iskeyboardLoaded = YES;
//    _carousel.dataSource = self;
//    _carousel.delegate = self;
//    [_carousel reloadData];
    
    self.view.userInteractionEnabled = YES;
    //    isChannelSelected=NO;
    if ([result integerValue]==0) {
        
        //       _keyButtonView.hidden= NO;
        //        [allGlobalvideos removeAllObjects];
        allGlobalvideos = [Settings getGlobalAllVideos];
        isVideosLoaded=YES;
        
        //        _channelView.hidden = NO;
        _channelCollectionView.hidden =NO;
        //        _bottomButtonsView.hidden= YES;
        if (crossClicked) {
            _bottomButtonsView.hidden= NO;
        }
        
    }
    else{
        
    }
    
    bgImage = nil;
    bgImage.image = nil;
    [bgImage setNeedsDisplay];
    //    _videoCollectionView.backgroundColor = [UIColor whiteColor];
    //    if (isTvIconTapped || isSearchTapped) {
    
    //        [videosssCollection setHidden:NO];
    //        [_videoCollectionView setHidden:NO];
    //        [_bottomButtonsView setHidden:NO];
    videosssCollection.dataSource = self;
    videosssCollection.delegate = self;
    [videosssCollection reloadData];
    _keyButtonView.hidden = YES;
    
    _videoCollectionView.hidden = NO;
    [videosssCollection setHidden:NO];
    [_videoCollectionView setHidden:NO];
    [_bottomButtonsView setHidden:NO];
    [_blinkingView setHidden:YES];
    //    }
    [_globeBtn setHidden:NO];
    [_backButton setHidden:NO];
    if (isSearchTapped || isReportButtonTapped || crossClicked || isTvIconTapped){
        [videosssCollection setHidden:NO];
        [_keyButtonView setHidden:YES];
        [_videoCollectionView setHidden:NO];
        [_bottomButtonsView setHidden:NO];
        isReportButtonTapped = NO;
        
    }
    if (isChannelSelected){
//        [_channelCollectionView setHidden:YES];
//        [_mixChannelView setHidden:NO];
        searchLbl.hidden = YES;
         _channelMixBtn.hidden = NO;
        
    }else if(isSearchTapped){
//        [_channelCollectionView setHidden:YES];
//        [_mixChannelView setHidden:NO];
        searchLbl.hidden = NO;
        //        isSearchTapped = NO;
        
    }
    else{
//        [_channelCollectionView setHidden:NO];
//        [_mixChannelView setHidden:YES];
        searchLbl.hidden = YES;
        
    }
     [_channelCollectionView setHidden:NO];
    [_loadingView removeFromSuperview];
    [_activityIndicator stopAnimating];
    [_activityIndicator setHidesWhenStopped:YES];
    [loadingLabel removeFromSuperview];
    
    
    _keyBoardBtn.userInteractionEnabled=YES;
    @try {
        [videosssCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    } @catch (NSException *exception) {
        NSLog(@"exception is %@", exception);
    }
    NSLog(@"About to exit requestSuccessful...............");
    
}
#pragma mark - scrollview delegate

-(void)requestFailed:(NSNumber *)result{
    
    self.view.userInteractionEnabled = true;
    
    NSLog(@" GlobalFeedViewController  near video Request unsuccesfull with statuscode :%li",(long)[result integerValue]);
    [videosssCollection setHidden:NO];
    [_channelCollectionView setHidden:NO];
    [_loadingView removeFromSuperview];
    [_activityIndicator stopAnimating];
    [_activityIndicator setHidesWhenStopped:YES];
    [loadingLabel removeFromSuperview];
    
    //    [NSTimer scheduledTimerWithTimeInterval:3
    //                                     target:self
    //                                   selector:@selector(removeLoading)
    //                                   userInfo:nil
    //                                    repeats:NO];
    if([result integerValue]==-999){
        
    }else{
    }
    
    if([result integerValue]==403){
        //        [self.view setUserInteractionEnabled:YES];
        //        [Utility pushLoginViewController:self];
    }else if([result integerValue]==-999){
        
    }
    else{
        
        //        [self.view setUserInteractionEnabled:YES];
        
        NSLog(@" RegisterViewController Register Request Failed with statuscode :  %@",result);
        
        
    }
    
    //    [_bottomButtonsView setHidden:NO];
    
}
-(void)removeLoading{
    [_loadingView removeFromSuperview];
    
}
-(void)fatchTopGlobalVideoswithLatitude:(NSString *)_latitude Logintitude:(NSString *)_longitude Distance:(NSString *)_distance searchText:(NSString *)_searchtext isFromIMesaage:(BOOL)_isFromIMesaage{
    
    //    self.view.userInteractionEnabled = false;
    
    NSDate *csrfmethodStart = [NSDate date];
    
    NSURL *dataUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/csrftoken",SERVER_ADDRESS]];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:dataUrl];
    
    NSDictionary *sheaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    NSLog(@" WebServices  cookies dictionary is  : %@",sheaders);
    
    for (NSOperation *operation in videoIdManager.operationQueue.operations) {
        [operation cancel];
        [_loadingView removeFromSuperview];
    }
    
    videoIdManager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"Remember Found....!");
    
    [videoIdManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [videoIdManager.requestSerializer setValue:@"centric-mobile" forHTTPHeaderField:@"User-Agent"];
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"token"];
    [videoIdManager.requestSerializer setValue:token forHTTPHeaderField:@"X-CSRF-TOKEN"];
    [videoIdManager.requestSerializer setValue:[sheaders valueForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    
    NSLog(@" WebServices  Csrf Token is : %@",token);
    
    if (![AFNetworkReachabilityManager sharedManager].reachable){
        videoIdManager.requestSerializer.cachePolicy=NSURLRequestReturnCacheDataElseLoad;
    }
    
    NSDate *csrfmethodFinish = [NSDate date];
    NSTimeInterval executionTime = [csrfmethodFinish timeIntervalSinceDate:csrfmethodStart];
    NSLog(@"csrf executionTime = %f", executionTime);
    
    NSString *date=[NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSince1970]];
    NSString *finalString = [_searchtext stringByReplacingOccurrencesOfString:@" " withString: @"%20"];
    
    NSString * url;
    
    //    _latitude = @"36.778259";
    //    _longitude = @"-119.417931";
    
    
    _latitude = @"40.730610";
    _longitude = @"-73.935242";
    
    NSString *channelId;
    //    if (isGreenIconTapped) {
    channelId= @"5";
    //    }else{
    //        channelId= [Settings getSelectedChannelId];
    //    }
    
    if (finalString.length > 0 && (isSearchTapped || isSpacePressed || isSearchHit)) {
        isSearchTop = YES;
        url = [NSString stringWithFormat:@"%@api/fetchpublicvideos?longitude=%@&latitude=%@&distance=%@&searchtext=%@&ts=%@&isFromIMesaage=%d&isKeyBoard=%d&isLocal=%d",SERVER_ADDRESS,_longitude,_latitude,@"",finalString,date,0,1,0];
    }
    
    else
    {
        url  = [NSString stringWithFormat:@"%@api/fetchallvideosofaInfotainmentfornewbuild/%@?latitude=%@&longitude=%@&distance=%@&ts=%@&isFromIMesaage=%d&isKeyBoard=%d&isLocal=%d",SERVER_ADDRESS,channelId,_latitude,_longitude,@"50",@"22.0",0,1,0];
    }
    
    NSLog(@"Thumbnails WebService: %@",url);
    
    NSURL *urlApi = [NSURL URLWithString:url];
    
    __block NSURLRequest *urlString = [NSURLRequest requestWithURL:urlApi];
    __block NSURLRequest *request = nil;
    __block NSNumber *result;
    NSDate *thumbnailsMethodStart = [NSDate date];
    
    [videoIdManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@" WebServices ResponseObject info :%@",responseObject);
        NSLog(@"HEADERS: %@", operation.response.allHeaderFields);
        
        NSDate *thumnailsmethodFinish = [NSDate date];
        NSTimeInterval executionTime = [thumnailsmethodFinish timeIntervalSinceDate:thumbnailsMethodStart];
        NSLog(@"thumnails executionTime = %f", executionTime);
        
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        int number=[self topParseGlobalVideoReponse:responseObject];
        if (number==0) {
            
            
            result = [NSNumber numberWithInt:number];
            
            
            [self topVideosRequestSuccessful:result];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSInteger statusCode;
        statusCode = operation.response.statusCode;
        
        NSData *data;
        
        NSLog(@"data is:%@",data);
        
        if (data)
        {
            NSDictionary *jsonObject=[NSJSONSerialization
                                      JSONObjectWithData:data
                                      options:NSJSONReadingMutableLeaves
                                      error:nil];
            
            NSLog(@"response cache data:%@",jsonObject);
            
            int number=[self topParseGlobalVideoReponse:jsonObject];
            if (number==0) {
                
                
                result = [NSNumber numberWithInt:number];
                
                
                [self topVideosRequestSuccessful:result];
                
            }
        }else{
            
            [self topVideosRequestFailed:result];
            
        }
        
    }];
    
    @try {
        //        [videosssCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    } @catch (NSException *exception) {
        NSLog(@"exception is %@", exception);
    }
    //    isSearchTapped = NO;
}

- (int)topParseGlobalVideoReponse:(id)_response{
    self.view.userInteractionEnabled = true;
    NSLog(@"JsonParserClass enter parseGlobalVideoReponse");
    //PersonalVideo *perVideoObj;
    NSMutableArray *lastesVideoArray,*allVideoArray;
    //    NSLog(@"response: %@",_response);
    NSDictionary *jsonDictionary=[[NSDictionary alloc] initWithDictionary:_response];
    
    BOOL tutorialValue=[[jsonDictionary objectForKey:@"tutorialOn"] boolValue];
    //    [Settings setGlobalTutorialValue:tutorialValue];
    NSLog(@"tutorial value is %d",tutorialValue);
    NSString *distanceListIsEmpty=[jsonDictionary objectForKey:@"distanceListIsEmpty"];
    NSString *listIsEmpty=[jsonDictionary objectForKey:@"listIsEmpty"];
    //    NSString *totalNotificationCount=[jsonDictionary objectForKey:@"totalNotificationsCount"];
    //    [Settings setTotalNotificationCount:[totalNotificationCount integerValue]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"totalNotificationsCount"
                                                        object:nil];
    NSString *userNameSearched=[jsonDictionary objectForKey:@"userNameSearched"];
    NSLog(@"listIsEmpty value is %@ ",listIsEmpty);
    
    if ([jsonDictionary valueForKey:@"allvideoListLoadMoreUrl"]&& ![[jsonDictionary objectForKey:@"allvideoListLoadMoreUrl"] isKindOfClass:[NSNull class]]) {
        NSString *loadMore=[jsonDictionary objectForKey:@"allvideoListLoadMoreUrl"];
        if (![loadMore isEqualToString:@"null"]) {
            
            isLoadingMoreTop=YES;
            
            
            loadMoreUrlTopFeed = [jsonDictionary valueForKey:@"allvideoListLoadMoreUrl"];
            
        }else{
            loadMoreUrlTopFeed = @"";
            isLoadingMoreTop= NO;
        }
        
    }else{
        
        //        [Settings setGlobalMainLoadMoreUrl:@""];
        loadMoreUrlTopFeed = @"";
        isLoadingMoreTop= NO;
        
    }
    
    if ([jsonDictionary objectForKey:@"latestvideoList"] || [jsonDictionary objectForKey:@"allvideoList"]) {
        
        if ([jsonDictionary objectForKey:@"allvideoList"]) {
            
            NSMutableArray *lastedVideoArray=[jsonDictionary objectForKey:@"allvideoList"];
            NSLog(@"enter into Allvideo Array ");
            
            allVideoArray=[[NSMutableArray alloc] init];
            GlobalVideo *perVideoObj=[[GlobalVideo alloc] init];
            perVideoObj.cdnThumbnail=@"HotNow2.png";
            //            [allVideoArray addObject:perVideoObj];
            
            
            
            for (NSDictionary *videoObjectDic in lastedVideoArray) {
                
                NSLog(@"enter into Allvideo Loop:");
                
                GlobalVideo *perVideoObj=[[GlobalVideo alloc] init];
                perVideoObj.videoId=[NSString stringWithFormat:@"%zd",[[videoObjectDic objectForKey:@"videoId"] integerValue]];
                perVideoObj.cdnUrl=[videoObjectDic objectForKey:@"cdnUrl"];
                perVideoObj.cdnThumbnail=[videoObjectDic objectForKey:@"cdnThumbnail"];
                //                perVideoObj.location=[videoObjectDic objectForKey:@"location"];
                perVideoObj.uploadingDate=[videoObjectDic objectForKey:@"uploadingDate"];
                perVideoObj.topNotification=[videoObjectDic objectForKey:@"topNotificaitonText"];
                perVideoObj.trendingTag = [videoObjectDic objectForKey:@"tag"];
                
                //                perVideoObj.tags=[videoObjectDic objectForKey:@"topNotificaitonText"];
                //                perVideoObj.views=[videoObjectDic objectForKey:@"views"];
                //                perVideoObj.city=[videoObjectDic objectForKey:@"city"];
                //                perVideoObj.country=[videoObjectDic objectForKey:@"country"];
                //                perVideoObj.ispublic=[[videoObjectDic objectForKey:@"public"] boolValue];
                //                perVideoObj.anonymous=[[videoObjectDic objectForKey:@"anonymous"] boolValue];
                //                perVideoObj.videoFavroute=[[videoObjectDic objectForKey:@"videoFavroute"] boolValue];
                //                perVideoObj.videoOwnerInFollowing=[[jsonDictionary valueForKey:@"videoOwnerInFollowing"]boolValue];
                //                perVideoObj.loggedInUserOwnVideo=[[jsonDictionary valueForKey:@"loggedInUserOwnVideo"]boolValue];
                
                
                perVideoObj.tags=[videoObjectDic valueForKey:@"tags"];
                NSArray *tags=[[NSArray alloc] initWithArray:[videoObjectDic valueForKey:@"tags"]];
                NSString *tagsString=@"";
                for (int i=0; i<tags.count; i++) {
                    tagsString=[tagsString stringByAppendingString:[NSString stringWithFormat:@"#%@ ",[tags objectAtIndex:i ]]];
                }
                NSLog(@"tags are:%@ ",tagsString);
                perVideoObj.isSocial=[[videoObjectDic valueForKey:@"social"] boolValue];
                perVideoObj.socialUrl=[videoObjectDic valueForKey:@"socialLink"];
                //                NSLog(@"social url is %@",perVideoObj.socialUrl);
                perVideoObj.userName=[videoObjectDic valueForKey:@"userName"];
                
                perVideoObj.isYoutubeVideo=[[videoObjectDic valueForKey:@"youTube"] boolValue];
                perVideoObj.isInstagramVideo=[[videoObjectDic valueForKey:@"insta"] boolValue];
                perVideoObj.isTwitchGameVideo=[[videoObjectDic valueForKey:@"twitch"] boolValue];
                perVideoObj.isTwitterVideo=[[videoObjectDic valueForKey:@"twitter"] boolValue];
                perVideoObj.isPeriscopeVideo=[[videoObjectDic valueForKey:@"periscope"] boolValue];
                perVideoObj.isFacebookLive = [[videoObjectDic valueForKey:@"facebookLive"] boolValue];
                perVideoObj.isCentric = [[videoObjectDic valueForKey:@"centric"] boolValue];
                perVideoObj.channelThumbnail = [videoObjectDic valueForKey:@"channelThumbnail"];
                
                
                //                NSLog(@" Thumnil value : %@",perVideoObj.cdnThumbnail);
                
                [allVideoArray addObject:perVideoObj];
                [Settings setVideoObject:perVideoObj];
            }
            NSLog(@"All Video Array number : %lu",(unsigned long)allVideoArray.count);
            NSLog(@"The all Video array is %@", [allVideoArray objectAtIndex:0]);
            [latestglobalVideo removeAllObjects];
            [latestglobalVideo addObjectsFromArray:allVideoArray];
            //            [Settings setGlobalAllVideos:allVideoArray];
        }
        NSLog(@"JsonParserClass exit parseGlobalVideoReponse with return 0");
        return 0;
        
    }
    
    NSLog(@"JsonParserClass exit parseGlobalVideoReponse with return 1");
    return 1;
}

-(void)topVideosRequestSuccessful:(NSNumber *)result{
    
    self.view.userInteractionEnabled = YES;
    if ([result integerValue]==0) {
        
        //       _keyButtonView.hidden= NO;
        //        _channelView.hidden = NO;
        _channelCollectionView.hidden =YES;
        [_mixChannelView setHidden:YES];
        //        _bottomButtonsView.hidden= YES;
    }
    else{
        
    }
    //    [self.view setUserInteractionEnabled:YES];
    bgImage = nil;
    bgImage.image = nil;
    [bgImage setNeedsDisplay];
    isVideosLoaded =YES;
    _topVideosCollection.delegate= self;
    _topVideosCollection.dataSource= self;
    [_topVideosCollection reloadData];
    
    [_loadingView removeFromSuperview];
    
    [_activityIndicator stopAnimating];
    [_activityIndicator setHidesWhenStopped:YES];
    [loadingLabel removeFromSuperview];
    
    //    [Settings setSelecetedChannelId:@"5"];
    
    
    if ((!isSpacePressed || isTvIconTapped) ) {
        //        [self fatchGlobalVideoswithLatitude:latitude Logintitude:longitude Distance:@"22.0" searchText:@"" isFromIMesaage:YES];
    }else{
        
    }
    [_keyButtonView setHidden:NO];
    //    if(!isFirstTime){
    //        [self stopPlayingVideo];
    //
    //    }
    
    isFirstTime = NO;
   
    
    //    [_keyBoardBtn setImage:[UIImage imageNamed:@"channel"] forState:UIControlStateNormal];
    @try {
        [_topVideosCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    } @catch (NSException *exception) {
        NSLog(@"exception is %@", exception);
    }
}

-(void)topVideosRequestFailed:(NSNumber *)result{
    
    self.view.userInteractionEnabled = true;
    
    NSLog(@" GlobalFeedViewController  near video Request unsuccesfull with statuscode :%li",(long)[result integerValue]);
    
    if([result integerValue]==-999){
        
    }else{
    }
    
    if([result integerValue]==403){
        //        [self.view setUserInteractionEnabled:YES];
        //        [Utility pushLoginViewController:self];
    }else if([result integerValue]==-999){
        
    }
    else{
        
        //        [self.view setUserInteractionEnabled:YES];
        
        NSLog(@" RegisterViewController Register Request Failed with statuscode :  %@",result);
        //        NSString *erroCode=[Utility errorTitleForCode:[result integerValue]];
        //        NSString *erroMessage=[Utility errorMessageForCode:[result integerValue]];
        //        [Utility showAlert:erroCode message:erroMessage];
        
    }
    
    //    [_bottomButtonsView setHidden:NO];
    
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         
         screenRect = [[UIScreen mainScreen] bounds];
         screenWidth = screenRect.size.width;
         screenHeight = screenRect.size.height;
         
         [videosssCollection reloadData];
     } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         
     }];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize defaultSize = [(UICollectionViewFlowLayout*)collectionViewLayout itemSize];
    
    NSLog(@"screen width:%f", screenWidth);
    if(collectionView==videosssCollection)
    {
        UIScreen *mainScreen = [UIScreen mainScreen];
        
        
        if (mainScreen.bounds.size.height == 568)
        {
            return CGSizeMake(300 , screenWidth/2);
        }
        
        else if (mainScreen.bounds.size.height == 736)
        {
//            return CGSizeMake(screenWidth-20 , screenWidth/2);
            return CGSizeMake(300 , screenWidth/2);

            
        }else if(mainScreen.bounds.size.height == 667){
//            return CGSizeMake(screenWidth-130 , screenWidth/2);
            return CGSizeMake(300 , screenWidth/2);

        }
        else if(mainScreen.bounds.size.height == 812){

            
            return CGSizeMake(300 , screenWidth/2);
            
        }
        else{
            
//            return CGSizeMake(screenWidth-20 , screenWidth/2);
            return CGSizeMake(300 , screenWidth/2.2);

        }
        
    }
    else{
        defaultSize = CGSizeMake(150, 100);
    }
    
    return defaultSize;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    if (view == videosssCollection) {
        
        NSString *loadMoreMain=[Settings getGlobalMainLoadMoreUrl];
        if ((loadMoreMain && ![loadMoreMain isEqualToString:@""]) && isLoadingMoreMain) {
            return allGlobalvideos.count+1;
        }else{
            return allGlobalvideos.count;
        }
        
    }else{
        if (!isVideosLoaded) {
            return 12;
        }else{
            return latestglobalVideo.count + 1;
        }
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(nonnull UICollectionViewCell *)cell {
    UILabel * chanel = (UILabel *)[cell viewWithTag:400];
    
//    chanel.text = [NSString stringWithFormat:@"%@ -", [Settings getSelectedChannelName]];
//    NSLog(@"channel name is : %@", personalObj.userName);
    
//    NSLog(@"cell value is:%@",)
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGRect visibleRect = (CGRect){.origin = videosssCollection.contentOffset, .size = videosssCollection.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [videosssCollection indexPathForItemAtPoint:visiblePoint];
    if(visibleIndexPath.row < allGlobalvideos.count){
        //        if(visibleIndexPath.row == 0){
        NSLog(@"current index row is: %ld", visibleIndexPath.row);
        if(visibleIndexPath.row == 0){
            globalObj = [allGlobalvideos objectAtIndex:visibleIndexPath.row];
            NSLog(@"inside dispatch async block main thread from main thread");
            if(isSearchTapped){
//                _selectedChannelNamelbl.text = [NSString stringWithFormat:@"%@ -", globalObj.channelName];

            }
           else if([[Settings getSelectedChannelId]isEqual:@"16"]){
                
                _selectedChannelNamelbl.text = [NSString stringWithFormat:@"Fresh Now from -%@ ", globalObj.channelName];
                
            }else{
                
                _selectedChannelNamelbl.text = [NSString stringWithFormat:@"%@ -", globalObj.channelName];
                
            }
            
            //
            _currentUserNamelbl.text = [NSString stringWithFormat:@"@%@", globalObj.userName];
            NSLog(@"user name hre is :%@", globalObj.userName);
            NSLog(@"channel name hte is :%@", globalObj.channelName);
            //            return;
        }
    }}
-(void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGRect visibleRect = (CGRect){.origin = videosssCollection.contentOffset, .size = videosssCollection.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [videosssCollection indexPathForItemAtPoint:visiblePoint];
    if(visibleIndexPath.row < allGlobalvideos.count){
//        if(visibleIndexPath.row == 0){
            NSLog(@"current index row is: %ld", visibleIndexPath.row);
        if(visibleIndexPath.row == 0){
            return;
        }
            globalObj = [allGlobalvideos objectAtIndex:visibleIndexPath.row];
            NSLog(@"inside dispatch async block main thread from main thread");
        if(isSearchTapped){
//            _selectedChannelNamelbl.text = [NSString stringWithFormat:@"%@ -", globalObj.channelName];
            
        }
         else  if([[Settings getSelectedChannelId]isEqual:@"16"]){
                _selectedChannelNamelbl.text = [NSString stringWithFormat:@"Fresh Now from -%@ ", globalObj.channelName];

            }else{
                _selectedChannelNamelbl.text = [NSString stringWithFormat:@"%@ -", globalObj.channelName];

            }

            //
            _currentUserNamelbl.text = [NSString stringWithFormat:@"@%@", globalObj.userName];
            NSLog(@"user name hre is :%@", globalObj.userName);
            NSLog(@"channel name hte is :%@", globalObj.channelName);
//            return;
        

    }
//    [self checkWhichVideoToEnable];
}
-(void)checkWhichVideoToEnable
{
    for(UICollectionViewCell *cell in [videosssCollection visibleCells])
    {
        if([cell isKindOfClass:[UICollectionViewCell class]])
        {
            NSIndexPath *indexPath = [videosssCollection indexPathForCell:cell];
            
            UICollectionViewLayoutAttributes *attributes = [videosssCollection layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
            CGRect cellRect = [attributes frame];
            

            UIView *superview = videosssCollection.superview;
            
            CGRect convertedRect=[videosssCollection convertRect:cellRect toView:superview];
            CGRect intersect = CGRectIntersection(videosssCollection.frame, convertedRect);
            float visibleHeight = CGRectGetWidth(intersect);
            
            if(visibleHeight>200*0.6) // only if 60% of the cell is visible
            {
                // unmute the video if we can see at least half of the cell
//                [((VideoMessageCell*)cell) muteVideo:!btnMuteVideos.selected];
                NSLog(@"displayeddddddd at index:%ld", (long)indexPath.row);
            }
            else
            {
                // mute the other video cells that are not visible
//                [((VideoMessageCell*)cell) muteVideo:YES];
            }
        }
    }
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == videosssCollection) {


        if (indexPath.row == allGlobalvideos.count - 1 && isLoadingMoreMain)  {
            //                [self loadMoreData];
        }
    }else{
        
        if (indexPath.row == latestglobalVideo.count - 1 && isLoadingMoreTop)  {
            
            //            [self loadMoreDataOfTopVideos];
            
        }
    }
    
}
-(void)loadMoreDataOfTopVideos{
    
    //    BOOL switchValue= [[Settings getSwitchState] isOn];
    //    NSLog(@"Btn State is : %d", switchValue);
    
    if (![loadMoreUrlTopFeed isEqualToString:@""]) {
        
        videoIdManager = [AFHTTPRequestOperationManager manager];
        videoIdManager.securityPolicy.allowInvalidCertificates = YES;
        [videoIdManager.requestSerializer setValue:@"centric-mobile" forHTTPHeaderField:@"User-Agent"];
        
        if (![AFNetworkReachabilityManager sharedManager].reachable){
            videoIdManager.requestSerializer.cachePolicy=NSURLRequestReturnCacheDataElseLoad;
        }
        
        NSString *urlString;
        
        NSString *encoded = [loadMoreUrlTopFeed stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //        if (switchValue) {
        //            urlString = [NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,loadMoreUrlTopFeed];
        //
        //        }else{
        urlString = [NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,encoded];
        //        }
        
        NSLog(@" WebServices  Server address : %@",urlString);
        [videoIdManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@" WebServices Response Json is :%@",operation.responseString);
            NSDictionary *responseArry=[[NSDictionary alloc] initWithDictionary:responseObject];
            //moreVideosArry=[JsonParserClass parseLoadMoreGlabalMainVideos:responseArry];
            
            moreTopVideosArry=[self parseLoadMoreGlabalTopVideos:responseArry];
            
            [latestglobalVideo addObjectsFromArray:moreTopVideosArry];
            
            
            NSString *loadMoreMain=loadMoreUrlTopFeed;
            
            if ([loadMoreMain isEqualToString:@""]) {
                isLoadingMoreTop=NO;
            }else{
                isLoadingMoreTop=YES;
            }
            [_topVideosCollection reloadData];
            
        } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            
            NSLog(@"load more request fail %@", error.description);
            
        }];
        
    }
    
    isLoadingMoreTop = false;
}
-(NSMutableArray*)parseLoadMoreGlabalTopVideos:(NSDictionary*)_response{
    
    NSDictionary *jsonDictionary=[[NSDictionary alloc] initWithDictionary:_response];
    NSMutableArray* allVideoArray=[[NSMutableArray alloc] init];
    
    if ([jsonDictionary valueForKey:@"allvideoListLoadMoreUrl"]&& ![[jsonDictionary objectForKey:@"allvideoListLoadMoreUrl"] isKindOfClass:[NSNull class]]) {
        NSString *loadMore=[jsonDictionary objectForKey:@"allvideoListLoadMoreUrl"];
        if (![loadMore isEqualToString:@"null"]) {
            
            //            [settingValues setGlobalTopLoadMoreUrl:[jsonDictionary valueForKey:@"allvideoListLoadMoreUrl"]];
            loadMoreUrlTopFeed =[jsonDictionary valueForKey:@"allvideoListLoadMoreUrl"];
            
        }else{
            //            [settingValues setGlobalTopLoadMoreUrl:@""];
            loadMoreUrlTopFeed = @"";
        }
    }else{
        //        [settingValues setGlobalTopLoadMoreUrl:@""];
        loadMoreUrlTopFeed = @"";
    }
    
    if ([jsonDictionary objectForKey:@"allvideoList"]) {
        NSMutableArray *lastedVideoArray=[jsonDictionary objectForKey:@"allvideoList"];
        NSLog(@"enter into Allvideo Array ");
        for (NSDictionary *videoObjectDic in lastedVideoArray) {
            NSLog(@"enter into Allvideo Loop:  ");
            GlobalVideo *perVideoObj=[[GlobalVideo alloc] init];
            
            perVideoObj.videoId=[NSString stringWithFormat:@"%zd",[[videoObjectDic objectForKey:@"videoId"] integerValue]];
            perVideoObj.cdnUrl=[videoObjectDic objectForKey:@"cdnUrl"];
            perVideoObj.cdnThumbnail=[videoObjectDic objectForKey:@"cdnThumbnail"];
            perVideoObj.location=[videoObjectDic objectForKey:@"location"];
            perVideoObj.uploadingDate=[videoObjectDic objectForKey:@"uploadingDate"];
            perVideoObj.views=[videoObjectDic objectForKey:@"views"];
            perVideoObj.city=[videoObjectDic objectForKey:@"city"];
            perVideoObj.country=[videoObjectDic objectForKey:@"country"];
            perVideoObj.ispublic=[[videoObjectDic objectForKey:@"public"] boolValue];
            perVideoObj.anonymous=[[videoObjectDic objectForKey:@"anonymous"] boolValue];
            perVideoObj.isSocial=[[videoObjectDic valueForKey:@"social"] boolValue];
            perVideoObj.videoFavroute=[[videoObjectDic objectForKey:@"videoFavroute"] boolValue];
            perVideoObj.socialUrl=[videoObjectDic valueForKey:@"socialLink"];
            perVideoObj.channelThumbnail = [videoObjectDic valueForKey:@"channelThumbnail"];
            perVideoObj.channelName = [videoObjectDic valueForKey:@"channelName"];

            
            perVideoObj.youtube=[[videoObjectDic objectForKey:@"youTube"] boolValue];
            perVideoObj.isTwitter=[[videoObjectDic objectForKey:@"twitter"] boolValue];
            //            NSLog(@"is Twitter Video %D",perVideoObj.isTwitter);
            perVideoObj.liveStreaming=[[videoObjectDic objectForKey:@"liveStreaming"] boolValue];
            
            
            perVideoObj.isYoutubeVideo=[[videoObjectDic valueForKey:@"youTube"] boolValue];
            perVideoObj.isInstagramVideo=[[videoObjectDic valueForKey:@"insta"] boolValue];
            perVideoObj.isTwitchGameVideo=[[videoObjectDic valueForKey:@"twitch"] boolValue];
            perVideoObj.isTwitterVideo=[[videoObjectDic valueForKey:@"twitter"] boolValue];
            perVideoObj.isPeriscopeVideo=[[videoObjectDic valueForKey:@"periscope"] boolValue];
            perVideoObj.isFacebookLive = [[videoObjectDic valueForKey:@"facebookLive"] boolValue];
            perVideoObj.isCentric = [[videoObjectDic valueForKey:@"centric"] boolValue];
            
            //            NSLog(@"social url is %@",perVideoObj.socialUrl);
            perVideoObj.videoOwnerInFollowing=[[jsonDictionary valueForKey:@"videoOwnerInFollowing"]boolValue];
            perVideoObj.loggedInUserOwnVideo=[[jsonDictionary valueForKey:@"loggedInUserOwnVideo"]boolValue];
            perVideoObj.tags=[videoObjectDic valueForKey:@"tags"];
            perVideoObj.userName=[videoObjectDic valueForKey:@"userName"];
            //            NSLog(@" Thumnil value : %@",perVideoObj.cdnThumbnail);
            perVideoObj.isVideoPlaying=NO;
            [allVideoArray addObject:perVideoObj];
            
        }
        NSLog(@"All Video Array number : %lu",(unsigned long)allVideoArray.count);
    }
    return allVideoArray;
}
-(void)loadMoreData{
    
    loadMoreUrlMainFeed = [Settings getGlobalMainLoadMoreUrl];
    
    NSLog(@"load more url is;;;;;;;;;;;;;;;;;;;;;;;; :%@",[Settings getGlobalMainLoadMoreUrl]);
    NSLog(@"load more url is;;;;;;;;;;;;;;;;;;;;;;;; :%@",loadMoreUrlMainFeed);
    
    
    if (![loadMoreUrlMainFeed isEqualToString:@""]) {
        
        videoIdManager = [AFHTTPRequestOperationManager manager];
        videoIdManager.securityPolicy.allowInvalidCertificates = YES;
        [videoIdManager.requestSerializer setValue:@"centric-mobile" forHTTPHeaderField:@"User-Agent"];
        
        if (![AFNetworkReachabilityManager sharedManager].reachable){
            videoIdManager.requestSerializer.cachePolicy=NSURLRequestReturnCacheDataElseLoad;
        }
        
        NSString *urlString;
        NSString *encoded = [loadMoreUrlMainFeed stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        //        if (switchValue) {
        //            urlString = [NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,loadMoreUrlMainFeed];
        //
        //        }else{
        urlString = [NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,encoded];
        //        }
        
        NSLog(@" WebServices  Server address : %@",urlString);
        [videoIdManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@" WebServices Response Json is :%@",operation.responseString);
            NSDictionary *responseArry=[[NSDictionary alloc] initWithDictionary:responseObject];
            //            moreVideosArry=[JsonParserClass parseLoadMoreGlabalMainVideos:responseArry];
            
            moreVideosArry=[JsonParserClass parseLoadMoreGlabalMainVideos:responseArry];
            [allGlobalvideos addObjectsFromArray:moreVideosArry];
            
            NSString *loadMoreMain=[Settings getGlobalMainLoadMoreUrl];
            
            if ([loadMoreMain isEqualToString:@""]) {
                isLoadingMoreMain=NO;
            }else{
                
                isLoadingMoreMain=YES;
            }
            [videosssCollection reloadData];
            
        } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            
            NSLog(@"load more request fail %@", error.description);
            
        }];
        
    }
    
    isLoadingMoreMain = false;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    path = indexPath;
    
    //    cell.backgroundColor= [UIColor lightGrayColor];
    UIImageView *customImageView;
    if (cell == nil) {
        cell  = [videosssCollection dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell  = [_topVideosCollection dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
    }
    else if (cell == nil)
    {
        cell  = [cv dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    }
    else if (cell == nil)
    {
        
    }

    cell.layer.cornerRadius = 15;
    
  

//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    [animation setFromValue:[NSNumber numberWithFloat:1.0]];
//    [animation setToValue:[NSNumber numberWithFloat:0.5]];
//    [animation setDuration:0.3f];
//    [animation setTimingFunction:[CAMediaTimingFunction
//                                  functionWithName:kCAMediaTimingFunctionLinear]];
//    [animation setAutoreverses:YES];
//    [animation setRepeatCount:20000];
//
//    if(isVideosLoaded){
//
//        [[cell layer] removeAnimationForKey:@"opacity"];
//    }else{
//        [[cell layer] addAnimation:animation forKey:@"opacity"];
//
//    }
    
    if (cv == videosssCollection) {
       
        if (indexPath.row==[allGlobalvideos count]) {
            
            loadMoreCell = [videosssCollection dequeueReusableCellWithReuseIdentifier:@"LoadMoreCell" forIndexPath:indexPath];
            
            UIActivityIndicatorView *loadMoreIndicator = (UIActivityIndicatorView *)[loadMoreCell viewWithTag:10];
            [loadMoreIndicator startAnimating];
            [loadMoreCell setHidden:NO];
            
            if (![[Settings getGlobalMainLoadMoreUrl] isEqualToString:@""]) {
                [loadMoreCell setHidden:NO];
                [self loadMoreData];
                
            }else
            {
                [loadMoreCell setHidden:YES];
            }
            return loadMoreCell;
            
        }else{
            NSLog(@"No loadmore ... !");
        }
        
        customImageView = (UIImageView *)[cell viewWithTag:99];
        customImageView.contentMode = UIViewContentModeScaleAspectFill;
        customImageView.clipsToBounds=YES;
        
        UILabel  *tagslbl = (UILabel *)[cell viewWithTag:900];
        
        UILabel  *titlelbl = (UILabel *)[cell viewWithTag:700];
        titlelbl.layer.cornerRadius = 2;
//        userNamelbl.layer.cornerRadius = 2;
//        userNamelbl.clipsToBounds=YES;
        titlelbl.clipsToBounds=YES;
        
        UIView  *roundView = (UIView *)[cell viewWithTag:200];
        roundView.layer.cornerRadius = 10;
        roundView.layer.masksToBounds = true;

        if (allGlobalvideos.count>0 && allGlobalvideos.count > indexPath.row) {
            personalObj = [allGlobalvideos objectAtIndex:indexPath.row];
            
            NSLog(@"content offset is:%f", cell.frame.origin.x);
            NSLog(@"content offset is:%f", videosssCollection.contentOffset.y);

            if(indexPath.row == 0){
                if(isSearchTapped){
                    
                }
              else  if([[Settings getSelectedChannelId]isEqual:@"16"]){
                                        _selectedChannelNamelbl.text = [NSString stringWithFormat:@"Fresh Now from -%@ ", personalObj.channelName];
                    
                                    }else{
                                        _selectedChannelNamelbl.text = [NSString stringWithFormat:@"%@ -", personalObj.channelName];
                    
                                    }
                                    _currentUserNamelbl.text = [NSString stringWithFormat:@"@%@", personalObj.userName];
            }
            
            //            if(indexPath.row > 0){
            //                globalObj = [allGlobalvideos objectAtIndex:visibleIndexPath.row];
           
//
                if(!isSearchTapped){
                        if ([personalObj.channelName isEqual:@"Life"] || [globalObj.channelName isEqual:@"Life"]){

                            _selectedChannelNamelbl.textColor = [UIColor colorWithRed:199/255.0 green:80/255.0 blue:151/255.0 alpha:1.0];

                        }else if ([personalObj.channelName isEqual:@"Music"] || [globalObj.channelName isEqual:@"Music"]){
                            _selectedChannelNamelbl.textColor = [UIColor colorWithRed:79/255.0 green:150/255.0 blue:241/255.0 alpha:1.0];


                        }else if ([personalObj.channelName isEqual:@"News"] || [globalObj.channelName isEqual:@"News"]){
                            _selectedChannelNamelbl.textColor = [UIColor colorWithRed:205/255.0 green:17/255.0 blue:52/255.0 alpha:1.0];


                        }else if ([personalObj.channelName isEqual:@"Food"] || [globalObj.channelName isEqual:@"Food"]){
                            _selectedChannelNamelbl.textColor = [UIColor colorWithRed:119/255.0 green:218/255.0 blue:179/255.0 alpha:1.0];


                        }else if ([personalObj.channelName isEqual:@"Gfycat"] || [globalObj.channelName isEqual:@"Gfycat"]){
                            _selectedChannelNamelbl.textColor = [UIColor colorWithRed:46/255.0 green:66/255.0 blue:255/255.0 alpha:1.0];


                        }else if ([personalObj.channelName isEqual:@"Sports"] || [globalObj.channelName isEqual:@"Sports"]){
                            _selectedChannelNamelbl.textColor = [UIColor colorWithRed:231/255.0 green:144/255.0 blue:64/255.0 alpha:1.0];


                        }else if ([personalObj.channelName isEqual:@"Games"] || [globalObj.channelName isEqual:@"Games"]){
                            _selectedChannelNamelbl.textColor = [UIColor colorWithRed:136/255.0 green:197/255.0 blue:48/255.0 alpha:1.0];
                                }


//                    _selectedChannelNamelbl.text = [NSString stringWithFormat:@"%@ -", personalObj.channelName];
                }
            
          
//            }
//                else if (indexPath.row > 1){
//                globalObj = [allGlobalvideos objectAtIndex:indexPath.row-2];
//                _selectedChannelNamelbl.text = [NSString stringWithFormat:@"%@ -", globalObj.channelName];
//
//                _currentUserNamelbl.text = [NSString stringWithFormat:@"@%@", globalObj.userName];
//            }
//            else{
//                globalObj = [allGlobalvideos objectAtIndex:indexPath.row];
//                _selectedChannelNamelbl.text = [NSString stringWithFormat:@"%@ -", globalObj.channelName];
//
//                _currentUserNamelbl.text = [NSString stringWithFormat:@"@%@", globalObj.userName];
//            }
            
            
           
            //            titlelbl.text = personalObj.;
            NSString *tagsString=@"";
            NSLog(@"description is:%@", personalObj.description);
        
            if((personalObj.description != NULL && ![personalObj.description isEqual:@"<null>"]) && ![personalObj.description isKindOfClass:[NSNull class]]){
                NSString *tempstring = personalObj.description;
                if ([tempstring length] > 45) {
                    NSRange range = [tempstring rangeOfComposedCharacterSequencesForRange:(NSRange){0, 45}];
                    tempstring = [tempstring substringWithRange:range];
                    tempstring = [tempstring stringByAppendingString:@"…"];
                }
               
                titlelbl.text = tempstring;
                
                [titlelbl setHidden:NO];
            }else{
               
            }
            
            if(personalObj.tags.count > 0){
                int j = 0;
                for (int i=0; i<personalObj.tags.count; i++) {
                    if(j < 2){
                        tagsString=[tagsString stringByAppendingString:[NSString stringWithFormat:@"#%@ ",[personalObj.tags objectAtIndex:i]]];
                    }else{
                        
                    }
                    
                    j++;
                    
                }
                NSLog(@"tags are:%@ ",tagsString);
                //                titlelbl.text = [NSString stringWithFormat:@"%@",tagsString];
                //                NSString *tempstring = [NSString stringWithFormat:@"%@",tagsString];
                //                if ([tempstring length] > 45) {
                //                    NSRange range = [tempstring rangeOfComposedCharacterSequencesForRange:(NSRange){0, 45}];
                //                    tempstring = [tempstring substringWithRange:range];
                //                    tempstring = [tempstring stringByAppendingString:@"…"];
                //                }
                //
                tagslbl.text = tagsString;
                
                [tagslbl setHidden:NO];
            }
           

            NSString *imageURLString=personalObj.cdnThumbnail;
            
            if (reportedVideosArray.count>0) {
                if ([reportedVideosArray containsObject:personalObj.videoId]) {
                    [customImageView setImage:[UIImage imageNamed:@"videoPlaceHolder.jpg"]];
                    NSLog(@"same iddddddddddddddd");
                    
                }else{
                    if (imageURLString && ![imageURLString isEqual:[NSNull null]])
                    {
                        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageURLString]];
                        
                        [customImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"loadingplaceholder.png"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            
                            if (error) {
                                NSLog(@"error while loading :%@",error);
                                
                                if([error code]==403 || [error code]==-1100 || [error code]==404){
                                    [customImageView setImage:[UIImage imageNamed:@"videoPlaceHolder.jpg"]];
                                    
                                }
                            }
                            else{
                            }
                        }];
                    }
                    
                    else{
                        [customImageView setImage:[UIImage imageNamed:@"videoPlaceHolder.jpg"]];
                    }
                }
            }
            
            else{
                if (imageURLString && ![imageURLString isEqual:[NSNull null]])
                {
                    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageURLString]];
                    
                    [customImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"loadingplaceholder.png"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                        if (error) {
                            NSLog(@"error while loading :%@",error);
                            
                            if([error code]==403 || [error code]==-1100 || [error code]==404){
                                
                                [customImageView setImage:[UIImage imageNamed:@"videoPlaceHolder.jpg"]];
                            }
                        }
                    }];
                }
                
                else{
                    [customImageView setImage:[UIImage imageNamed:@"videoPlaceHolder.jpg"]];
                }
            }
            
        }
        
    }
    else{

        customImageView = (UIImageView *)[cell viewWithTag:99];
        customImageView.contentMode=UIViewContentModeScaleAspectFill;
        customImageView.clipsToBounds=YES;
        
        UIImageView *chanelImg = (UIImageView *)[cell viewWithTag:800];

        UILabel  *searchTextLbl = (UILabel *)[cell viewWithTag:1001];
        UILabel  *titlelbl = (UILabel *)[cell viewWithTag:600];
        UILabel  *tagLabel = (UILabel *)[cell viewWithTag:1004];
 
        UIView  *roundView = (UIView *)[cell viewWithTag:200];
        roundView.layer.cornerRadius = 10;

        if (indexPath.row==[latestglobalVideo count]) {
            
            loadMoreCell = [_topVideosCollection dequeueReusableCellWithReuseIdentifier:@"LoadMoreCellOfTopVideos" forIndexPath:indexPath];
            
            
            UIActivityIndicatorView *loadMoreIndicator = (UIActivityIndicatorView *)[loadMoreCell viewWithTag:10];
            [loadMoreIndicator startAnimating];
            if (isVideosLoaded) {
                [loadMoreCell setHidden:NO];
                
            }
            
            if (![loadMoreUrlTopFeed isEqualToString:@""]) {
                if (isVideosLoaded) {
                    [loadMoreCell setHidden:NO];
                    [self loadMoreDataOfTopVideos];
                    
                }
                
            }else
            {
                [loadMoreCell setHidden:YES];
            }
            if (isVideosLoaded) {
                return loadMoreCell;
                
            }
            
        }else{
            
            NSLog(@"No loadmore ... !");
            
        }
        
        
        UIColor *color = [self colorFromHexString:@"#ff4081"]; // select needed color
        UIColor *color1 = [self colorFromHexString:@"#000080"];
    
        NSString *string; // the string to colorize
        
        NSLog(@"search word is :%@",[Settings getPreviousWord]);
        if (searchBarTextString!=NULL) {
            if (isSearchTapped) {
                //                if ([Settings getPreviousWord] !=NULL && ![[Settings getPreviousWord] isEqualToString:@""]) {
                //                    string = [Settings getPreviousWord];
                //                }else{
                string =searchBarTextString;
                //                }
            }else{
                string = searchBarTextString;
                
            }
            if (crossClicked) {
                string= @"Hot Now";
            }
            
        }else{
            
            string= @"Hot Now";
        }
        NSDictionary *attrs = @{ NSForegroundColorAttributeName : color };
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];
        
        NSString *str1= @"#";
        
        NSDictionary *attrs1 = @{ NSForegroundColorAttributeName : color1 };
        NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] initWithString:str1 attributes:attrs1];
        
        [mutableAttString appendAttributedString:attrStr];
        
        searchTextLbl.attributedText = mutableAttString;
        
        
        if (latestglobalVideo.count>0 && latestglobalVideo.count > indexPath.row) {
            personalObj = [latestglobalVideo objectAtIndex:indexPath.row];
            
            NSLog(@"top channel thumbnail is :%@", personalObj.channelThumbnail);
            
            if (isSearchTop) {
                //                chanelImg.hidden = YES;
                if (![personalObj.channelThumbnail isKindOfClass:[NSNull class]]){
                    
                    [chanelImg sd_setImageWithURL:[NSURL URLWithString:personalObj.channelThumbnail] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    }];}
            }else{
                //                chanelImg.hidden = NO;
                [chanelImg sd_setImageWithURL:[NSURL URLWithString:[Settings getFirstSelectedChannelImg]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                }];
            }
            
            
            
            titlelbl.text = personalObj.topNotificaitonText;
            if (![personalObj.topNotification isKindOfClass:[NSNull class]] && personalObj.topNotification != nil) {
                
                NSLog(@"top notification text is :%@", personalObj.topNotification);
                
                titlelbl.text = personalObj.topNotification;
                [titlelbl setHidden:NO];
                
                
            }else if (![personalObj.trendingTag isKindOfClass:[NSNull class]] && personalObj.trendingTag != nil) {
                
                NSLog(@"top trending tag is :%@", personalObj.trendingTag);
                
                titlelbl.text =  [NSString stringWithFormat:@"#%@",personalObj.trendingTag];;
                [titlelbl setHidden:NO];
                
                
            }else{
                NSString *tagsString=@"";
                for (int i=0; i<personalObj.tags.count; i++) {
                    tagsString=[tagsString stringByAppendingString:[NSString stringWithFormat:@"#%@ ",[personalObj.tags objectAtIndex:i ]]];
                }
                NSLog(@"tags are:%@ ",tagsString);
                titlelbl.text = [NSString stringWithFormat:@"%@",tagsString];
                //
                [titlelbl setHidden:NO];
            }
            
            tagLabel.text = [NSString stringWithFormat:@"@%@",personalObj.userName];
            
            [tagLabel setHidden:NO];
            
            NSString *imageURLString=personalObj.cdnThumbnail;
            //
            //            if(indexPath.row==0){
            //                cell.backgroundColor=[self colorFromHexString:@"#DCDCDC"];
            //                roundView.hidden = YES;
            //
            //                // [customImageView setImage:[UIImage imageNamed:@"HotNow2.png"]];
            //            }
            //            else{
            roundView.hidden = NO;
            if (reportedVideosArray.count>0) {
                
                if ([reportedVideosArray containsObject:personalObj.videoId]) {
                    [customImageView setImage:[UIImage imageNamed:@"videoPlaceHolderKeyboard"]];
                    NSLog(@"same iddddddddddddddd");
                    
                }else{
                    if (isVideosLoaded) {
                        if (imageURLString && ![imageURLString isEqual:[NSNull null]])
                        {
                            NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageURLString]];
                            
                            [customImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"loadingPlaceholderTop"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                
                                
                                if (error) {
                                    NSLog(@"error while loading :%@",error);
                                    
                                    if([error code]==403 || [error code]==-1100 || [error code]==404){
                                        [customImageView setImage:[UIImage imageNamed:@"videoPlaceHolderKeyboard"]];
                                        
                                    }
                                }
                            }];
                        }
                        
                        else{
                            [customImageView setImage:[UIImage imageNamed:@"videoPlaceHolderKeyboard"]];
                        }
                        
                    }
                }
                
            }
            
            else{
                if (isVideosLoaded) {
                    if (imageURLString && ![imageURLString isEqual:[NSNull null]])
                    {
                        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageURLString]];
                        
                        [customImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"loadingPlaceholderTop"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            
                            if (error) {
                                NSLog(@"error while loading :%@",error);
                                
                                if([error code]==403 || [error code]==-1100 || [error code]==404){
                                    [customImageView setImage:[UIImage imageNamed:@"videoPlaceHolderKeyboard"]];
                                    
                                }
                            }
                        }];
                    }
                    
                    else{
                        [customImageView setImage:[UIImage imageNamed:@"videoPlaceHolderKeyboard"]];
                    }
                    
                }
            }
            
            //            }
            
        }
        
        //        if (indexPath.row==0) {
        //            [customImageView setHidden:YES];
        //            [searchTextLbl setHidden:NO];
        //            cell.backgroundColor=[self colorFromHexString:@"#DCDCDC"];
        //            [tagLabel setHidden:YES];
        //        }else{
        [customImageView setHidden:NO];
        [searchTextLbl setHidden:YES];
        [tagLabel setHidden:NO];
        
        //        }
    }
    
    return cell;
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

-(void)copyGif{
    self.view.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Downloading Started");
        NSString *urlToDownload = personalObj.socialUrl;
        NSURL  *url = [NSURL URLWithString:urlToDownload];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString  *documentsDirectory = [paths objectAtIndex:0];
            
            NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[NSString stringWithFormat:@"vid%@.gif", personalObj.videoId]];
            NSLog(@"file path is:%@", filePath);
            NSFileManager *fileManager = [NSFileManager defaultManager];

            if([fileManager fileExistsAtPath:filePath]){
                NSLog(@"already exists");
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSData *gifData = [[NSData alloc] initWithContentsOfFile:filePath];
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    [pasteboard setData:gifData forPasteboardType:@"com.compuserve.gif"];
                    
                    copyVC.hideThisView();
                });
               
            }else{
                NSLog(@"does not exist");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [urlData writeToFile:filePath atomically:YES];
                    NSLog(@"File Saved !:%@", filePath);
                    copyVC.hideThisView();
                    
                    NSData *gifData = [[NSData alloc] initWithContentsOfFile:filePath];
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    [pasteboard setData:gifData forPasteboardType:@"com.compuserve.gif"];
                    
                });
            }
            
            //saving is done on main thread
           
        }
        
    });
    
}
- (BOOL)checkVisibilityOfCell{
    if (videosssCollection.contentSize.height <= videosssCollection.frame.size.height) {
        return YES;
    } else{
        return NO;
    }
}
-(void)collectionView:(UICollectionView *)collectionView  didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"ENTER didSelectItemAtIndexPath");
    [self searchBarTextDidEndEditing:searchBar];
    NSLog(@"ABOUT TO CALL DownloadVideo()");
    videoPlayableURL = nil;
    videoShareURL = nil;
    playerHidden= NO;
    //    self.avPlayerViewcontroller.player = nil;
    [self.avPlayerViewcontroller.player pause];
 
    lastSelectdIndexMain = indexPath.row;
  
    [_youtubeVideoView stopVideo];
    [_youtubeVideoView pauseVideo];
    videosssCollection.hidden = YES;
 
    _mixChannelView.hidden = YES;
    
    if (collectionView == videosssCollection) {
        isVideoFromTop = NO;
        isVideoTapped = YES;
        isVideoPlayed = YES;
        
        selectedVideo = [allGlobalvideos objectAtIndex:indexPath.row];
        personalObj = [allGlobalvideos objectAtIndex:indexPath.row];
        if ([personalObj.cdnThumbnail containsString:@"thumbs.gfycat.com"]){
            personalObj.isGif = YES;
        }
        
        if (personalObj.isTwitterVideo || personalObj.isPeriscopeVideo || personalObj.isInstagramVideo || personalObj.isCentric || personalObj.isTwitchGameVideo || personalObj.isGif) {
            isMP4Video = TRUE;
            if (!isVideoFromTop){
                [_channelView setHidden:YES];
//                _menuView.hidden = NO;
                
            }
//            [_videoCollectionView setHidden:YES];
//            _channelCollectionView.hidden=YES;
            
//            [_bottomButtonsView setHidden:NO];
            //[_menuView setHidden:YES];
            [self loadingViewforVideo];
            [videoView setBackgroundColor:[UIColor blackColor]];
            
            [_keyButtonView setHidden:YES];
            videoView.hidden = NO;
            [reportPreview setHidden:YES];
            [self abc];
            
            [_youtubeVideoView setHidden:YES];
            //
            //        if (videoPlayableURL) {
            //            [self addingAVPlayerForImessage:videoPlayableURL];
            //        }
            //        else
            //        {
            //            [self performSelector:@selector(avplayerduplicate) withObject:@"some" afterDelay:1];
            //
            //        }
//            [_bottomButtonsView setHidden:NO];
            
        }
        else if(personalObj.isYoutubeVideo){
            [self loadingViewforYoutubeVideo];
            [_channelView setHidden:YES];
            [_videoCollectionView setHidden:YES];
            _channelCollectionView.hidden=YES;
            [_bottomButtonsView setHidden:NO];
            [_keyButtonView setHidden:YES];
            [reportPreview setHidden:YES];
            _youtubeVideoView.hidden = NO;
            if (!isVideoFromTop){
                [_channelView setHidden:YES];
                _menuView.hidden = NO;
                
            }
            [self abc];
        }
        else{
            isMP4Video = FALSE;
            [self showCommentsViewController];
        }
        NSLog(@"is gif:%d?", personalObj.isGif);
       

        NSLog(@"MAIN Collection Item Selected");
        if (indexPath.row==[allGlobalvideos count]) {
            return;
        }
        NSLog(@"allGlobalvideos count is %ld",(unsigned long)[allGlobalvideos count]);
        
        @try {
            
            if (allGlobalvideos.count>0 && allGlobalvideos.count > indexPath.row) {
                
                if (reportedVideosArray.count>0) {
                    if ([reportedVideosArray containsObject:personalObj.videoId]) {
                        //                        if (isVideoDeletedOnTap) {
                        ////                            isVideoDeletedOnTap=NO;
                        //                        }else{
                        //                            return;
                        //                        }
                    }
                }
                personalObj = [allGlobalvideos objectAtIndex:indexPath.row];
                
                [Settings setImageinImessage:personalObj.cdnThumbnail];
                NSLog(@"video id is :%@",personalObj.videoId);
                //            personalObj.videoId = @"7165617";
                [Settings setVideoIdInImessaging:personalObj.videoId];
                [Settings setvideoIndexatImesage:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                [Settings setvideoURL:personalObj.cdnUrl];
                [self getVideoByVideoId:[Settings getVideoIdInImessaging] notification:@"no"];
                
                
            }
        }
        @catch (NSException *e) {
            NSLog(@"Got ya! %@", e);
        }
        @finally {
            
        }
    }
    else{
        isVideoFromTop = YES;
        _topVideosCollection.hidden = NO;
        selectedVideo = [latestglobalVideo objectAtIndex:indexPath.row];
        personalObj = [latestglobalVideo objectAtIndex:indexPath.row];
        
        NSLog(@"MAIN Collection Item Selected");
        if (indexPath.row==[latestglobalVideo count]) {
            return;
        }
        NSLog(@"allGlobalvideos count is %ld",(unsigned long)[latestglobalVideo count]);
        
        @try {
            
            if (latestglobalVideo.count>0 && latestglobalVideo.count > indexPath.row) {
                
                personalObj = [latestglobalVideo objectAtIndex:indexPath.row];
                
                
                //                if(indexPath.row==0){
                //                    return;
                //                }
                if (reportedVideosArray.count>0) {
                    if ([reportedVideosArray containsObject:personalObj.videoId]) {
                    }
                }
                
                [Settings setImageinImessage:personalObj.cdnThumbnail];
                NSLog(@"%@",personalObj.videoId);
                //            personalObj.videoId = @"7165617";
                [Settings setVideoIdInImessaging:personalObj.videoId];
                [Settings setvideoIndexatImesage:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                [Settings setvideoURL:personalObj.cdnUrl];
                if (isThereInternetAvailable) {
//                    [FBSDKAppEvents logEvent:@"Video Tapped" parameters:@{ @"Video Id"  : personalObj.videoId,@"UserName"  : personalObj.userName} ];
                }
                
                [self getVideoByVideoId:[Settings getVideoIdInImessaging] notification:@"no"];
                
            }
        }
        @catch (NSException *e) {
            NSLog(@"Got ya! %@", e);
        }
        @finally {
            
        }
    }
    NSLog(@"is gif video: %d", personalObj.isGif);
    
    if([personalObj.cdnThumbnail containsString:@"gfycat.com"]){
        personalObj.isGif = YES;
    }
  
    if (!isThereInternetAvailable) {
        [cancelPlayingVideo setHidden:NO];
    }else{
        [cancelPlayingVideo setHidden:YES];
    }
    
    NSLog(@" GlobalFeedViewController index : %li",(long)indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //        [self changecomapctviewtoexpand];
    NSLog(@"searchBarTextDidBeginEditing");
    
    if (_keyButtonView.hidden) {
        _channelView.hidden = YES;
        _videoCollectionView.hidden = YES;
        // _keyButtonView.hidden = NO;
    }
    
    [self.searchBar setHidden:NO];
    [self.searchBar setTintColor:[UIColor grayColor]];
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing");
    //    [self.view endEditing:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSLog(@"first character is : %@",[searchText substringFromIndex:0]);
    searchBarTextString = searchText;
    
    UIButton *btnCancel = [self.searchBar valueForKey:@"_cancelButton"];
    [btnCancel setEnabled:YES];
    self.searchBar.showsCancelButton=YES;
    [self.searchBar setTintColor:[UIColor lightGrayColor]];
    
    NSRange whiteSpaceRange = [searchText rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    if (whiteSpaceRange.location != NSNotFound) {
        NSLog(@"Found whitespace");
        //        suggestionTableView.hidden=YES;
    }else{
        if([searchText hasPrefix:@"@"]){
            NSLog(@"@ is the first character");
            NSLog(@"searchText length is : %lu",(unsigned long)searchText.length);
            if(searchText.length>3){
                //            [self sendRequestForUsernamesAndImages:[searchText substringFromIndex:1]];
                //                [globalFeedManger suggestionRequest:[searchText substringFromIndex:1]];
            }else{
                //                suggestionTableView.hidden=YES;
            }
        }else{
            NSLog(@"@ is not the first character");
        }
        
    }
    
}

-(void)searchactivityIndicator{
    NSLog(@"enter activityIndicator");
    
    _loadingView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2-85), (self.view.frame.size.height/2-85), 170, 170)];
    _loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _loadingView.clipsToBounds = YES;
    _loadingView.layer.cornerRadius = 10.0;
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.frame = CGRectMake(65, 40, _activityView.bounds.size.width, _activityView.bounds.size.height);
    [_loadingView addSubview:_activityView];
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    //loadingLabel.textAlignment =UITextAlignmentCenter;
    loadingLabel.text = @"Searching videos...";
    [_loadingView addSubview:loadingLabel];
    [self.view addSubview:_loadingView];
    [_activityView startAnimating];
    NSLog(@"exit activityIndicator");
}
-(void)loadingViewforChannel{
    NSLog(@"enter activityIndicatorenter activityIndicatorenter activityIndicator");
    [_channelCollectionView setHidden:NO];
//    [_bottomButtonsView setHidden:YES];
    [self.loadingView removeFromSuperview];
    //    if(isChannelSelected || isSearchTapped){
    _loadingView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-60, (self.view.frame.size.height/4)-80, 130, 130)];
    
    //    }else{
    //        _loadingView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-60, (self.view.frame.size.height/2)+30, 130, 130)];
    //
    //    }
    
    _loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _loadingView.clipsToBounds = YES;
    _loadingView.layer.cornerRadius = 10.0;
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.frame = CGRectMake(_activityView.bounds.size.width/2 + 30, _activityView.bounds.size.height/2 + 30, _activityView.bounds.size.width, _activityView.bounds.size.height);
    [_loadingView addSubview:_activityView];
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 100, 100, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    //loadingLabel.textAlignment =UITextAlignmentCenter;
    if(isSearchTapped || isSearchHit){
        if (isThereInternetAvailable) {
            loadingLabel.text = @"Searching videos...";
        }else{
            loadingLabel.text = @"No Network Available...";
        }
        
    }else{
        [_activityView setHidden:NO];
        if (isThereInternetAvailable) {
            loadingLabel.text = @"Loading videos...";
        }else{
            loadingLabel.text = @"No Network Available...";
        }
    }
    //  [loadingLabel removeFromSuperview];
    [_loadingView addSubview:loadingLabel];
    [self.view  addSubview:_loadingView];
    [_activityView startAnimating];
    NSLog(@"exit activityIndicator");
}

-(void)connectivityStatusChanged:(NSNotification*)notification{
    NSLog(@"Network Status Changed");
    
    [self.view setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapAction;
    NSNumber *status = [notification userInfo][AFNetworkingReachabilityNotificationStatusItem];
    
    if ([@[@(AFNetworkReachabilityStatusReachableViaWiFi), @(AFNetworkReachabilityStatusReachableViaWWAN)] containsObject:status]) {
        
        isThereInternetAvailable = TRUE;
        //  [self loadingViewOnKeyboard];
        
        [Settings setSelecetedChannelId:@"16"];
        
        //  [self fatchTopGlobalVideoswithLatitude:latitude Logintitude:longitude Distance:@"22.0" searchText:@"" isFromIMesaage:YES];
        
        tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customLabelTaped)];
        tapAction.delegate =self;
        tapAction.numberOfTapsRequired = 1;
        _customTextFieldLabel.userInteractionEnabled = YES;
        
        //        if (!isTrendingVideosShown && allGlobalvideos.count ==0) {
        //            [self fatchGlobalVideoswithLatitude:latitude Logintitude:longitude Distance:@"" searchText:searchBarTextString isFromIMesaage:YES];
        //        }
        if (allGlobalvideos.count ==0) {
            
            //            if(openaccess){
            NSLog(@"About to call request...............");
            
            [self fatchGlobalVideoswithLatitude:latitude Logintitude:longitude Distance:@"" searchText:searchBarTextString isFromIMesaage:YES];
            
            //            }
            
        }
        else{
            //            [_loadingView removeFromSuperview];
            //            [_loadingView removeFromSuperview];
            //            [_activityIndicator stopAnimating];
            //            [_activityIndicator setHidesWhenStopped:YES];
            //            [loadingLabel removeFromSuperview];
        }
        _keyBoardBtn.userInteractionEnabled= YES;
        [_customTextFieldLabel addGestureRecognizer:tapAction];
        NSLog(@"Network Status is connected");
    }
    else if ([status isEqualToNumber:@(AFNetworkReachabilityStatusNotReachable)]) {
        NSLog(@"Network Status is Diconnected");
        isThereInternetAvailable = FALSE;
        isSearchTapped= NO;
        [_blinkingView setHidden:YES];
        _customTextFieldLabel.userInteractionEnabled = NO;
        
        [self loadingViewOnKeyboard];
        
    } else {
        
    }
}
-(void)loadingViewOnKeyboard{
    NSLog(@"enter activityIndicator");
    [loadingLabel removeFromSuperview];
    if (isThereInternetAvailable) {
        loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.videoCollectionView.frame.size.width/2)-100, 20, 130, 22)];
        loadingLabel.text = @"Loading videos";
        
    }else{
        loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.videoCollectionView.frame.size.width/2)-100, 20, 200, 22)];
        loadingLabel.text = @"Please Connect to Internet..!";
    }
    
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    //loadingLabel.textAlignment =UITextAlignmentCenter;
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.frame = CGRectMake(_activityView.bounds.size.width/2+115 , _activityView.bounds.size.height/2-10, _activityView.bounds.size.width, _activityView.bounds.size.height);
    if (isThereInternetAvailable) {
        [loadingLabel addSubview:_activityView];
    }
    [_activityView setHidden:NO];
    [_activityView startAnimating];
    
    
    [self.topVideosCollection addSubview:loadingLabel];
    NSLog(@"exit activityIndicator");
}
-(void)loadingViewforVideo{
    videoView.hidden = NO;
    videoView.backgroundColor = [UIColor blackColor];
    NSLog(@"enter activityIndicator");
    [_loadingView removeFromSuperview];
    if(isVideoFromTop){
        _loadingView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-80, (self.view.frame.size.height/2)-170, 150, 120)];
        
    }else{
        _loadingView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-80, (self.view.frame.size.height/2)-100, 150, 120)];
        
    }
    
    //  _loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _loadingView.backgroundColor = [UIColor clearColor];
    
    _loadingView.clipsToBounds = YES;
    _loadingView.layer.cornerRadius = 10.0;
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.frame = CGRectMake(_activityView.bounds.size.width/2 + 40, _activityView.bounds.size.height/2 + 20, _activityView.bounds.size.width, _activityView.bounds.size.height);
    [_loadingView addSubview:_activityView];
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 150, 25)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    //    loadingLabel.adjustsFontSizeToFitWidth = YES;
    //loadingLabel.textAlignment =UITextAlignmentCenter;
    
    loadingLabel.text = @"Starting Video";
    
    [_loadingView addSubview:loadingLabel];
    [videoView addSubview:_loadingView];
    [_activityView startAnimating];
    NSLog(@"exit activityIndicator");
}
-(void)loadingViewforYoutubeVideo{
    
    NSLog(@"enter activityIndicator");
    [self.loadingView removeFromSuperview];
    _loadingView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-80, (self.view.frame.size.height/2) - 80, 150, 120)];
    //    _loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _loadingView.backgroundColor = [UIColor clearColor];
    _loadingView.clipsToBounds = YES;
    _loadingView.layer.cornerRadius = 10.0;
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.frame = CGRectMake(_activityView.bounds.size.width/2 + 40, _activityView.bounds.size.height/2 + 20, _activityView.bounds.size.width, _activityView.bounds.size.height);
    [_loadingView addSubview:_activityView];
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 150, 25)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    //    loadingLabel.adjustsFontSizeToFitWidth = YES;
    //loadingLabel.textAlignment =UITextAlignmentCenter;
    loadingLabel.text = @"Starting Video";
    [_loadingView addSubview:loadingLabel];
    [self.view addSubview:_loadingView];
    [_activityView startAnimating];
    NSLog(@"exit activityIndicator");
}

-(void)sendRequestonDummyEnterButtonForTextField{
    
    isSearchHit = YES;
    @try {
        videosssCollection.hidden = NO;
        
        [allGlobalvideos removeAllObjects];
        
        if([searchBarTextString isEqualToString:@""]){
            
        }
        
        else{
            
            NSRange range = NSMakeRange(0,1);
            if ([[searchBarTextString substringWithRange:range] isEqualToString:@"#"]) {
                searchBarTextString = [searchBarTextString stringByReplacingCharactersInRange:range withString:@"Jy9MpR5_"];
                NSLog(@"Search Text is : %@", searchBarTextString);
            }
            if (isThereInternetAvailable) {
//                [FBSDKAppEvents logEvent:FBSDKAppEventNameSearched parameters:@{FBSDKAppEventParameterNameSearchString  : searchBarTextString, @"Searched By" :searchBy} ];
            }
            
            [Settings setGlobalMainLoadMoreUrl:@""];
            
            if ((isTrendingVideosShown || isSearchTapped || isSpacePressed) && (!isSearchFroMainVideos)) {
                [_keyButtonView setHidden:NO];
                
                if (isThereInternetAvailable) {
//                    isSearchTapped = YES;
                    isSearchTop = YES;
//                    [self fatchTopGlobalVideoswithLatitude:latitude Logintitude:longitude Distance:@"" searchText:searchBarTextString isFromIMesaage:YES];
                }
                
            }else{
                [_keyButtonView setHidden:YES];
                if (isThereInternetAvailable) {
                    _selectedImg.image = [UIImage imageNamed:@"balck_outline"];
                    isChannelSelected = NO;
                    [Settings setSelecetedChannelId:@"16"];
                    [Settings setIsMixChannelBtnTapped: YES];
                    [_channelCollectionView reloadData];
                    isSearchTapped = YES;
                    isSearchTop = NO;
                     _channelMixBtn.hidden = NO;
                    _selectedChannelNamelbl.text = [NSString stringWithFormat:@"%@ -", searchBarTextString];
                    _selectedChannelNamelbl.textColor = [UIColor darkTextColor];
                    [self fatchGlobalVideoswithLatitude:latitude Logintitude:longitude Distance:@"" searchText:searchBarTextString isFromIMesaage:YES];
                    
                }
            }
        }
        
    } @catch (NSException *exception) {
        NSLog(@"empty exception in catched %@",exception);
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchBar resignFirstResponder];
    self.searchBar.showsCancelButton=NO;
    self.searchBar.text=@"";
    
}
-(void)changecomapctviewtoexpand{
    
}
#pragma mark - Conversation Handling

-(void)showReportVideoPopUp{
    
    [self showReportVideoPopUpViewController];
    
}
-(void)stopPlayingVideo{
    
    if (isVideoTapped){
        isVideoResumed = YES;
//        [self.avPlayerViewcontroller.player pause];
//        [_youtubeVideoView stopVideo];
//        [_youtubeVideoView pauseVideo];
//        videoView.hidden = YES;

//        _youtubeVideoView.hidden=YES;
        //        isVideoTapped = NO;
//        [_avPlayerViewcontroller.view setHidden:YES];
//        [userName setHidden:YES];
//        [cancelPreview setHidden:YES];
//        [sendButton setHidden:YES];
//        [reportPreview setHidden:YES];
//        [loadingLabel setHidden:YES];
        
    }
    else{
        
        if(isVideoFromTop){
            if(isYoutubeVideoPlaying){
                isVideoResumed = YES;
                [_youtubeVideoView stopVideo];
                [_youtubeVideoView pauseVideo];
                _youtubeVideoView.hidden=YES;
                //        isVideoTapped = NO;
                [userName setHidden:YES];
                [cancelPreview setHidden:YES];
                [sendButton setHidden:YES];
                [reportPreview setHidden:YES];
                [loadingLabel setHidden:YES];
            }else if (self.avPlayerViewcontroller.player.rate != 0) {
                isVideoResumed = YES;
                [self.avPlayerViewcontroller.player pause];
              
                videoView.hidden = YES;
                //        isVideoTapped = NO;
                [_avPlayerViewcontroller.view setHidden:YES];
                [userName setHidden:YES];
                [cancelPreview setHidden:YES];
                [sendButton setHidden:YES];
                [reportPreview setHidden:YES];
                [loadingLabel setHidden:YES];
                
            }else{
                _channelView.hidden = YES;
                [userName setHidden:NO];
                [cancelPreview setHidden:NO];
                [sendButton setHidden:NO];
                [reportPreview setHidden:NO];
                [loadingLabel setHidden:NO];
                if (personalObj.isYoutubeVideo){
                    [_youtubeVideoView playVideo];
                    _youtubeVideoView.hidden=NO;
                    [_avPlayerViewcontroller.view setHidden:YES];
                    videoView.hidden = YES;

                    
                }else{
                    [self.avPlayerViewcontroller.player play];
                    [_avPlayerViewcontroller.view setHidden:NO];
                    
                    videoView.hidden = NO;
                    _youtubeVideoView.hidden = YES;
                }
            }
            
        }else if( isVideoPlayed){
            if(isYoutubeVideoPlaying){
                isVideoResumed = YES;
            }
            else if (self.avPlayerViewcontroller.player.rate != 0) {
                isVideoResumed = YES;
//                [self.avPlayerViewcontroller.player pause];
//                [_youtubeVideoView stopVideo];
//                [_youtubeVideoView pauseVideo];
//                videoView.hidden = YES;
//                _youtubeVideoView.hidden=YES;
                //        isVideoTapped = NO;
//                [_avPlayerViewcontroller.view setHidden:YES];
//                [userName setHidden:YES];
//                [cancelPreview setHidden:YES];
//                [sendButton setHidden:YES];
//                [reportPreview setHidden:YES];
//                [loadingLabel setHidden:YES];
                
            }
            else{
                _channelView.hidden = YES;
                [userName setHidden:NO];
                [cancelPreview setHidden:NO];
                [sendButton setHidden:NO];
                [reportPreview setHidden:NO];
                [loadingLabel setHidden:NO];
                if (personalObj.isYoutubeVideo  || personalObj.youtube){
                    [_youtubeVideoView playVideo];
                    _youtubeVideoView.hidden=NO;
                    [_avPlayerViewcontroller.view setHidden:YES];
                    videoView.hidden = YES;

                    
                }else{
                    [self.avPlayerViewcontroller.player play];
                    [_avPlayerViewcontroller.view setHidden:NO];
                    [_youtubeVideoView stopVideo];
                    [_youtubeVideoView pauseVideo];
                    [_youtubeVideoView setHidden:YES];
                    
                    videoView.hidden = NO;
                }
            }
            
            
            
        }
        
        
        //
        //        if (isVideoResumed){
        //          [self abc];
        //        }
        //
        
    }
    
}
-(void)hideAvplayer{
    
    //    [videoTags removeFromSuperview];
    [userName removeFromSuperview];
    isVideoTapped = NO;
    isVideoPlayed = NO;
    videoView.hidden = YES;
//    [videoView setBackgroundColor:[UIColor clearColor]];
    [self.avPlayerViewcontroller.player pause];
    [timelbl setHidden:YES];
    [timelbl removeFromSuperview];
    //    [self.avPlayerViewcontroller.player ];
    _mixChannelView.hidden = NO;
    isLabelTappedWhilePlayingVideo = NO;
    self.avPlayerViewcontroller.player = nil;
    self.avPlayerViewcontroller.view.hidden = YES;
    [_loadingView removeFromSuperview];
    
    
    //    [youtubePlayerViewController.moviePlayer pause];
    //    [youtubePlayerViewController.moviePlayer stop];
    
    [_youtubeVideoView stopVideo];
    [_youtubeVideoView pauseVideo];
    [_youtubeVideoView setHidden:YES];
    
    if (allGlobalvideos.count==0) {
        isVideoFromSearch=false;
    }
    
    if ((isTvIconTapped || isVideoTapped || isVideoFromSearch ||isVideoPasted) && !isVideoFromTop) {
        NSLog(@"entered in ifffffffffffffff");
        _videoCollectionView.hidden = NO;

        if (isChannelSelected){
//            _mixChannelView.hidden = NO;
//            _channelCollectionView.hidden=YES;

        }else{
//            _channelCollectionView.hidden=NO;
//            [_mixChannelView setHidden:YES];
        }
        _channelCollectionView.hidden = NO;
        _mixChannelView.hidden = NO;
        videosssCollection.hidden = NO;
//        [_menuView setHidden:NO];
        //        [_keyBoardBtn setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
//        [_channelView setHidden:NO];
//        [_bottomButtonsView setHidden:NO];
        [_keyButtonView setHidden:YES];
        //        isTvIconTapped = NO;
    }

    if (isVideoTapped) {
        isVideoTapped = NO;
        playerHidden=YES;
        startTime = [NSDate date];
    }
    if (isChannelSelected){
        
    }else{
        // [_loadingView removeFromSuperview];
    }
   
    if(isVideoFromTop){
        isVideoFromTop = NO;
    }
    [cancelPreview removeFromSuperview];
    [sendButton removeFromSuperview];
    [reportPreview removeFromSuperview];
    [loadingLabel removeFromSuperview];
    //    [_bottomButtonsView setHidden:YES];
}

-(void) receivePopUpButtonPressed:(NSNotification*)notification
{
    NSLog(@"Received PopUP button Tapped");
    if ([notification.name isEqualToString:@"popUpButtonPressed"])
    {
        NSDictionary* userInfo = notification.userInfo;
        
        NSString * receivedObject = [userInfo objectForKey:@"buttonName"];
        
        if ([receivedObject isEqualToString:@"preview"]) {
            
            NSLog(@"video url is ..!:%@",personalObj.socialUrl);
            if (personalObj.youtube) {
                NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@",personalObj.socialUrl]];
                [[UIApplication sharedApplication] openURL:url];
            }else if (personalObj.isTwitchGameVideo){
                
                NSLog(@"Its a Twitch Video...!");
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:personalObj.socialUrl]];
                
            }else{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:personalObj.socialUrl]];
                
            }
            
        }else if ([receivedObject isEqualToString:@"insert"]){
            
            if (videoShareURL) {
                [self didselectListingWithMessage:selectedVideo];
                
            }else
            {
                [self performSelector:@selector(didselectListingWithMessagewithDelay) withObject:@"some" afterDelay:1];
            }
            
        }else if([receivedObject isEqualToString:@"Report"]){
            NSLog(@"Report button Pressed");
            isReportButtonTapped = YES;
            isVideoDeletedOnTap=NO;
            [self deleteVideo];
        }
    }
}
-(void)deleteVideo{
    
    AFHTTPRequestOperationManager * manager;
    manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.requestSerializer setValue:@"centric-mobile" forHTTPHeaderField:@"User-Agent"];
    NSString *urlString=[NSString stringWithFormat:@"%@api/deletevideo/%@",SERVER_ADDRESS,[Settings getVideoIdInImessaging]];
    
    NSLog(@" WebServices  Server address : %@",urlString);
    for (NSOperation *operation in videoIdManager.operationQueue.operations) {
        [operation cancel];
    }
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@" WebServices Response Json is :%@",operation.responseString);
        NSDictionary *dict=[[NSDictionary alloc] initWithDictionary:responseObject];
        if ([dict valueForKey:@"status"] && ![[dict objectForKey:@"status"] isKindOfClass:[NSNull class]]) {
            NSString *status=[dict valueForKey:@"status"];
            if ([status isEqualToString:@"yes"]) {
                
                [reportedVideosArray addObject:[Settings getVideoIdInImessaging]];
                
                if (isVideoDeletedOnTap) {
                    
                    isVideoDeletedOnTap=NO;
                    
                }else{
                    [self hideAvplayer];
                    [videosssCollection reloadData];
                    [_topVideosCollection reloadData];
                    playerErrorText.hidden=NO;
                }
            }else{
                [self hideAvplayer];
                
                [reportedVideosArray addObject:[Settings getVideoIdInImessaging]];
                [videosssCollection reloadData];
                [_topVideosCollection reloadData];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode;
        statusCode = operation.response.statusCode;
        if(statusCode==0){
            NSInteger errorCode=[operation.error code];
            statusCode=errorCode;
        }else{
            NSLog(@" WebServices  ====== Statuc code :%ld",(long)statusCode);
        }
        if (statusCode==401) {
            
            NSLog(@"reporting video 401 error found.....!");
        }else{
        }
    }];
}
-(void)didselectListingWithMessagewithDelay
{
    //   searchBar.placeholder=@" Find Videos";
    //    _customTextFieldLabel.text=@"";
    isVideoPasted=YES;
    if (isVideoTapped) {
        //        isVideoTapped = NO;
        playerHidden=YES;
        [self hideAvplayer];
    }
//    personalObj.isGif = YES;
    
    if(personalObj.isGif){
        [self showCopyViewController];
        [self copyGif];
//         [FBSDKAppEvents logEvent:@"Video Copied" parameters:@{@"Video URL"  : personalObj.socialUrl, @"Video Id" : personalObj.videoId, @"UserName"  : personalObj.userName}];
    }else{
        if (videoShareURL) {
            // NSString *url = [NSString stringWithFormat:@"%@%@",@" ",videoShareURL];
            if (isThereInternetAvailable) {
//                            [FBSDKAppEvents logEvent:@"Video Pasted" parameters:@{@"Video URL"  : videoShareURL, @"Video Id" : personalObj.videoId, @"UserName"  : personalObj.userName}];
            }
            if([self.textDocumentProxy.documentContextBeforeInput containsString:@"https://"]){
            }else{
                [self.textDocumentProxy insertText:videoShareURL];
            }
        }
        else
        {
            [self performSelector:@selector(didselectListingWithMessagewithDelay) withObject:@"some" afterDelay:1];
        }
    }
    
 
    //    [self showTrendingVideos:nil];
    
}

-(void)avplayerduplicate
{
    if (videoPlayableURL) {
        [self addingAVPlayerForImessage:videoPlayableURL];
        videoPlayableURL = NULL;
    }else
    {
        [self performSelector:@selector(avplayerduplicate) withObject:@"some" afterDelay:1];
    }
    
    NSLog(@"vidoe url is %@",videoPlayableURL);
}

- (void)sendText:(NSString *)text
completionHandler:(void (^)(NSError *error))completionHandler{
    
    NSLog(@"Got this text in : %@", text);
}
-(void)kuchBhiHoGya{
    
    [self performSelector:@selector(sendText:completionHandler:) withObject:@"ameer"];
}

-(void)didselectListingWithMessage:(NSDictionary *)WithDictionaryObject
{
    [self didselectListingWithMessagewithDelay];
    
}
-(void)addYtPlayer:(NSURL*)_videoUrl{
    
    //    if (playerHidden) {
    //        playerHidden = NO;
    //        return;
    //    }
    @try{
        NSLog(@"Timeeeeeeeeeeee when player loaded : %f", -[startTime timeIntervalSinceNow]);
        if (isThereInternetAvailable) {
//            [FBSDKAppEvents logEvent:@"Time when player loaded" parameters:@{@"Time" : [NSString stringWithFormat:@"%f",-[startTime timeIntervalSinceNow]],@"video id" : personalObj.videoId}];
        }
        startTime = [NSDate date];
        
        NSLog(@"video url in ytplayer is %@",_videoUrl);
        
        NSLog(@"video url in ytplayer is %@",_videoUrl);
        
        //Run your loop here
        
        NSDictionary *playerVars = @{
                                     @"playsinline" : @1,
                                     @"autoplay" : @1,
                                     @"showinfo" : @0,
                                     @"controls" : @1,
                                     @"rel" : @0,
                                     @"origin" : @"http://www.youtube.com", // this is critical
                                     @"modestbranding" : @1,
                                     };
        [_youtubeVideoView loadWithVideoId:[NSString stringWithFormat:@"%@",_videoUrl] playerVars:playerVars];
        [self addswipeGesturesToYtPlayer];
        
    } @catch (NSException *exception) {
        NSLog(@"for  ytplayer Exception is %@",exception);
    }
}
- (void)playerView:(WKYTPlayerView *)playerView didChangeToState:(WKYTPlayerState)state{
    lastState = state;
    if (state ==kWKYTPlayerStateUnstarted ) {
        NSLog(@"changed state of yt player is :%ld",(long)state);
        isVideoDeletedOnTap=YES;
        //        [self deleteVideo];
    }else if (state == kWKYTPlayerStateUnknown){
        NSLog(@"changed state of yt 1 player is :%ld",(long)state);
    }else if(state == kWKYTPlayerStateEnded){
        NSLog(@"changed state of yt 2 player is :%ld",(long)state);
    }else if (state == kWKYTPlayerStatePaused){
        NSLog(@"changed state of to paused :%ld",(long)state);
        isYoutubeVideoPlaying = NO;

    }else if (state == kWKYTPlayerStatePlaying){
        NSLog(@"changed state of to playingggggggg:%ld",(long)state);
        isYoutubeVideoPlaying = YES;

    }
    
    

    
}
- (void)playerView:(WKYTPlayerView *)playerView receivedError:(WKYTPlayerError)error{
    [self deleteVideo];
    NSLog(@"YT player did receive error : %ld",(long)error);
    if (isThereInternetAvailable) {
//        [FBSDKAppEvents logEvent:@"Youtube Video Can't play" parameters:@{@"Video Id" : personalObj.videoId}];
    }
    
}
-(void)playerViewDidBecomeReady:(WKYTPlayerView *)playerView{
    NSLog(@"state of the player is :%ld", (long)lastState);
    if (playerHidden) {
        playerHidden= NO;
        return;
    }
    [cancelPreview removeFromSuperview];
    [sendButton removeFromSuperview];
    [reportPreview removeFromSuperview];
    [loadingLabel removeFromSuperview];
    
    [_loadingView removeFromSuperview];
    [_activityIndicator stopAnimating];
    [_activityIndicator setHidesWhenStopped:YES];
    [loadingLabel removeFromSuperview];
    [_youtubeVideoView setHidden:NO];
    [videoView setHidden:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Playback started" object:self];
    [_youtubeVideoView playVideo];
    
    [self abc];
    

    
}
-(void)abc{
    [cancelPreview removeFromSuperview];
    [sendButton removeFromSuperview];
    [reportPreview removeFromSuperview];
    [loadingLabel removeFromSuperview];
    cancelPreview = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelPreview addTarget:self
                      action:@selector(hideAvplayer)
            forControlEvents:UIControlEventTouchUpInside];
    //    [cancelPreview setTitle:@"Close" forState:UIControlStateNormal];
    reportPreview = [UIButton buttonWithType:UIButtonTypeCustom];
    [reportPreview addTarget:self
                      action:@selector(showReportVideoPopUp)
            forControlEvents:UIControlEventTouchUpInside];
    [reportPreview setHidden:NO];
    
    [reportPreview setTitle:@"Report" forState:UIControlStateNormal];
    
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton addTarget:self
                   action:@selector(didselectListingWithMessage:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [sendButton setTitle:@"Paste" forState:UIControlStateNormal];
    cancelPreview.frame = CGRectMake(videoView.frame.size.width-40.0, videoView.frame.origin.y + 80, 30, 30); // set your own position
    sendButton.frame = CGRectMake(videoView.frame.size.width-40.0, cancelPreview.frame.origin.y + 40, 30, 30); // set your own position
    
    [cancelPreview setBackgroundImage:[UIImage imageNamed:@"Close.png"] forState:UIControlStateNormal];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"Paste.png"] forState:UIControlStateNormal];
    
    reportPreview.frame = CGRectMake(videoView.frame.size.width-40.0, cancelPreview.frame.origin.y + 80, 30, 30); // set your own position
    
    [reportPreview setBackgroundImage:[UIImage imageNamed:@"Report.png"] forState:UIControlStateNormal];
    
    reportPreview.layer.cornerRadius = 3;
    reportPreview.clipsToBounds = YES;
    //    cancelPreview.layer.cornerRadius = 3;
    //    cancelPreview.clipsToBounds = YES;
    sendButton.layer.cornerRadius = 3;
    sendButton.clipsToBounds = YES;
    [userName removeFromSuperview];
    userName= [[UILabel alloc]init];
    //    (parentWidth - childWidth) / 2
    [userName setFrame:CGRectMake(videoView.frame.origin.x+5, videoView.frame.origin.y+5, self.view.frame.size.width, 18)];
    userName.textAlignment = NSTextAlignmentCenter;
    
    userName.text = [NSString stringWithFormat:@"@%@",personalObj.userName];
    userName.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
    userName.textColor = [UIColor whiteColor];
    
    //    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(videoView.frame.origin.x+5, videoView.frame.origin.y+25, self.view.frame.size.width, 18)];
    
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(videoView.frame.origin.x+5, videoView.frame.origin.y+25, self.view.frame.size.width, 18)];
    
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = NSLocalizedString(@"<<< Swipe >>>", nil);
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.font=[loadingLabel.font fontWithSize:12];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setFromValue:[NSNumber numberWithFloat:1.0]];
    [animation setToValue:[NSNumber numberWithFloat:0.0]];
    [animation setDuration:1.0f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:20000];
    [[loadingLabel layer] addAnimation:animation forKey:@"opacity"];
    
    [self.view addSubview:cancelPreview];
    [self.view addSubview:sendButton];
    [self.view addSubview:reportPreview];
    [self.view addSubview:userName];
    [self.view addSubview:loadingLabel];
    
    //    [self.view addSubview:tagsParentView];
    //    [self.view addSubview:timelbl];
}


-(void)addingAVPlayerForImessage:(NSURL*)_videoUrl{
    
    NSLog(@"Timeeeeeeeeeeee when player loaded : %f", -[startTime timeIntervalSinceNow]);
    if (isThereInternetAvailable) {
//        [FBSDKAppEvents logEvent:@"Time when player loaded" parameters:@{@"Time" : [NSString stringWithFormat:@"%f",-[startTime timeIntervalSinceNow]],@"video id" : personalObj.videoId}];
    }
    if (playerHidden) {
        playerHidden = NO;
        return;
    }
    @try{
        [cancelPreview removeFromSuperview];
        [sendButton removeFromSuperview];
        [reportPreview removeFromSuperview];
        [_loadingView removeFromSuperview];
        [loadingLabel removeFromSuperview];
        [_activityIndicator stopAnimating];
        [_activityIndicator setHidesWhenStopped:YES];
        [loadingLabel removeFromSuperview];
        [_youtubeVideoView setHidden:NO];
//        [videoView setHidden:YES];
        NSLog(@"video url in Avplayer is %@",_videoUrl);
        [self.avPlayerViewcontroller.player pause];
        //        self.avPlayerViewcontroller.player = nil;
        videosssCollection.hidden = YES;
        //        _avPlayerViewcontroller = nil;
        
        _avPlayerViewcontroller = [[AVPlayerViewController alloc] init];
        AVAsset *assetPlayer=[AVAsset assetWithURL:_videoUrl];
        
        playerItem = nil;
        playerItem = [AVPlayerItem playerItemWithAsset:assetPlayer];
        //      [self.avPlayerViewcontroller.player replaceCurrentItemWithPlayerItem:playerItem];
        _avPlayerViewcontroller.player = [AVPlayer playerWithPlayerItem:playerItem];
        self.avPlayerViewcontroller = _avPlayerViewcontroller;
        
//        _avPlayerViewcontroller.view.frame= CGRectMake(0, 80, screenWidth, videoView.frame.size.height-30);
        NSLog(@"y position of videoview is: %f", videoView.frame.origin.y);
        NSLog(@"y position of videoview is: %f", videoView.frame.size.height);


        _avPlayerViewcontroller.view.frame = videoView.frame;

        [self.view addSubview:_avPlayerViewcontroller.view];
        self.avPlayerViewcontroller.showsPlaybackControls=YES;
        self.avPlayerViewcontroller.updatesNowPlayingInfoCenter = NO;
        [self addswipeGesturesToMediaPlayer];
        
        playerErrorText=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, videoView.frame.size.width, 50)];
        playerErrorText.text=@"This video no longer available";
        playerErrorText.textAlignment = NSTextAlignmentCenter;
        playerErrorText.textColor=[UIColor whiteColor];
        [avPLayerContentOverlay addSubview:playerErrorText];
        playerErrorText.hidden=YES;
        blockPlayer=self.avPlayerViewcontroller.player;
        [self.avPlayerViewcontroller.player play];
        [self abc];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemFailedToPlayToEndTime:) name:AVPlayerItemTimeJumpedNotification object:playerItem];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
        
        
    } @catch (NSException *exception) {
        NSLog(@"for Twitch Avplayer Exception is %@",exception);
    }
}
-(void)observeValueForKeyPath:(NSString*)path ofObject:(id)object change:(NSDictionary*)change context:(void*) context {
    
    if([playerItem status] == AVPlayerStatusReadyToPlay){
        NSLog(@"The video actually plays");
    }
}
-(void)playerItemFailedToPlayToEndTime:(NSNotification *) notification
{
    //        NSLog(@"VIDEO id that can't be played in iMessage AvPlayer due to any Issue %@",[Settings getVideoIdInImessaging]);
    @try {
        if (playerItem.status == AVPlayerItemStatusFailed)
        {
            //            [[NSNotificationCenter defaultCenter]
            //             postNotificationName:@"gotoMainApp"
            //             object:self];
            NSLog(@"VIDEO id that can't be played in iMessage AvPlayer %@",[Settings getVideoIdInImessaging]);
            if (isThereInternetAvailable) {
//                [FBSDKAppEvents logEvent:@"Video Can't play by player" parameters:@{@"Video Id" : personalObj.videoId}];
            }
            
            isVideoDeletedOnTap = YES;
            [self deleteVideo];
            playerErrorText.hidden=NO;
        }
        
    } @catch (NSException *exception) {
        NSLog(@"Exception is in playerItemFailedToPlayToEndTime %@", exception);
    }
    
}

-(void)getVideoByVideoId:(NSString *)_videoId notification:(NSString *)_notification

{
    @try {
        {
            startTime = [NSDate date];
            
            NSLog(@"WebServices getVideoByVideoId Enter for Video id %@",vidoeId);
            
            for (NSOperation *operation in videoIdManager.operationQueue.operations) {
                [operation cancel];
            }
            
            videoIdManager = [AFHTTPRequestOperationManager manager];
            
            [videoIdManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [videoIdManager.requestSerializer setValue:@"centric-mobile" forHTTPHeaderField:@"User-Agent"];
            NSString *url=[NSString stringWithFormat:@"%@api/videodetaildata?videoId=%@&isVboard=%d&notification=%@" ,SERVER_ADDRESS,_videoId,true,_notification];
            
            NSLog(@"Url is////////////////////////////////////// :%@", url);
            NSURL *urlApi = [NSURL URLWithString:url];
            
            [videoIdManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"VideoPlayerViewController response is %@",[NSString stringWithFormat:@"%f",-[startTime timeIntervalSinceNow]]);
                NSLog(@"Timeeeeeeeeeeee when response recieved : %f", -[startTime timeIntervalSinceNow]);
                
                if (isThereInternetAvailable) {
//                    [FBSDKAppEvents logEvent:@"Time when response recieved" parameters:@{@"Time" : [NSString stringWithFormat:@"%f",-[startTime timeIntervalSinceNow]]}];
                }
                
                startTime = [NSDate date];
                
                [self responseSuccesfull:responseObject];
                
            }
                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"error is in Req %@", error);
                            if (isThereInternetAvailable) {
//                                [FBSDKAppEvents logEvent:@"video Request Failed" parameters:@{@"video error"  : error, @"Video Id" : personalObj.videoId}];
                            }
                        }];
        }
    } @catch (NSException *exception) {
        NSLog(@"Exception is in %@", exception);
    }
}
-(void)responseSuccesfull: (id)_response
{
    @try {
        {
            NSDictionary *jsonDictionary=[[NSDictionary alloc] initWithDictionary:_response];
            if (jsonDictionary) {
                
                personalObj=[[PersonalVideo alloc] init];
                
                if (![[jsonDictionary objectForKey:@"videoId"] isKindOfClass:[NSNull class]]) {
                    
                    personalObj.videoId=[jsonDictionary objectForKey:@"videoId"];
                    personalObj.cdnUrl=[jsonDictionary objectForKey:@"cdnUrl"];
                    NSLog(@"Video URL is:   %@",personalObj.cdnUrl);
                    personalObj.cdnThumbnail=[jsonDictionary objectForKey:@"cdnThumbnail"];
                    personalObj.isSocial=[[jsonDictionary valueForKey:@"social"] boolValue];
                    personalObj.isFacebookLive=[[jsonDictionary valueForKey:@"facebookLive"] boolValue];
                    personalObj.socialUrl=[jsonDictionary valueForKey:@"socialLink"];
                    personalObj.youtube=[[jsonDictionary objectForKey:@"youTube"] boolValue];
                    personalObj.isTwitter=[[jsonDictionary objectForKey:@"twitter"] boolValue];
                    personalObj.isTwitterVideo=[[jsonDictionary objectForKey:@"twitter"] boolValue];
                    personalObj.isPeriscopeVideo=[[jsonDictionary objectForKey:@"periscope"] boolValue];
                    personalObj.isTwitchGameVideo=[[jsonDictionary objectForKey:@"twitch"] boolValue];
                    personalObj.isInstagramVideo=[[jsonDictionary objectForKey:@"insta"] boolValue];
                    if ([personalObj.cdnUrl containsString:@"gfycat.com"]){
                        personalObj.isGif= YES;

                    }
                    

                    personalObj.socialLink=[jsonDictionary valueForKey:@"socialLink"];
                    personalObj.fbShareLink=[jsonDictionary valueForKey:@"fbShareLink"];
                    videoShareURL = personalObj.fbShareLink;
                    personalObj.tags=([jsonDictionary valueForKey:@"tags"]==[NSNull null] ? nil:[jsonDictionary valueForKey:@"tags"] );
                    personalObj.uploadingDate=[jsonDictionary objectForKey:@"uploadingDate"];
                    personalObj.userName=[jsonDictionary objectForKey:@"userName"];
                    
                    NSLog(@"JsonParserClass exit parseVideoReponse with return 0");
                    
                    NSLog(@"is Twitter cdnurl????????? %@",personalObj.cdnUrl);
                    NSLog(@"is Twitter video cdnthumbnail????????? %@:",personalObj.cdnThumbnail);
                    if ([personalObj.cdnUrl isKindOfClass:[NSNull class]]) {
                        isVideoDeletedOnTap=YES;
                        [self deleteVideo];
                        
                    }else if ([personalObj.cdnUrl isEqualToString:@""]) {
                        isVideoDeletedOnTap =YES;
                        [self deleteVideo];
                    }else if (personalObj.cdnThumbnail == NULL){
                        isVideoDeletedOnTap =YES;
                        [self deleteVideo];
                    }else if ([personalObj.cdnThumbnail isEqualToString:@""] ){
                        isVideoDeletedOnTap =YES;
                        [self deleteVideo];
                    }
                    NSLog(@"JsonParserClass exit parseVideoReponse with return 0");
                    NSLog(@"Timeeeeeeeeeeee when response parsedddddd : %f", -[startTime timeIntervalSinceNow]);
                    
                    if (isThereInternetAvailable) {
//                        [FBSDKAppEvents logEvent:@"Time when response parsed" parameters:@{@"Time" : [NSString stringWithFormat:@"%f",-[startTime timeIntervalSinceNow]]}];
                    }
                    startTime = [NSDate date];
                    
                    [self requestSuccessfulforVideo:0];
                    
                }else{
                    
                }
                
            }
            
            NSLog(@"JsonParserClass exit parseVideoReponse with return 1");
            
        }
    } @catch (NSException *exception) {
        
        NSLog(@"Exception is in imessage in responseSuccesfull %@", exception);
    }
}

-(void)requestSuccessfulforVideo:(NSNumber *)result
{
    @try {
        {
            
            [tagsParentView removeFromSuperview];
            tagsParentView = [[UIView alloc]init];
            NSLog(@" GlobalFeedViewController enter requestSuccessfulforVideo");
            if ([result integerValue]==0) {
                
                // [self DownloadVideo:personalObj.cdnUrl];
                NSLog(@" GlobalFeedViewController fatch Request succesfull ");
                
                NSString *tagsString=@"";

                
                NSString * videoIsOfType=@"";
                
                if (personalObj.isFacebookLive) {
                    videoIsOfType = @"facebooklive";
                }
                NSString *hashTagsString;

                
                if (personalObj.isSocial) {
                    
                    ism3u8SnappyVideo = NO;
                    
                    if(personalObj.youtube || personalObj.isYoutubeVideo){
                        
                        videoPlayableURL=[NSURL URLWithString:personalObj.cdnUrl];
                        NSLog(@"playable url is :%@",personalObj.cdnUrl);
                        
                        NSLog(@"cdnurl is :%@",personalObj.cdnUrl);
                        if (isThereInternetAvailable) {
//                            [FBSDKAppEvents logEvent:@"Video Tapped" parameters:@{ @"Video Id"  : personalObj.videoId, @"Video Category" : @"Youtube", @"UserName" : personalObj.userName} ];
                        }
                        
                        [self addYtPlayer:videoPlayableURL];
                        //                        [self addYtPlayer:personalObj.cdnUrl];
                        //                        [[NSNotificationCenter defaultCenter]
                        //                         postNotificationName:@"gotoMainApp"
                        //                         object:self];
                        
                    }else{
                        
                        if(personalObj.isTwitter || personalObj.isTwitterVideo || personalObj.isGif){
                            
                            NSString * videoCDnUrl = personalObj.cdnUrl;
                            if (isThereInternetAvailable) {
//                                [FBSDKAppEvents logEvent:<#(NSString *)#> parameters:<#(NSDictionary *)#>];
                                
//                                [FBSDKAppEvents logEvent:@"Video Tapped" parameters:@{ @"Video Id" : personalObj.videoId, @"Video Category" : @"Twitter", @"UserName" : personalObj.userName} ];
                            }
                            
                            
                            NSString * substring = @".xml";
                            
                            if ([videoCDnUrl rangeOfString:substring options:NSCaseInsensitiveSearch].location == NSNotFound) {
                                NSURL * cdnurl = [NSURL URLWithString:personalObj.cdnUrl];
                                //                                [self addingAVPlayerForImessage:cdnurl];
                                videoPlayableURL = cdnurl;
                                isMP4Video = TRUE;
                                
                                
                            } else {
                                
                                // Playing Snappy Tv Videos Using VLC kit
                                NSLog(@"This is .xml Extension URL");
                                //                                [[NSNotificationCenter defaultCenter]
                                //                                 postNotificationName:@"gotoMainApp"
                                //                                 object:self];
                                
                            }
                            
                            
                            if (videoPlayableURL) {
                                if (self.avPlayerViewcontroller.player != nil){
                                    AVAsset *assetPlayer = [AVURLAsset URLAssetWithURL:videoPlayableURL options:nil];
                                    [self addPlayerAsset:assetPlayer];
                                }else{
                                    [self addingAVPlayerForImessage:videoPlayableURL];
                                    
                                }
                            }
                            else
                            {
                                [self performSelector:@selector(avplayerduplicate) withObject:@"some" afterDelay:1];
                                
                            }
                            
                        }
                        else if(personalObj.isPeriscopeVideo){
                            NSLog(@"periscope cdn url is %@",personalObj.cdnUrl);
                            if (isThereInternetAvailable) {
//                                [FBSDKAppEvents logEvent:@"Video Tapped" parameters:@{ @"Video Id"  : personalObj.videoId, @"Video Category" : @"Periscope", @"UserName" : personalObj.userName} ];
                            }
                            
                            
                            NSURL * cdnurl = [NSURL URLWithString:personalObj.cdnUrl];
                            //                            [self addingAVPlayerForImessage:cdnurl];
                            videoPlayableURL = cdnurl;
                            isMP4Video = TRUE;
                            if (videoPlayableURL) {
                                [self addingAVPlayerForImessage:videoPlayableURL];
                            }
                            else
                            {
                                [self performSelector:@selector(avplayerduplicate) withObject:@"some" afterDelay:1];
                                
                            }
                            
                        }else{
                            
                            if (personalObj.isTwitchGameVideo) {
                                if (isThereInternetAvailable) {
//                                    [FBSDKAppEvents logEvent:@"Video Tapped" parameters:@{ @"Video Id"  : personalObj.videoId, @"Video Category" : @"Twitch", @"UserName" : personalObj.userName} ];
                                }
                                NSLog(@"Twitch Playing");
                                
                                if (personalObj.isTwitchGameVideo && personalObj.liveStreaming) {
                                    NSLog(@"Twitch Live Video");
                                }else{
                                    [self playingRECORDEDtwitchGamersVideo:personalObj];
                                    NSLog(@"Twitch Recorded Video");
                                }
                                
                            }else if (personalObj.isInstagramVideo){
                                if (isThereInternetAvailable) {
//                                    [FBSDKAppEvents logEvent:@"Video Tapped" parameters:@{ @"Video Id"  : personalObj.videoId, @"Video Category" : @"InstaGram", @"UserName" : personalObj.userName} ];
                                }
                                
                                NSURL * cdnurl = [NSURL URLWithString:personalObj.cdnUrl];
                                //                                [self addingAVPlayerForImessage:cdnurl];
                                videoPlayableURL = cdnurl;
                                isMP4Video = TRUE;
                                if (videoPlayableURL) {
                                    [self addingAVPlayerForImessage:videoPlayableURL];
                                }
                                else
                                {
                                    [self performSelector:@selector(avplayerduplicate) withObject:@"some" afterDelay:1];
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    
                }else{
                    
                    if(personalObj.isPeriscopeVideo){
                        
                        NSURL * cdnurl = [NSURL URLWithString:personalObj.cdnUrl];
                        //                        [self addingAVPlayerForImessage:cdnurl];
                        videoPlayableURL = cdnurl;
                        isMP4Video = TRUE;
                        if (videoPlayableURL) {
                            [self addingAVPlayerForImessage:videoPlayableURL];
                        }
                        else
                        {
                            [self performSelector:@selector(avplayerduplicate) withObject:@"some" afterDelay:1];
                            
                        }
                        
                    }else{
                        
                    }
                    
                }
                
            }else{
                
                
            }
            
            NSLog(@" GlobalFeedViewController exit requestSuccessfulforVideo");
            
        }
    } @catch (NSException *exception) {
        NSLog(@"Exception is in %@", exception);
    }
    
}
-(void)addPlayerAsset:(AVAsset *)_asset{
    
    @try {
        NSLog(@"Timeeeeeeeeeeee when player loaded : %f", -[startTime timeIntervalSinceNow]);
        
        if (isThereInternetAvailable) {
//            [FBSDKAppEvents logEvent:@"Time when player loaded" parameters:@{@"Time" : [NSString stringWithFormat:@"%f",-[startTime timeIntervalSinceNow]],@"video id" : personalObj.videoId}];
        }
        
        playerItem = [AVPlayerItem playerItemWithAsset:_asset];
        NSArray *requestedKeys = @[@"playable"];
        [_asset loadValuesAsynchronouslyForKeys:requestedKeys completionHandler:
         ^{
             dispatch_async( dispatch_get_main_queue(),
                            ^{
                                self.avPlayerViewcontroller.view.hidden = NO;
                                _avPlayerViewcontroller.player = [AVPlayer playerWithPlayerItem:playerItem];
                                self.avPlayerViewcontroller = _avPlayerViewcontroller;
                                _avPlayerViewcontroller.view.frame=videoView.frame;
                                [self.view addSubview:_avPlayerViewcontroller.view];
                                self.avPlayerViewcontroller.showsPlaybackControls=YES;
                                self.avPlayerViewcontroller.updatesNowPlayingInfoCenter = NO;
                                [self.avPlayerViewcontroller.player play];
                                [cancelPreview removeFromSuperview];
                                [sendButton removeFromSuperview];
                                [reportPreview removeFromSuperview];
                                [loadingLabel removeFromSuperview];
                                [_loadingView removeFromSuperview];
                                [_activityIndicator stopAnimating];
                                [_activityIndicator setHidesWhenStopped:YES];
                                [loadingLabel removeFromSuperview];
                                [_youtubeVideoView setHidden:NO];
                                [videoView setHidden:YES];
                                [self abc];
                                
                            });
         }];
        
    } @catch (NSException *exception) {
        NSLog(@"Exception is in addPlayerAsset %@", exception);
    }
}
-(void)playingRECORDEDtwitchGamersVideo: (GlobalVideo*)person{
    NSLog(@"IS This Twitch Recorded Video? %d", person.isTwitchGameVideo);
    // [spinnerVLC startAnimating];
    if (isThereInternetAvailable) {
//        [FBSDKAppEvents logEvent:@"Time when player loaded" parameters:@{@"Time" : [NSString stringWithFormat:@"%f",-[startTime timeIntervalSinceNow]],@"video id" : person.videoId}];
    }
    [self twitchRECORDEDrequest:personalObj];
    
}

- (void)twitchRECORDEDrequest:(GlobalVideo*)person{
    
    @try {
        
        NSLog(@"IS This Twitch Recorded Video? %d", person.isTwitchGameVideo);
        
        AFHTTPRequestOperationManager  *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        [manager.requestSerializer setValue:@"application/vnd.twitchtv.v5+json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"gfy7p64dez6w3nl7whh7lh10aax0ea" forHTTPHeaderField:@"Client-ID"];
        
        // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        
        
        
        NSArray *Array = [person.socialLink componentsSeparatedByString:@"/"];
        NSString *twitchVideoID = [Array objectAtIndex:4];
        
        [manager GET:[NSString stringWithFormat:@"https://api.twitch.tv/api/vods/%@/access_token?oauth_token=62jvbw1cauxvousddn8inbj1vcxx6p",twitchVideoID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"The  Message is:%@", [operation responseString]);
            
            NSData * data = responseObject;
            NSLog(@"%@",data);
            
            NSDictionary *jsonObject=[NSJSONSerialization
                                      JSONObjectWithData:data
                                      options:NSJSONReadingMutableLeaves
                                      error:nil];
            
            NSLog(@"response cache data:%@",jsonObject);
            
            NSString * signature = [jsonObject objectForKey:@"sig"];
            NSLog(@"Sig is %@", signature);
            NSString *token = [jsonObject objectForKey:@"token"];
            
            NSLog(@"TOKEN is %@", token);
            token = [self stringByDecodingURLFormat:token];
            NSLog(@"encoded TOKEN is %@", token);
            
            NSString * completeURL = [person.cdnUrl stringByAppendingString:token];
            
            completeURL = [completeURL stringByAppendingString:@"&nauthsig="];
            completeURL = [completeURL stringByAppendingString:signature];
            NSLog(@"complete url : %@", completeURL);
            
            [self addingAVPlayerForImessage:[NSURL URLWithString:completeURL]];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            person.videoId=@"-00";
            
            NSInteger statusCodeIS;
            statusCodeIS = operation.response.statusCode;
            NSLog(@"status code is ; %li", (long)statusCodeIS);
            
            NSString * statusCode = [NSString stringWithFormat:@"%li", statusCodeIS];
            
            if ([statusCode isEqualToString:@"404"]) {
                
                playerErrorText.text=@"This video no longer available";
                playerErrorText.textAlignment =UITextAlignmentCenter;
                playerErrorText.textColor=[UIColor whiteColor];
                playerErrorText.hidden=NO;
                
            }
            //            [self hilightSelectedRow:lastSelectdIndexMain+1];
        }];
        
    } @catch (NSException *exception) {
        NSLog(@"Exception is in twitchRecordedRequest %@",exception);
    }
    
}
- (NSString *)stringByDecodingURLFormat:(NSString*)originalToken
{
    NSString *escapedString = [originalToken stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    
    return escapedString;
}

-(void)backIconLongPress{
    NSLog(@"self.textDocumentProxy.length/////////:%lu",self.textDocumentProxy.documentContextBeforeInput.length);
    if (self.textDocumentProxy.documentContextBeforeInput.length > 0) {
        [NSTimer scheduledTimerWithTimeInterval:0.05
                                         target:self
                                       selector:@selector(deleteTextOnTextAreaOnLongPress:)
                                       userInfo:nil
                                        repeats:YES];
    }
}
- (void)backKeyLongPress:(UILongPressGestureRecognizer*)gesture
{
    if(UIGestureRecognizerStateBegan == gesture.state) {
        // Called on start of gesture, do work here
        [Settings setIsLongPressed:YES];
        [self backIconLongPress];
    }
    if(UIGestureRecognizerStateChanged == gesture.state) {
        // Do repeated work here (repeats continuously) while finger is down
        [Settings setIsLongPressed:YES];
        
    }
    if(UIGestureRecognizerStateEnded == gesture.state) {
        // Do end work here when finger is lifted
        [Settings setIsLongPressed:NO];
        if (self.textDocumentProxy.documentContextBeforeInput.length == 0) {
            
            //            [[NSNotificationCenter defaultCenter]
            //             postNotificationName:@"notifyme"
            //             object:nil];
        }
    }
}
- (IBAction)worldGlobeButtonPressed:(id)sender {
    NSLog(@"WORLD GLOBE Button Pressed...!");
    [self advanceToNextInputMode];
}

- (IBAction)backSpaceBottomIconPressed:(id)sender {
    NSLog(@"BACKSPACE BOTTOM Button Pressed...!");
    
    //    [_customTextFieldLabel setText:self.textDocumentProxy.documentContextBeforeInput];
    searchBarTextString = self.textDocumentProxy.documentContextBeforeInput;
    //    isSearchTapped = YES;
    
    if (self.textDocumentProxy.documentContextBeforeInput.length > 1) {
        //        searchBar.placeholder = @"Find Videos";
        [self.textDocumentProxy deleteBackward];
    }else{
        [self.textDocumentProxy deleteBackward];
    }
  
}

-(void)channelisSelected
{
    
    _keyButtonView.hidden = YES;
    isSearchHit = NO;
    [allGlobalvideos removeAllObjects];
    isChannelSelected = YES;
    isVideoFromSearch=NO;
    isSearchTapped = NO;
    [Settings setIsSearchTapped:NO];

    if (searchBarTextString.length > 0 || [searchBarTextString isEqualToString:@""]) {
        
        [self clearAppleDefaultKeyboardTextField:searchBarTextString];
        searchBarTextString = @"";
        [_customTextFieldLabel setText:@""];
    }
    
    //[self loadingViewforChannel];
    
    [_blinkingView setHidden:YES];
    //  searchBar.placeholder=@"Find Videos..";
    [_keyBoardBtn setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
    
    [self loadingViewforChannel];
    if (isThereInternetAvailable) {
        [self fatchGlobalVideoswithLatitude:latitude Logintitude:longitude Distance:@"" searchText:searchBarTextString isFromIMesaage:YES];
       
    }
}

-(void)clearAppleDefaultKeyboardTextField:(NSString*)providedString{
    
    NSUInteger len = [providedString length];
    unichar buffer[len];
    
    [providedString getCharacters:buffer range:NSMakeRange(0, len)];
    
    for(int i = 0; i < len; i++) {
        
        [self.textDocumentProxy deleteBackward];
        
    }
}
-(void) setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(20.0, 20.0)];
    
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    view.layer.mask = shape;
}

-(void)addswipeGesturesToMediaPlayer{
    
    
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    leftRecognizer.direction=UISwipeGestureRecognizerDirectionLeft;
    //    leftRecognizer.delegate = self;
    [_avPlayerViewcontroller.view addGestureRecognizer:leftRecognizer];
    
    
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    rightRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    //    rightRecognizer.delegate = self;
    [_avPlayerViewcontroller.view addGestureRecognizer:rightRecognizer];
    
    
}

-(void)addswipeGesturesToYtPlayer{
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    leftRecognizer.direction=UISwipeGestureRecognizerDirectionLeft;
    //    leftRecognizer.delegate = self;
    [_youtubeVideoView addGestureRecognizer:leftRecognizer];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    rightRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    //    rightRecognizer.delegate = self;
    [_youtubeVideoView addGestureRecognizer:rightRecognizer];
    
}

- (void) SwipeRecognizer:(UISwipeGestureRecognizer *)sender {
    
    NSLog(@"  scrollview swipe");
    
    NSMutableArray *currentVideosArry;
  
    if ( sender.direction == UISwipeGestureRecognizerDirectionLeft ){
        NSLog(@"Global Feed Swipe Left Popular");
        //            if(currentVideosArry.count>0){
        if (lastSelectdIndexMain<allGlobalvideos.count) {
            personalObj = [allGlobalvideos objectAtIndex:lastSelectdIndexMain + 1];
            NSLog(@"video id is : %@", personalObj.videoId);
            lastSelectdIndexMain = lastSelectdIndexMain + 1;
            [_avPlayerViewcontroller.player pause];
            [_youtubeVideoView stopVideo];
            [_youtubeVideoView pauseVideo];
            [self getVideoByVideoId:personalObj.videoId notification:@"no"];
            if (personalObj.isTwitterVideo || personalObj.isPeriscopeVideo || personalObj.isInstagramVideo || personalObj.isCentric || personalObj.isTwitchGameVideo) {
                isMP4Video = TRUE;
                if (!isVideoFromTop){
                    [_channelView setHidden:YES];
                    _menuView.hidden = NO;
                    
                }
                [_videoCollectionView setHidden:YES];
                _channelCollectionView.hidden=YES;
                
                [_bottomButtonsView setHidden:NO];
                //        [_menuView setHidden:YES];
                //        [self addswipeGesturesToMediaPlayer];
                [self loadingViewforVideo];
                [videoView setBackgroundColor:[UIColor blackColor]];
                
                [_keyButtonView setHidden:YES];
                [_bottomButtonsView setHidden:NO];
                videoView.hidden = NO;
                [reportPreview setHidden:YES];
                [self abc];
                
                [_youtubeVideoView setHidden:YES];
                //
                //        if (videoPlayableURL) {
                //            [self addingAVPlayerForImessage:videoPlayableURL];
                //        }
                //        else
                //        {
                //            [self performSelector:@selector(avplayerduplicate) withObject:@"some" afterDelay:1];
                //
                //        }
                [_bottomButtonsView setHidden:NO];
                
            }
            else if(personalObj.isYoutubeVideo){
                //        [self addswipeGesturesToYtPlayer];
                [self loadingViewforYoutubeVideo];
                [_channelView setHidden:YES];
                [_videoCollectionView setHidden:YES];
                _channelCollectionView.hidden=YES;
                [_bottomButtonsView setHidden:NO];
                [_keyButtonView setHidden:YES];
                [reportPreview setHidden:YES];
                videoView.hidden = NO;
                if (!isVideoFromTop){
                    [_channelView setHidden:YES];
                    _menuView.hidden = NO;
                    
                }
                [self abc];
                videoView.backgroundColor=[UIColor blackColor];
            }
            
            //                    [self hilightSelectedRow:lastSelectdIndexMain+1];
        }
        
        //            }
        
    }else if(sender.direction == UISwipeGestureRecognizerDirectionRight){
        NSLog(@"   *** SWIPE RIGHT ***");
        //            if(currentVideosArry.count>0){
        if (lastSelectdIndexMain!=0) {
            personalObj = [allGlobalvideos objectAtIndex:lastSelectdIndexMain - 1];
            NSLog(@"video id is : %@", personalObj.videoId);
            lastSelectdIndexMain = lastSelectdIndexMain -1;
            [_avPlayerViewcontroller.player pause];
            [_youtubeVideoView stopVideo];
            [_youtubeVideoView pauseVideo];
            [self getVideoByVideoId:personalObj.videoId notification:@"no"];
            if (personalObj.isTwitterVideo || personalObj.isPeriscopeVideo || personalObj.isInstagramVideo || personalObj.isCentric || personalObj.isTwitchGameVideo) {
                isMP4Video = TRUE;
                if (!isVideoFromTop){
                    [_channelView setHidden:YES];
                    _menuView.hidden = NO;
                    
                }
                [_videoCollectionView setHidden:YES];
                _channelCollectionView.hidden=YES;
                
                [_bottomButtonsView setHidden:NO];
                //        [_menuView setHidden:YES];
                //        [self addswipeGesturesToMediaPlayer];
                [self loadingViewforVideo];
                [videoView setBackgroundColor:[UIColor blackColor]];
                
                [_keyButtonView setHidden:YES];
                [_bottomButtonsView setHidden:NO];
                videoView.hidden = NO;
                [reportPreview setHidden:YES];
                [self abc];
                
                [_youtubeVideoView setHidden:YES];
                //
                //        if (videoPlayableURL) {
                //            [self addingAVPlayerForImessage:videoPlayableURL];
                //        }
                //        else
                //        {
                //            [self performSelector:@selector(avplayerduplicate) withObject:@"some" afterDelay:1];
                //
                //        }
                [_bottomButtonsView setHidden:NO];
                
            }
            else if(personalObj.isYoutubeVideo){
                //        [self addswipeGesturesToYtPlayer];
                [self loadingViewforYoutubeVideo];
                [_channelView setHidden:YES];
                [_videoCollectionView setHidden:YES];
                _channelCollectionView.hidden=YES;
                [_bottomButtonsView setHidden:NO];
                [_keyButtonView setHidden:YES];
                [reportPreview setHidden:YES];
                videoView.hidden = NO;
                if (!isVideoFromTop){
                    [_channelView setHidden:YES];
                    _menuView.hidden = NO;
                    
                }
                [self abc];
                videoView.backgroundColor=[UIColor blackColor];
            }
        }
        
    }

    
}
@end


