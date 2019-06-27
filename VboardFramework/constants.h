//
//  constants.h
//  fanGuru
//
//  Created by Lion User on 15/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.


#ifndef fanGuru_constants_h
#define fanGuru_constants_h


//Harish Local server
//#define SERVER_ADDRESS @"http://192.168.2.20:47825/"

//usman khan Local server
//#define SERVER_ADDRESS @"http://192.168.2.125:47830/"

//Mustafa Local server
//#define SERVER_ADDRESS @"http://192.168.2.13:55500/"

//MAttee Local server
//#define SERVER_ADDRESS @"http://192.168.2.38:47830/"

//Talha Local server2
//#define SERVER_ADDRESS @"http://192.168.2.24:47830/"

//Staging server
//#define SERVER_ADDRESS @"http://108.161.135.118:8080/centric/"

//Nauman System Local server
//#define SERVER_ADDRESS @"http://192.168.10.36:47830/"

//Live server Centric
#define SERVER_ADDRESS @"https://www.centric.nyc/centric/"

/**************************API******************************/

/**
 URL To upload Video on Centric Cloud.
 */
#define UPLOAD_VIDEO_URL                (SERVER_ADDRESS @"api/video")
#define GET_ALL_UPLOADED_VIDEOS         (SERVER_ADDRESS @"api/getmyuploadedvideostatus")
#define GET_HASH_MAP_UPLOADED_VIDEOS    (SERVER_ADDRESS @"api/getmyuploadedvideostatus")
/*
 Personal Feed
 */
#define PERSONAL_FEED                   (SERVER_ADDRESS @"api/fetchpersonalvideos?longitude=%@&latitude=%@")
#define GET_VIDEO_BY_ID                 (SERVER_ADDRESS @"api/videodetaildata?videoId=%@")
#define PUBLIC_OR_PRIVATE_VIDEO         (SERVER_ADDRESS @"api/videopublicprivate/%@")
#define SET_SUBSRIPTION_PRICE           (SERVER_ADDRESS @"api/setsubscriptionprice?subscriptionPrice=%@")

/*
 Subscription
 */
#define GET_SUBSRIPTION_TOKEN           (SERVER_ADDRESS @"api/setexpresscheckoutforsubscription?videoOwnerName=%@")
#define CANCEL_SUBSRIPTION_TOKEN        (SERVER_ADDRESS @"api/watchsubscriptionpaymentcanceled/%@")
#define GET_PAID_FOLLOWERS              (SERVER_ADDRESS @"api/getallmypaidfollowers")
#define GET_PAID_FOLLOWING              (SERVER_ADDRESS @"api/getallmypayedfollowings")
#define SET_SHARING_SETTING             (SERVER_ADDRESS @"api/changesharingstatus/%@")
#define SET_YOUTUBE_SETTING             (SERVER_ADDRESS @"api/changeyoutubefeedstatus/%@")
#define SET_INSTA_SETTING               (SERVER_ADDRESS @"api/changeinstafeedstatus/%@")
#define SET_TWITTER_SETTING             (SERVER_ADDRESS @"api/changetwitterfeedstatus/%@")
#define SET_FACEBOOK_SETTING            (SERVER_ADDRESS @"api/changefacebooklivefeedstatus/%@")
#define SET_TWITCH_SETTING              (SERVER_ADDRESS @"api/changetwitchfeedstatus/%@")



#define DELETE_VIDEO                    (SERVER_ADDRESS @"/api/deletevideo/%@")


#define PADDING_COMMENT_CELL 15.0
#define HEIGHT_DEFAULT_COMMENT_CELL 22.0
#define HEIGHT_REPLY_COMMENT_CELL 5.0
#define MAX_LENGTH_CONTACT_EMAIL 1000
#define MAX_LENGTH_PHONENUMBER 25
#define COMMENT_VIDEO_THUMBNAIL_SIZE 80
#define maxVideoLenght 60.50

#define PUSH_CHANNEL @"push_channel"
#define FB_APP_ID @"693521770753848"


