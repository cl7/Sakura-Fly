//
//  BaseScene.h
//  SakuraFly
//
//  Created by Chenglin on 15-10-1.
//  Copyright (c) 2015年 Chenglin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#define HERO_SIZE CGSizeMake(40, 30)
#define WALL_WIDTH 30
#define NODENAME_HERO @"heronode"
#define NODENAME_BRICK @"brick"
#define NODENAME_WALL @"wall"
#define NODENAME_HOLE @"hole"
#define NODENAME_FLOWER @"flower"
#define ACTIONKEY_ADDWALL @"addwall"
#define ACTIONKEY_MOVEWALL @"movewall"
#define ACTIONKEY_FLY @"fly"
#define ACTIONKEY_ADDFLOWER @"addflower"
#define ACTIONKEY_MOVEHEAD @"movehead"
#define GROUND_HEIGHT 1.0f
#define TIMEINTERVAL_ADDWALL 2.0f
#define TIMEINTERVAL_MOVEWALL 2.5f
#define FLOWER_WIDTH 30.0f
#define FLOWER_HEIGHT 1.0f
#define FLOWERWIDTH_MIN 2
#define FLOWERWIDTH_MAX 5
#define FLOWERCOLOR [UIColor grayColor]
#define COLOR_HERO [UIColor blueColor]
#define COLOR_BG [UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1]
#define COLOR_WALL [UIColor colorWithRed:0.827 green:0.329 blue:0 alpha:1]
#define COLOR_LABEL [UIColor whiteColor]

@interface BaseScene : SKScene

- (void)initalize;

@end
