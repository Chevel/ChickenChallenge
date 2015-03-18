//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "Namespace.XniGame.h"

@implementation AnimationContent


- (id) init{
    if(self = [super init]){
        animations = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    return self;
}


@synthesize animations, frame;


- (void) addAnimation:(Texture2D*)theTexture type:(AnimationType)theType{
    
    
    
    originX = 128;
    originY = 128;
    srcX = 256;
    srcY = 256;
    
    // SET THE CORRECT ANIMATION SPEED
    switch (theType) {
            
        case AnimationFlappingWings:
            duration = 0.6;
            loop = YES;
            break;
            
        case AnimationEasterEgg:
            duration = 0.6;
            loop = YES;
            break;
            
        case AnimationStage1:
            duration = 1;
            loop = YES;
            break;
            
        case AnimationStage2:
            duration = 1;
            loop = YES;
            break;
            
        case BoomChicken:
            duration = 0.7;
            loop = NO;
            srcY = 300;
            break;
            
        case BoomUnicorn:
            duration = 0.6;
            loop = NO;
            srcY = 300;
            break;
            
        case BoomAirplane:
            duration = 0.7;
            loop = NO;
            srcY = 300;
            break;
            
        case BoomAlien:
            duration = 0.6;
            loop = NO;
            srcY = 300;
            break;
            
        case AnimationForceField:
            duration = 0.6;
            loop = YES;
            break;
            
        case IntroAnimation:
            duration = 2.5;
            loop = NO;
            break;
            
        case AnimationEggDead:
            duration = 0.6;
            loop = YES;
            break;
            
        case AnimationForceFieldEaster:
            duration = 0.6;
            loop = YES;
            break;
            
        default:
            NSLog(@" BUG - ANIMATION NOT IMPLEMENTED IN AnimationContent ");
            duration = 0.4;
            break;
    }

    animation = [[AnimatedSprite alloc] initWithDuration:duration]; // ANIMATION DURATION
    animation.looping = loop;
    
    int row = 0;
    for (int i = 0; i < 6; i++) {
        int column = i;

        Sprite *sprite = [[Sprite alloc] init];
        sprite.texture = theTexture;
        sprite.sourceRectangle = [Rectangle rectangleWithX:column * 256
                                                         y:row * 256
                                                     width:srcX
                                                    height:srcY];
        sprite.origin = [Vector2 vectorWithX: originX
                                           y: originY
                         ];
        
        if(theType == IntroAnimation || theType==AnimationEggDead){
            frame = [AnimatedSpriteFrame frameWithSprite:sprite start: 1 * ((float)i+(6*row)) / 8 ]; 
        }else{
            frame = [AnimatedSpriteFrame frameWithSprite:sprite start:(float)i/8];
        }
        

        [animation addFrame:frame];
        
        
        
        
        
        if(theType == IntroAnimation && i+1 == 6 && row+1 < 3){
            i = -1;
            //column = 0;
            row++;
        }
        
        
        
    }
    
    //NSLog(@" END ");
    [animations setObject:animation forKey:[self getKey:theType]];
    
    
}

- (NSString*)getKey:(AnimationType)theName{
    
    NSString *key = nil;
    switch (theName) {
        case AnimationFlappingWings:
            key = @"1";
            break;
            
        case AnimationEasterEgg:
            key = @"2";
            break;
            
        case AnimationStage1:
            key = @"3";
            break;
            
        case AnimationStage2:
            key = @"4";
            break;
            
        case BoomChicken:
            key = @"5";
            break;
            
        case BoomUnicorn:
            key = @"6";
            break;
            
        case BoomAirplane:
            key = @"7";
            break;
            
        case BoomAlien:
            key = @"8";
            break;
            
        case AnimationForceField:
            key = @"9";
            break;
            
        case IntroAnimation:
            key = @"10";
            break;
    
        case AnimationEggDead:
            key = @"11";
            break;
            
        case AnimationForceFieldEaster:
            key = @"12";
            break;
            
        default:
            NSLog(@" BUG - ANIMATION NOT IMPLEMENTED IN AnimationContent ");
            break;
    }
    return key;
    
}



- (AnimatedSprite *) getAnimation:(AnimationType)theType{
    
    return [animations objectForKey:[self getKey:theType]];
}



@end
