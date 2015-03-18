//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "Namespace.XniGame.classes.h"
#import <Foundation/Foundation.h>

@interface AnimationContent : GameComponent{

NSMutableDictionary *animations;
    AnimatedSprite *animation;
    float duration;
    BOOL loop;
    int originX,originY, srcX, srcY;
    
    AnimatedSpriteFrame* _frame;

}

@property (strong) AnimatedSpriteFrame* frame;
@property (strong) NSMutableDictionary *animations;


- (void) addAnimation:(Texture2D*)theTexture type:(AnimationType)theType;

- (AnimatedSprite *) getAnimation:(AnimationType)theType;



@end
