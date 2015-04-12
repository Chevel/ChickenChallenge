//
//  PowerUpContent.m
//  MacAttack
//
//  Created by student on 01/04/14.
//
//


#import "Namespace.XniGame.h"



@implementation PowerUpContent

- (id) init{
    if(self = [super init]){
        powerAnimations = [[NSMutableDictionary alloc] initWithCapacity:5];
    }
    return self;
}


@synthesize powerAnimations;


- (void) addPowerUp:(Texture2D*)theTexture type:(PowerUpType)theType{
    
    animation = [[AnimatedSprite alloc] initWithDuration:0.8]; // ANIMATION DURATION = 0.8
    animation.looping = YES;
    
    int row = 0;
    for (int i = 0; i < 6; i++) {
        int column = i;
        Sprite *sprite = [[Sprite alloc] init];
        sprite.texture = theTexture;
        sprite.sourceRectangle = [Rectangle rectangleWithX:column * 256
                                                         y:row * 256
                                                     width:256
                                                    height:256];
        sprite.origin = [Vector2 vectorWithX:128
                                           y:128];
        AnimatedSpriteFrame *frame = [AnimatedSpriteFrame frameWithSprite:sprite start:animation.duration * (float)i / 8];  //POWERUP SWING SPEED - 4
        [animation addFrame:frame];
    }
    

    [powerAnimations setObject:animation forKey:[self getKey:theType]];
    
    
}

- (NSString*)getKey:(PowerUpType)theType{

    NSString *key = nil;
    switch (theType) {
        case PowerUpTypeGoldenEgg:
            key = @"1";
            break;
            
        case PowerUpTypeSlow:
            key = @"3";
            break;
            
        case PowerUpTypeDeath:
            key = @"4";
            break;
            
        default:
            break;
    }
    return key;
    
}



- (AnimatedSprite *) getPowerUp:(PowerUpType)theType{
    
    return [powerAnimations objectForKey:[self getKey:theType]];
}






@end
