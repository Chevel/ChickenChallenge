//
//  PowerUpContent.h
//  MacAttack
//
//  Created by student on 01/04/14.
//
//

#import <Foundation/Foundation.h>
#import "Namespace.XniGame.classes.h"


@interface PowerUpContent : GameComponent{

    NSMutableDictionary *powerAnimations;
    AnimatedSprite *animation;
}

@property (strong) NSMutableDictionary *powerAnimations;


- (void) addPowerUp:(Texture2D*)theTexture type:(PowerUpType)theType;

- (AnimatedSprite *) getPowerUp:(PowerUpType)theType;

@end
