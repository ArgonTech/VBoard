//
//  GlobalVideo.h
//  Centric
//
//  Created by Rabia on 28/04/2017.
//  Copyright © 2017 Habib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVideo : NSObject
@property (strong, nonatomic) NSString *videoId;
@property (strong, nonatomic) NSString *channelId;
@property (strong, nonatomic) NSString *channelName;
@property (strong, nonatomic) NSString *channelSelectedThumbnail;
@property (strong, nonatomic) NSString *channelUnselectedThumbnail;

@property (strong, nonatomic) NSString *cdnUrl;
@property (strong, nonatomic) NSString *cdnThumbnail;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *uploadingDate;
@property (strong, nonatomic) NSString *views;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSArray *periscopeCookies;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *channelThumbnail;
@property (strong, nonatomic) NSString *description;

@property (strong,nonatomic) NSString *price;
@property (strong,nonatomic) NSString *downloadUrl;
@property (strong,nonatomic) NSString *socialUrl;
@property (strong,nonatomic) NSString *fbShareLink;
@property (strong,nonatomic) NSString *twitterShareLink;
@property (strong,nonatomic) NSString *tumblrShareLink;
@property (strong,nonatomic) NSString *socialLink;
@property (strong,nonatomic) NSString *longitude;
@property (strong,nonatomic) NSString *latitude;
@property (strong,nonatomic) NSString *userNameSearched;
@property (strong,nonatomic) NSString * notificationId;
@property (strong,nonatomic) NSString * userOriginalname;
@property (strong, nonatomic) NSString *mapVideosLongitude;
@property (strong, nonatomic) NSString *mapVideosLatitude;
@property (strong, nonatomic) NSString *mapVideosIDs;

@property BOOL isSocial;
@property BOOL isPeriscopeVideo;
@property BOOL isYoutubeVideo;
@property BOOL isInstagramVideo;
@property BOOL isTwitterVideo;
@property BOOL isTwitchGameVideo;
@property BOOL isCentric;
@property NSString *topNotification;
@property NSString *trendingTag;
@property BOOL isGif;





@property BOOL liveStreaming;
@property BOOL youtube;
@property BOOL isTwitter;
@property BOOL isFacebookLive;
@property BOOL isvideoOwnerpPaypalAcountExist;
@property BOOL isBoughtable;
@property BOOL isDownLoadable;
@property BOOL youtubeChannelVideo;
@property BOOL ispublic;
@property BOOL anonymous;
@property BOOL videoOwnerInFollowing;
@property BOOL loggedInUserOwnVideo;
@property BOOL isLoggedInUserReportedVideo;
@property BOOL sharingOn;
@property BOOL videoFavroute;
@property NSInteger BadgeNo;
@property NSInteger commentsCount;
@property NSInteger notificationsCount;
@property BOOL isVideoPlaying;

@property NSString *topNotificaitonText;
@property NSString *topNotificaitonCreationDate;

@property BOOL isSubscriptionON;
@property BOOL topNotificaitonRead;
@property NSInteger totalFollowers;
@property (strong, nonatomic) NSString *subscriptionPrice;

//"videoId":22,
//"cdnUrl":null,
//"cdnThumbnail":null,
//"location":"Babar Street, Lahore, Pakistan",
//"tags":[
//        "testing",
//        "scale engine",
//        "zencoder"
//        ],
//"uploadingDate":"Tue Apr 28 20:04:35 PKT 2015",
//"views":0,
//"public":true,
//"anonymous":false


@end
