//
//  channelCollectionViewDelegates.m
//  Centric
//
//  Created by Ameer Chand on 28/08/2017.
//  Copyright © 2017 Habib. All rights reserved.
//

#import "channelCollectionViewDelegates.h"
#import "UIImageView+WebCache.h"

@implementation channelCollectionViewDelegates

static NSString *identifier = @"channelCell";

BOOL isChannelSelected;
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if(self) {
        
        mainScreen = [UIScreen mainScreen];
        screenRect = [[UIScreen mainScreen] bounds];
        screenWidth = screenRect.size.width;
        screenHeight = screenRect.size.height;
        isChannelSelected=NO;
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        channelIDArray = [[NSMutableArray alloc]init];
        unselectedChannelsArray = [[NSMutableArray alloc]init];
        seletedChannelsArray = [[NSMutableArray alloc]init];
        channelNameArray = [[NSMutableArray alloc]init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(connectivityStatusChanged:)
                                                     name:AFNetworkingReachabilityDidChangeNotification
                                                   object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(switchChange)
                                                     name:@"switchValueChanges"
                                                   object:nil];
        
    }
    
    NSLog(@"calllelddddddsfdnfbfsbjmbfgrgd");
    [Settings setSelectedChannelImg:@"https://www.centric.nyc:443/centric/images_public/life_s_kb.png"];
    [Settings setSelecetedChannelName:@"Life"];
    
    
    //    [self fetchChannel:@"xyz"];
    return self;
}
-(void)connectivityStatusChanged:(NSNotification*)notification{
    NSLog(@"Network Status Changed in collectionview");
    
    UITapGestureRecognizer *tapAction;
    NSNumber *status = [notification userInfo][AFNetworkingReachabilityNotificationStatusItem];
    
    if ([@[@(AFNetworkReachabilityStatusReachableViaWiFi), @(AFNetworkReachabilityStatusReachableViaWWAN)] containsObject:status]) {
        [self fetchChannel:@"xyz"];
        
        NSLog(@"Network Status is connected in collectionview");
    }
    else if ([status isEqualToNumber:@(AFNetworkReachabilityStatusNotReachable)]) {
        NSLog(@"Network Status is Diconnected in collectionview");
        
        
    } else {
        
    }
}
-(void)switchChange
{
    //    [Settings setSelecetedChannelId:@"0"];
    //    [self fetchChannel:@"0"];
    //    selectedChannelIndex = 0;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return unselectedChannelsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    cell = (ChannelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = (ChannelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    }
    //    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //    flow.itemSize = CGSizeMake(cell.frame.size.width, cell.frame.size.height);
    //    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //    flow.minimumInteritemSpacing = 0;
    //    flow.minimumLineSpacing = 0;
    
    //    collectionView =[[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flow];
    //    cell.channelImageView.frame = CGRectMake(34,41,177,124);
    
    if ([Settings getIsMixChannelBtnTapped]) {
        selectedChannelIndex=0;
        //        [Settings setIsKeyBtnPressed:NO];
    }
//    if ([Settings getIsSearchTapped]) {
//        [cell.channelImageView sd_setImageWithURL:[NSURL URLWithString:[unselectedChannelsArray objectAtIndex:indexPath.row]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        }];
//
//    }else{
//        if(indexPath.row==selectedChannelIndex){
//            //            [Settings setSelectedChannelImg:[seletedChannelsArray objectAtIndex:indexPath.row]];
//
//            [cell.channelImageView sd_setImageWithURL:[NSURL URLWithString:[seletedChannelsArray objectAtIndex:indexPath.row]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            }];
//        }else{
//
//            [cell.channelImageView sd_setImageWithURL:[NSURL URLWithString:[seletedChannelsArray objectAtIndex:indexPath.row]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            }];
//        }
//    }
    [cell.channelImageView sd_setImageWithURL:[NSURL URLWithString:[seletedChannelsArray objectAtIndex:indexPath.row]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    if(indexPath.row == 0){
        [Settings setFirstSelectedChannelImg:[seletedChannelsArray objectAtIndex:indexPath.row]];
    }
    
    
    return cell;
}

//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//
//    return 0.05;
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 0.05;
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectedChannelIndex=(int)indexPath.row;
    isChannelSelected=YES;
    [Settings setSelecetedChannelId:[channelIDArray objectAtIndex:indexPath.row]];
    [Settings setSelecetedChannelName:[channelNameArray objectAtIndex:indexPath.row]];
    NSLog(@"selected index is :%@",[Settings getSelectedChannelId]);
    [Settings setSelectedChannelImg:[seletedChannelsArray objectAtIndex:indexPath.row]];
    
    [collectionView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"channelTapped"
                                                        object:self];
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    CGSize defaultSize = [(UICollectionViewFlowLayout*)collectionViewLayout itemSize];
    //
    //    if (mainScreen.bounds.size.height == 568)
    //    {
    //        //            NSLog(@"screenWidth%f", screenWidth/3.8);
    //        return CGSizeMake(screenWidth/4.6 , screenWidth/4.6);
    //    }
    //    else if ((mainScreen.bounds.size.height == 667) || (mainScreen.bounds.size.height == 736) || (mainScreen.bounds.size.height == 812))
    //    {
    //                    NSLog(@"screenWidth %f", screenWidth/6);
    return CGSizeMake(80 , 33 );
    //    }
    
    
    
    //    return defaultSize;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


// to populate infotainment Channel..

-(void)fetchChannel:(NSString*)channelType
{
    NSLog(@"Fetch Chanel data from Server");
    NSURL *dataUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/csrftoken",SERVER_ADDRESS]];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:dataUrl];
    
    NSDictionary *sheaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    NSLog(@" WebServices  cookies dictionary is  : %@",sheaders);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"centric-mobile" forHTTPHeaderField:@"User-Agent"];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"token"];
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"X-CSRF-TOKEN"];
    [manager.requestSerializer setValue:[sheaders valueForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    
    if (![AFNetworkReachabilityManager sharedManager].reachable){
        manager.requestSerializer.cachePolicy=NSURLRequestReturnCacheDataElseLoad;
    }
    
    NSString *webAddress;
    
    //    if ([[Settings getSwitchState]isOn]) {
    //
    //        // for Global Chanel.
    ////        webAddress=[NSString stringWithFormat:@"%@api/fetchallCityChannels",SERVER_ADDRESS];
    //
    //        // for local channel.
    //         webAddress=[NSString stringWithFormat:@"%@api/fetchallInfotainmentChannels?isFromIMesaage=%d",SERVER_ADDRESS,1];
    //
    //    }else {
    //        webAddress=[NSString stringWithFormat:@"%@api/fetchallInfotainmentChannels?isFromIMesaage=%d",SERVER_ADDRESS,1];
    //    }
    
    webAddress=[NSString stringWithFormat:@"%@api/fetchkeyboardInfotainmentChannels",SERVER_ADDRESS];
    
    
    NSLog(@" WebServices %@",webAddress);
    [manager GET:webAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@" WebServices Response Json is :%@",operation.responseString);
        
        //        request = [NSURLRequest requestWithURL:[NSURL URLWithString:webAddress]];
        
        [self channelResponse:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSInteger statusCode;
        statusCode = operation.response.statusCode;
        NSLog(@"Request has been Failed with status code %ld",(long)statusCode);
        
    }];
    
}


