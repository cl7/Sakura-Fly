//
//  RestartView.h
//  SakuraFly
//
//  Created by Chenglin on 15-10-4.
//  Copyright (c) 2015年 Chenglin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class RestartLabel;

@protocol RestartViewDelegate <NSObject>

- (void)restartView:(RestartLabel *)restartView didPressRestartButton:(SKSpriteNode *)restartButton;
- (void)restartView:(RestartLabel *)restartView didPressLeaderboardButton:(SKSpriteNode *)restartButton;

@end

@interface RestartLabel : SKSpriteNode

@property (weak, nonatomic) id <RestartViewDelegate> delegate;
@property (copy, nonatomic) NSString* finalPoint;

+ (RestartLabel *)getInstanceWithSize:(CGSize)size Point:(NSString *)point;
- (void)dismiss;
- (void)showInScene:(SKScene *)scene;

@end