#define TUMBLR_CONSUMRE_KEY @"gbculHmGaUFhqfq0SoycnrBCVEZjI8ZXvj72rERFokswfAC3Lv"
#define TUMBLR_CONSUMER_SECRET @"vVf6tSJZnH7LkcG8Cbyr0IbRBYqOA8zWBPglPDJJBBBVlx5BfR"
#define TUMBLER_BACK_URL @"tumblr://authorized"


//#define TWITTER_CONSUMRE_KEY @"Nk0026fwojXhbUHxQUKKN9hB9"
//#define TWITTER_CONSUMER_SECRET @"UDGXx6s5gJvWOzLnXlm6tsdShf8iFNY0lqo2JG89SFOn85YOeb"


#define PARSE_APPLICATION_ID @"rwP54DqiBwLEhRxOZkyDv7CrGpGSeZoFeuPxuVw3"
#define PARSE_CLIENT_KEY @"HP6SSALPO9ZQ85HbauuFCWWnyvvZ6cS1Go68jK5f"


#define TWITTER_CONSUMRE_KEY @"4zglTKQWvuc4fb2ROAie58iyV"
#define TWITTER_CONSUMER_SECRET @"ATqoQM0tkSr8kaypZMFEmi8Zqj76fThcEJg0Zis3cjgMgGuVf5"

/* *******
 Centric google analytic account tracking id.
 Credentials:
 email: archicentricanalytics@gmail.com
 pasword: centric2015
 ******* */

#define GOOGLE_ANALYTICS_TRACKING_ID @"UA-71594107-1"

/* *******
 Testing google analytic account tracking id.
 Credentials:
 email: nabeel.archimedes@gmail.com
 pasword: archimedes2015
 ******* */
//
//#define GOOGLE_ANALYTICS_TRACKING_ID @"UA-71508788-1"

/*
 watch list
 */
#define WATCH_LIST_FEED     (SERVER_ADDRESS @"/api/fetchAllUserFollowingVideos")

#define iOS_Version [[[UIDevice currentDevice] systemVersion] floatValue]


#pragma mark - REGEX

#define MENDATORY @"^.{1,}$"
#define REGEX_MINI_LIMIT @"^.{5,}$"
#define REGEX_STEPS_LIMIT @"^.{200,}$"
//#define REGEX_ITEM_NAME_LIMIT @"^.{5,25}$"
#define REGEX_DILIVERY_NAME_LIMIT @"^.{3,25}$"
#define REGEX_ITEM_NAME_LIMIT @"^.{3,50}$"

#define REGEX_ITEM_NAME @"[A-Za-z0-9]{5,25}"
#define REGEX_PRODUCT_NAME @"[A-Za-z0-9 ]{3,50}"
#define REGEX_DESCRIPTION_LIMIT @"^.{5,500}$"
//#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{1,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"
//#define REGEX_ADDRESS @"^[0-9a-zA-Z. ]+$"
#define REGEX_NUMRIC @"^[0-9]*$"
//#define REGEX_NUMRIC @"^([1-9]|[1-9][0-9]|[1-9][0-9][0-9])*$"
#define REGEX_NUMRIC @"^([0-9]|[0-9][0-9])*$"
#define REGEX_NUMRIC_MINUTES @"^([0-9]|[1-5][0-9])*$"
#define REGEX_ADDRESS @"^[0-9a-zA-Z. ]+$"
#define REGEX_Name @"^[0-9a-zA-Z ]+$"
#define REGEX_USER_NAME @"[A-Za-z0-9]+$"
#define REGEX_USER_NAME_LIMIT @"^.{4,20}$"
#define REGEX_FLOAT_NUMBER @"^0*[0-9][0-9]*(\\.[0-9]+)?"
#define REGEX_PHONE_LIMIT @"^.{9,20}$"


#define REGEX_USER_NAME_MIN_LIMIT @"^.{4,}$"
#define REGEX_USER_NAME_MAX_LIMIT @"^.{4,20}$"
#define REGEX_PHONE_MIN_LIMIT @"^.{9,}$"
#define REGEX_PHONE_MAX_LIMIT @"^.{9,20}$"
#



#endif
