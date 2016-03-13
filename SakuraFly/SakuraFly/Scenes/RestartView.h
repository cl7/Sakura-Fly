//
//  RestartView.h
//  SakuraFly
//
//  Created by Chenglin on 15-10-4.
//  Copyright (c) 2015年 Chenglin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class RestartView;
@protocol RestartViewDelegate <NSObject>

- (void)restartView:(RestartView *)restartView didPressRestartButton:(SKSpriteNode *)restartButton;
- (void)restartView:(RestartView *)restartView didPressLeaderboardButton:(SKSpriteNode *)restartButton;
-(void)showFullScreenAd;
@end

@interface RestartView : SKSpriteNode

@property (weak, nonatomic) id <RestartViewDelegate> delegate;
@property NSString* finalPoint;
+ (RestartView *)getInstanceWithSize:(CGSize)size Point:(NSString *)point;
- (void)dismiss;
- (void)showInScene:(SKScene *)scene;

@end