-(void)channelResponse:(id)_response
{
    NSLog(@"JsonParserClass enter Infotainment Channels");
    
    NSMutableArray *channelArray;
    NSDictionary *jsonDictionary=[[NSDictionary alloc] initWithDictionary:_response];
    
    // key ::: ChannelList
    NSMutableArray *lasteChannelArray=[jsonDictionary objectForKey:@"allInfotainmentChannelList"];
    NSLog(@"Enter into channels Array ");
    
    channelArray=[[NSMutableArray alloc] init];
    for (NSDictionary *channelObjectDic in lasteChannelArray) {
        NSLog(@"enter into channels Loop:  ");
        PersonalVideo *perVideoObj=[[PersonalVideo alloc] init];
        perVideoObj.channelId=[NSString stringWithFormat:@"%zd",[[channelObjectDic objectForKey:@"infotainmentChannelId"] integerValue]];
        
        perVideoObj.channelName=[channelObjectDic objectForKey:@"infotainmentChannelName"];
        
        perVideoObj.channelSelectedThumbnail=[channelObjectDic objectForKey:@"infotainmentChannelSelectedUrl"];
        
        perVideoObj.channelUnselectedThumbnail=[channelObjectDic objectForKey:@"infotainmentChannelUnselectedUrl"];
        
        NSLog(@"Channel ID: %@",perVideoObj.channelId);
        NSLog(@"Channel Name: %@",perVideoObj.channelName);
        
        [channelArray addObject:perVideoObj];
    }
    
    NSLog(@"All Video Array number : %lu",(unsigned long)channelArray.count);
    [Settings setChannel:channelArray];
    [self infotainmentChannelsList];
    
}

-(void)infotainmentChannelsList{
    
    PersonalVideo *personalobj = [[PersonalVideo alloc]init];
    
    [channelIDArray removeAllObjects];
    [unselectedChannelsArray removeAllObjects];
    [seletedChannelsArray removeAllObjects];
    [channelNameArray removeAllObjects];
    
    //    BOOL switchValue=[[Settings getSwitchState] isOn];
    
    //    if(switchValue){
    //        [channelNameArray addObject:@"All Latest Videos"];
    //
    //    }else{
    //        [channelNameArray addObject:@"All Nearest Videos"];
    //
    //    }
    
    //    [seletedChannelsArray addObject:@"alll.png"];
    //    [unselectedChannelsArray addObject:@"alllU.png"];
    //    [channelIDArray addObject:@"000"];
    
    
    for (int n =0; n<[Settings getChannelsArray].count; n++) {
        
        personalobj=[[Settings getChannelsArray]objectAtIndex:n];
        
        [channelIDArray addObject:personalobj.channelId];
        [unselectedChannelsArray addObject:personalobj.channelUnselectedThumbnail];
        [seletedChannelsArray addObject:personalobj.channelSelectedThumbnail];
        [channelNameArray addObject:personalobj.channelName];
        
    }
    
    NSLog(@"The channel ids are:%@",channelIDArray);
    NSLog(@"The Channels Name list:%@",channelNameArray);
    
    if ([[Settings getSelectedChannelId] isEqualToString:@"0"])  {
        selectedChannelIndex = 0;
    }else
    {
        //        int indexValue = (int)[[Settings getChannelsArray] indexOfObject:[Settings getSelectedChannelId]];
        
        int indexValue = (int)[channelIDArray indexOfObject:[Settings getSelectedChannelId]];
        selectedChannelIndex = indexValue;
        
    }
    
    
    self.dataSource = self;
    self.delegate = self;
    [self reloadData];
    
    //    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
}


@end
