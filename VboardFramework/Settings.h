//
//  Settings.h
//  Centric
//
//  Created by Rabia on 28/04/2017.
//  Copyright © 2017 Habib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalVideo.h"
@interface Settings : NSObject
@property (weak, nonatomic) id emptyFeedDelegate;
+(void)setImageinImessage:(NSString *)_imageUrl;
+(NSString *)getImageinImessage;
+(void)setVideoIdInImessaging:(NSString *)_id;
+(NSString *)getVideoIdInImessaging;
+(void)setvideoIndexatImesage:(NSString*)_index;
+(NSString *)getvideoIndexatImesage;
+(void)setGlobalLastesVideos:(NSMutableArray *)_videoArray;
+(NSMutableArray *)getGlobalLastesVideos;
+(void)setGlobalAllVideos:(NSMutableArray *)_videoArray;
+(NSMutableArray *)getGlobalAllVideos;
+(NSString *)getvideoURL;
+(void)setvideoURL:(NSString*)_url;
+(void)setVideoObject:(GlobalVideo *)_object;
+(GlobalVideo *)getVideoObject;
;

+(void)setChannel:(NSMutableArray *)_channelArray;
+(NSMutableArray*)getChannelsArray;

+(void)setSelecetedChannelId:(NSString *)_channelId;
+(NSString *)getSelectedChannelId;

+(void)setlastSelecetedChannelId:(NSString *)_channelId;
+(NSString *)getlastSelectedChannelId;

+(void)setGlobalMainLoadMoreUrl:(NSString *)_loadMoreUrl;
+(NSString *)getGlobalMainLoadMoreUrl;

+(void)setSelecetedChannelName:(NSString *)_channelName;
+(NSString *)getSelectedChannelName;

+(void)setIsDoubleShiftPressed:(BOOL)_isShiftOn;
+(BOOL)getIsDoubleShiftPressed;
+(void)setIsKeyPressed:(BOOL)_isPressed;
+(BOOL)getIsKeyPressed;

//+(void)setScreenWidth:(CGFloat)_float;
//+(CGFloat)getScreenWidth;

+(void)setIsKeyBtnPressed:(BOOL)_isPressed;
+(BOOL)getIsKeyBtnPressed;
+(void)setIsLongPressed:(BOOL)_isPressed;
+(BOOL)getIsLongPressed;

+(void)setLatitude:(NSString *)_latitude;
+(NSString *)getLatitude;
+(void)setLongitude:(NSString *)_longitude;
+(NSString *)getLongitude;

+(void)setGlobalTopLoadMoreUrl:(NSString *)_loadMoreUrl;
+(NSString *)getGlobalTopLoadMoreUrl;

+(void)setReportedVideoId:(NSString *)_id;
+(NSString *)getReportedVideoId;
// to get in key that Local Search mean in Keyboard Search is TAppped;
+(void)setIsSearchTapped : (BOOL)searchedTappped;
+(BOOL)getIsSearchTapped;
+(void)setPreviousWord:(NSString *)_word;
+(NSString *)getPreviousWord;

+(void)setISAutoCompleteClicked : (BOOL)clicked;
+(BOOL)getISAutoCompleteClicked;
+(void)setIsSpaceClicked : (BOOL)clicked;
+(BOOL)getIsSpaceClicked;
+(void)setIsMixChannelBtnTapped : (BOOL)clicked;
+(BOOL)getIsMixChannelBtnTapped;
+(void)setPreviousWordInSearch:(NSString *)_word;
+(NSString *)getPreviousWordInSearch;
+(void)setSelectedChannelImg:(NSString *)_img;
+(NSString *)getSelectedChannelImg;
+(void)setFirstSelectedChannelImg:(NSString *)_img;
+(NSString *)getFirstSelectedChannelImg;
@end

