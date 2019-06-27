//
//  JsonParserClass.m
//  Centric
//
//  Created by Habib on 30/03/2015.
//  Copyright (c) 2015 Habib. All rights reserved.
//

#import "JsonParserClass.h"
#import <UIKit/UIKit.h>

@implementation JsonParserClass

+(NSMutableArray*)parseLoadMoreGlabalMainVideos:(NSDictionary*)_response{
    
    NSDictionary *jsonDictionary=[[NSDictionary alloc] initWithDictionary:_response];
    NSMutableArray* allVideoArray=[[NSMutableArray alloc] init];
    if ([jsonDictionary valueForKey:@"allvideoListLoadMoreUrl"]&& ![[jsonDictionary objectForKey:@"allvideoListLoadMoreUrl"] isKindOfClass:[NSNull class]]) {
        NSString *loadMore=[jsonDictionary objectForKey:@"allvideoListLoadMoreUrl"];
        if (![loadMore isEqualToString:@"null"]) {
            [Settings setGlobalMainLoadMoreUrl:[jsonDictionary valueForKey:@"allvideoListLoadMoreUrl"]];
        }else{
             [Settings setGlobalMainLoadMoreUrl:@""];
        }
        
    }else{
        
        [Settings setGlobalMainLoadMoreUrl:@""];
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
                perVideoObj.description = [videoObjectDic valueForKey:@"description"];

                
                perVideoObj.youtube=[[videoObjectDic objectForKey:@"youTube"] boolValue];
                perVideoObj.isTwitter=[[videoObjectDic objectForKey:@"twitter"] boolValue];
                NSLog(@"is Twitter Video %D",perVideoObj.isTwitter);
                perVideoObj.liveStreaming=[[videoObjectDic objectForKey:@"liveStreaming"] boolValue];
                perVideoObj.channelThumbnail = [videoObjectDic valueForKey:@"channelThumbnail"];
                perVideoObj.channelName = [videoObjectDic valueForKey:@"channelName"];

                perVideoObj.isYoutubeVideo=[[videoObjectDic valueForKey:@"youTube"] boolValue];
                perVideoObj.isInstagramVideo=[[videoObjectDic valueForKey:@"insta"] boolValue];
                perVideoObj.isTwitchGameVideo=[[videoObjectDic valueForKey:@"twitch"] boolValue];
                perVideoObj.isTwitterVideo=[[videoObjectDic valueForKey:@"twitter"] boolValue];
                perVideoObj.isPeriscopeVideo=[[videoObjectDic valueForKey:@"periscope"] boolValue];
                perVideoObj.isFacebookLive = [[videoObjectDic valueForKey:@"facebookLive"] boolValue];
                perVideoObj.isCentric = [[videoObjectDic valueForKey:@"centric"] boolValue];
                
                NSLog(@"social url is %@",perVideoObj.socialUrl);
                perVideoObj.videoOwnerInFollowing=[[jsonDictionary valueForKey:@"videoOwnerInFollowing"]boolValue];
                perVideoObj.loggedInUserOwnVideo=[[jsonDictionary valueForKey:@"loggedInUserOwnVideo"]boolValue];
                perVideoObj.tags=[videoObjectDic valueForKey:@"tags"];
                perVideoObj.userName=[videoObjectDic valueForKey:@"userName"];
                NSLog(@" Thumnil value : %@",perVideoObj.cdnThumbnail);
                perVideoObj.isVideoPlaying=NO;
                
                [allVideoArray addObject:perVideoObj];
                
            }
            NSLog(@"All Video Array number : %lu",(unsigned long)allVideoArray.count);
        }
    return allVideoArray;
}

@end
