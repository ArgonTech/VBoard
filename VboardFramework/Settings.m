//
//  Settings.m
//  Centric
//
//  Created by Rabia on 28/04/2017.
//  Copyright © 2017 Habib. All rights reserved.
//

#import "Settings.h"

@implementation Settings
@synthesize emptyFeedDelegate;


NSString * imageUrlForImessage;
NSString * VideoIdinIMessage;
NSString *reportedVideoId;
NSString *videoIndex;
NSString *videoURL;
NSString * loadGlobalMainUrl;
NSString *prevWord;
NSString *prevWordInSearch;
NSString *firstChannelImg;
NSMutableArray *lastestGlobalVideo;
NSMutableArray *allGlobalVideo;
GlobalVideo *global;

NSMutableArray *channelArray;
NSString * channelId;
NSString * channelName;
NSString * channelimg;

NSString *loadGlobalTopUrl;
BOOL isShiftOn= false;
BOOL isKeyPressed= false;
BOOL isKeyBtnTapped= false;
BOOL isLongPressed = false;
BOOL isSearchedTapped;
BOOL isAutoComplete;
BOOL isSpace;
BOOL isMixBtn;



//CGFloat width;

+(void)setImageinImessage:(NSString *)_imageUrl{
    imageUrlForImessage=_imageUrl;
}
+(NSString *)getImageinImessage{
    return imageUrlForImessage;
}
+(void)setVideoIdInImessaging:(NSString *)_id{
    VideoIdinIMessage=_id;
}
+(NSString *)getVideoIdInImessaging{
    return VideoIdinIMessage;
}

+(void)setvideoIndexatImesage:(NSString*)_index{
    videoIndex=_index;
}
+(NSString *)getvideoIndexatImesage{
    return videoIndex;
}
+(void)setGlobalLastesVideos:(NSMutableArray *)_videoArray{
    
    if(!lastestGlobalVideo){
        lastestGlobalVideo=[[NSMutableArray alloc]init];
    }
    [lastestGlobalVideo removeAllObjects];
    [lastestGlobalVideo addObjectsFromArray:_videoArray];
}
+(NSMutableArray *)getGlobalLastesVideos{
    return lastestGlobalVideo;
}
+(void)setGlobalAllVideos:(NSMutableArray *)_videoArray{
    if(!allGlobalVideo){
        allGlobalVideo=[[NSMutableArray alloc]init];
    }
    [allGlobalVideo removeAllObjects];
    [allGlobalVideo addObjectsFromArray:_videoArray];
}
+(NSMutableArray *)getGlobalAllVideos{
    return allGlobalVideo;
}
+(NSString *)getvideoURL{
    return  videoURL;
}
+(void)setvideoURL:(NSString*)_url{
    videoURL=_url;
}
+(void)setVideoObject:(GlobalVideo *)_object{
    if(!global){
        global=[[GlobalVideo alloc]init];
    }
    global=_object;
}
+(GlobalVideo *)getVideoObject{
    return global;
}




+(void)setChannel:(NSMutableArray *)_channelArray{
    if(!channelArray){
        channelArray=[[NSMutableArray alloc]init];
    }
    [channelArray removeAllObjects];
    [channelArray addObjectsFromArray:_channelArray];
}

+(NSMutableArray*)getChannelsArray{
    return  channelArray;
}


+(void)setSelecetedChannelId:(NSString *)_channelId
{
    channelId=@"";
    channelId = _channelId;
}
+(NSString *)getSelectedChannelId
{
    return channelId;
}
+(void)setlastSelecetedChannelId:(NSString *)_channelId{
    channelId = _channelId;
}
+(NSString *)getlastSelectedChannelId{
    return channelId;
}
+(void)setGlobalMainLoadMoreUrl:(NSString *)_loadMoreUrl{
    loadGlobalMainUrl=_loadMoreUrl;
}
+(NSString *)getGlobalMainLoadMoreUrl{
    return loadGlobalMainUrl;
}

+(void)setSelecetedChannelName:(NSString *)_channelName{
    
    channelName = _channelName;
}
+(NSString *)getSelectedChannelName{
    
    return channelName;
}
+(void)setSelectedChannelImg:(NSString *)_img{
    channelimg = _img;
}
+(NSString *)getSelectedChannelImg{
    return channelimg;
}
+(void)setIsDoubleShiftPressed:(BOOL)_isShiftOn{
    isShiftOn = _isShiftOn;
}
+(BOOL)getIsDoubleShiftPressed{
    
    return isShiftOn;
}
+(void)setIsKeyPressed:(BOOL)_isPressed{
    isKeyPressed = _isPressed;
}
+(BOOL)getIsKeyPressed{
    return isKeyPressed;
}
//
//+(void)setScreenWidth:(CGFloat)_float{
//    width = _float;
//}
//+(CGFloat)getScreenWidth{
//    return width;
//}

+(void)setIsKeyBtnPressed:(BOOL)_isPressed{
    isKeyBtnTapped = _isPressed;
}
+(BOOL)getIsKeyBtnPressed{
    return isKeyBtnTapped;
}
+(void)setIsLongPressed:(BOOL)_isPressed{
    isLongPressed = _isPressed;
}+(BOOL)getIsLongPressed{
    return isLongPressed;
}
+(void)setGlobalTopLoadMoreUrl:(NSString *)_loadMoreUrl{
    loadGlobalTopUrl=_loadMoreUrl;
}
+(NSString *)getGlobalTopLoadMoreUrl{
    return loadGlobalTopUrl;
}
+(void)setReportedVideoId:(NSString *)_id{
    reportedVideoId = _id;
}
+(NSString *)getReportedVideoId{
    return reportedVideoId;
    
}
// to get in key that Local Search mean in Keyboard Search is TAppped;
+(void)setIsSearchTapped : (BOOL)searchedTappped
{
    isSearchedTapped = searchedTappped;
}
+(BOOL)getIsSearchTapped
{
    return isSearchedTapped;
}
+(void)setPreviousWord:(NSString *)_word{
    prevWord =_word;
}
+(NSString *)getPreviousWord{
    return prevWord;
}
+(void)setPreviousWordInSearch:(NSString *)_word{
    prevWordInSearch =_word;
}
+(NSString *)getPreviousWordInSearch{
    return prevWordInSearch;
}

+(void)setISAutoCompleteClicked : (BOOL)clicked{
    isAutoComplete= clicked;
}
+(BOOL)getISAutoCompleteClicked{
    return isAutoComplete;
}
+(void)setIsSpaceClicked : (BOOL)clicked{
    isSpace=clicked;
}
+(BOOL)getIsSpaceClicked{
    return isSpace;
}
+(void)setIsMixChannelBtnTapped : (BOOL)clicked{
    isMixBtn = clicked;
}
+(BOOL)getIsMixChannelBtnTapped{
    return isMixBtn;
}
+(void)setFirstSelectedChannelImg:(NSString *)_img{
    firstChannelImg = _img;
}
+(NSString *)getFirstSelectedChannelImg{
    return firstChannelImg;
}
///// __________________________________________________
@end
