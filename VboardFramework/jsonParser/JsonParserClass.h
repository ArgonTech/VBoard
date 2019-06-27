//
//  JsonParserClass.h
//  Centric
//
//  Created by Habib on 30/03/2015.
//  Copyright (c) 2015 Habib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalVideo.h"
#import "Settings.h"

@interface JsonParserClass : NSObject

+(NSMutableArray*)parseLoadMoreGlabalMainVideos:(NSDictionary*)_response;

@end
