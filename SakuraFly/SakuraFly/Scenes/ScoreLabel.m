//
//  ScoreLabel.m
//  birdgame
//
//  Created by Lin on 7/10/15.
//  Copyright (c) 2015 Chenglin. All rights reserved.
//

#import "ScoreLabel.h"

@implementation ScoreLabel

- (id)initWithColor:(UIColor *)color size:(CGSize)size
{
    if (self = [super initWithColor:color size:size]) {
        SKLabelNode* scoreLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        scoreLabelNode.text=_finalPoint;
        scoreLabelNode.fontSize = 20.0f;
        scoreLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        scoreLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        scoreLabelNode.position = CGPointMake(size.width / 2.0f, size.height - 300);
        scoreLabelNode.fontColor = [UIColor whiteColor];
        [self addChild:scoreLabelNode];    }
    return self;
}

@end
