//
//  MainViewController.m
//  SakuraFly
//
//  Created by Chenglin on 15-10-1.
//  Copyright (c) 2015年 Chenglin. All rights reserved.
//

#import "InitialViewController.h"
#import "PrimaryScene.h"
#import "GameKitHeaders.h"

@import GameKit;

@interface InitialViewController ()

@property (strong, nonatomic) ADInterstitialAd *interstitial;
@property (strong, nonatomic) ADBannerView *adBanner;
@property (strong, nonatomic) PrimaryScene *mainScene;
@property (assign, nonatomic) BOOL gameCenterEnabled;
@property (assign, nonatomic) BOOL requestingAd;

@end


@implementation InitialViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)loadView
{
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    SKView *skView = [[SKView alloc] initWithFrame: applicationFrame];
    self.view = skView;
#ifdef DEBUG
    skView.showsDrawCount = YES;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
#else
    [self authenticateLocalPlayer];
#endif
    _mainScene = [[PrimaryScene alloc] initWithSize:CGSizeMake(skView.bounds.size.width, skView.bounds.size.height)];
    _mainScene.scaleMode = SKSceneScaleModeAspectFit;
    [_mainScene runAction:[SKAction repeatActionForever:[SKAction playSoundFileNamed:@"backGround.mp3" waitForCompletion:YES]]];
    [skView presentScene:_mainScene];
}

#pragma mark - game center

-(void)authenticateLocalPlayer{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [self presentViewController:viewController animated:YES completion:nil];
        }else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                _gameCenterEnabled = YES;        }
            
            else{
                _gameCenterEnabled = NO;
            }
        }
    };
}

#pragma mark -iAd

-(void)showFullScreenAd {
    _interstitial = [[ADInterstitialAd alloc] init];
    _interstitial.delegate = self;
    [UIViewController prepareInterstitialAds];
    self.interstitialPresentationPolicy = ADInterstitialPresentationPolicyManual;
    [self requestInterstitialAdPresentation];
    NSLog(@"interstitialAdREQUEST");
}

-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    _interstitial = nil;
    _requestingAd = NO;
    NSLog(@"interstitialAd didFailWithERROR");
    NSLog(@"%@", error);
}

-(void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
    NSLog(@"interstitialAdDidLOAD");
    [UIViewController prepareInterstitialAds];
    if(!_mainScene.isGameStart){
        [self requestInterstitialAdPresentation];
        NSLog(@"interstitialAdDidPRESENT");
    }
}

-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
    NSLog(@"interstitialAdDidUNLOAD");
}

-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd {
    NSLog(@"interstitialAdDidFINISH");
}


@end
