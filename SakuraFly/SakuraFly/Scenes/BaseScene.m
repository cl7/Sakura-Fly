//
//  BaseScene.m
//  SakuraFly
//
//  Created by Chenglin on 15-10-1.
//  Copyright (c) 2015年 Chenglin. All rights reserved.
//

#import "BaseScene.h"

@interface BaseScene()

@property (assign, nonatomic) BOOL contentCreated;

@end

@implementation BaseScene

- (void)didMoveToView:(SKView *)view
{
    if (_contentCreated) {
        return;
    }
    [self initalize];
    self.contentCreated = YES;
}

- (void)initalize
{
    NSLog(@"Base scene initalized");
}

@end
