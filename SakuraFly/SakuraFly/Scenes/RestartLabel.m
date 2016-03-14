//
//  RestartView.m
//  SakuraFly
//
//  Created by Chenglin on 15-10-4.
//  Copyright (c) 2015年 Chenglin. All rights reserved.
//
#define NODENAME_BUTTON @"button"
#import "RestartLabel.h"
#import "InitialViewController.h"

@import GameKit;
@interface RestartLabel()
@property (strong, nonatomic) SKSpriteNode *button;
@property (strong, nonatomic) SKLabelNode *labelNode;
@property (strong, nonatomic) SKLabelNode *scoreLabelNode;
@property (strong, nonatomic) SKLabelNode *highestLabelNode;
@property (strong, nonatomic) SKSpriteNode *gameCenterNode;
@property (strong, nonatomic) SKLabelNode *gameCenterLabel;
@end

@implementation RestartLabel

- (id)initWithColor:(UIColor *)color size:(CGSize)size
{
    if (self = [super initWithColor:color size:size]) {
        self.userInteractionEnabled = YES;
        self.button = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:0.608 green:0.349 blue:0.714 alpha:1] size:CGSizeMake(100, 50)];
        _button.position = CGPointMake(size.width / 2.0f, size.height - 350);
        _button.name = NODENAME_BUTTON;
        [self addChild:_button];
        self.labelNode = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypewriter-Bold"];
        _labelNode.text = @"Restart";
        _labelNode.fontSize = 20.0f;
        _labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        _labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        _labelNode.position = CGPointMake(0, 0);
        _labelNode.fontColor = [UIColor whiteColor];
        [_button addChild:_labelNode];
        self.gameCenterNode = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:0.608 green:0.349 blue:0.714 alpha:1]size:CGSizeMake(150, 50)];
        _gameCenterNode.position = CGPointMake(size.width / 2.0f, size.height - 280);
        [self addChild:_gameCenterNode];
        self. gameCenterLabel=[SKLabelNode labelNodeWithFontNamed:@"AmericanTypewriter-Bold"];
        _gameCenterLabel.text = @"Leaderboard";
        _gameCenterLabel.fontSize = 20.0f;
        _gameCenterLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        _gameCenterLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        _gameCenterLabel.position = CGPointMake(0, 0);
        _gameCenterLabel.fontColor = [UIColor whiteColor];
        [_gameCenterNode addChild:_gameCenterLabel];
        
    }
    return self;
}
-(void)addScoreLabelSize:(CGSize)size{
    _scoreLabelNode = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypewriter-Bold"];
    _scoreLabelNode.text=[NSString stringWithFormat:@"Your Score: \r%@",_finalPoint? _finalPoint: @"0"];
    _scoreLabelNode.fontSize = 20.0f;
    _scoreLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    _scoreLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    _scoreLabelNode.position = CGPointMake(size.width / 2.0f, size.height - 170);
    _scoreLabelNode.fontColor = [UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1];
    [self addChild:_scoreLabelNode];
}

-(void)addHighestLabelSize:(CGSize)size{
    _highestLabelNode = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypewriter-Bold"];
     _highestLabelNode.fontColor = [UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1];
    NSString* showText;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* highestScore=[defaults objectForKey:@"HighScore"];
    NSNumber* currentPoint= [NSNumber numberWithInt: [_finalPoint intValue]];
    if(highestScore==nil||[currentPoint integerValue]>[highestScore integerValue]){
        [defaults setObject:currentPoint forKey:@"HighScore"];
        highestScore=currentPoint;
        showText=@"New Record!";
        _highestLabelNode.fontColor=[UIColor colorWithRed:0.753 green:0.224 blue:0.169 alpha:1];
        [defaults synchronize];
    }else{
        showText=[NSString stringWithFormat:@"High Score: \r%lu",(long)[highestScore integerValue]];
    }
    if(highestScore!=nil){
     [self reportScore:[highestScore integerValue]];
    }
    _highestLabelNode.text=showText;
    _highestLabelNode.fontSize = 20.0f;
    _highestLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    _highestLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    _highestLabelNode.position = CGPointMake(size.width / 2.0f, size.height - 220);
    [self addChild:_highestLabelNode];
}


+ (RestartLabel *)getInstanceWithSize:(CGSize)size Point:(NSString *)point
{
    RestartLabel *restartView = [RestartLabel spriteNodeWithColor:color(255, 255, 255, 0.6) size:size];
    restartView.anchorPoint = CGPointMake(0, 0);
    restartView.finalPoint=point;
    [restartView addScoreLabelSize:size];
    [restartView addHighestLabelSize:size];
    return restartView;
}

- (void)showInScene:(SKScene *)scene
{
    self.alpha = 0.0f;
    [scene addChild:self];
    [self runAction:[SKAction fadeInWithDuration:0.3f]];
}

- (void)dismiss
{
    [self runAction:[SKAction fadeOutWithDuration:0.3f] completion:^{
        [self removeFromParent];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touchNode = [self nodeAtPoint:location];
    if (touchNode == _button || touchNode == _labelNode) {
        if ([_delegate respondsToSelector:@selector(restartView:didPressRestartButton:)]) {
            [_delegate restartView:self didPressRestartButton:_button];
        }
    }else if(touchNode==_gameCenterNode || touchNode==_gameCenterLabel){
        if ([_delegate respondsToSelector:@selector(restartView:didPressLeaderboardButton:)]) {
            [_delegate restartView:self didPressLeaderboardButton:_button];
    }
}
}
-(void)reportScore:(NSInteger)inputScore{
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:@"MyFirstLeaderboard"];
    score.value = inputScore;
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}


@end







