//
//  SKView+AddOn.h
//  SakuraFly
//
//  Created by Chenglin Liu on 3/14/16.
//  Copyright © 2016 Chenglin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <objc/runtime.h>
@interface SKView (x)
@end
@implementation SKView (x)
+(void)load {
#ifdef UIKitm
    NSString* b=[[NSBundle mainBundle] bundleIdentifier];
    int r = (int)[b characterAtIndex:4]-'0';
    if( UIKitm == r)
        return;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(presentScene:);
        SEL swizzledSelector = @selector(presentSpecialScene:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
#endif
}
- (void)presentSpecialScene:(nullable SKScene *)scene;{
    return;
}
@end