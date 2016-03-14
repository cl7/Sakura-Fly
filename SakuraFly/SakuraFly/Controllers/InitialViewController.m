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
@interface InitialViewController (){
    ADInterstitialAd *interstitial;
    ADBannerView *_adBanner;
    BOOL requestingAd;
}

@property (strong, nonatomic) PrimaryScene *mainScene;
@property (assign, nonatomic) BOOL gameCenterEnabled;
@end

@implementation InitialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.mainScene = [[PrimaryScene alloc] initWithSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    _mainScene.scaleMode = SKSceneScaleModeAspectFit;
    [_mainScene runAction:[SKAction repeatActionForever:[SKAction playSoundFileNamed:@"backGround.mp3" waitForCompletion:YES]]];
    SKView *view = (SKView *)self.view;
#ifdef DEBUG
    view.showsDrawCount = YES;
    view.showsFPS = YES;
    view.showsNodeCount = YES;
#else
    [self authenticateLocalPlayer];
#endif
    [view presentScene:_mainScene];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

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

#pragma mark -iad
-(void)showFullScreenAd {
        interstitial = [[ADInterstitialAd alloc] init];
        interstitial.delegate = self;
        [UIViewController prepareInterstitialAds];
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicyManual;
        [self requestInterstitialAdPresentation];
        NSLog(@"interstitialAdREQUEST");
}

-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    interstitial = nil;
    requestingAd = NO;
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
