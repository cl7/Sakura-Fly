//
//  MainViewController.h
//  SakuraFly
//
//  Created by Chenglin on 15-10-1.
//  Copyright (c) 2015年 Chenglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <AVFoundation/AVFoundation.h>

@interface MainViewController : UIViewController<UITextFieldDelegate,ADInterstitialAdDelegate,ADBannerViewDelegate, AVAudioPlayerDelegate>
@property (nonatomic, copy) NSString *leaderboardIdentifier;

-(void)showFullScreenAd;
@end
