//
//  SoundEngine.h
//  friHockey
//
//  Created by Matej Jan on 15.12.10.
//  Modified by snowman
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.Audio.h"
#import "Namespace.XniGame.classes.h"
#import "Retronator.Xni.Framework.h"


@interface SoundEngine : GameComponent {
	SoundEffect *soundEffects[7];
}

+ (void) initializeWithGame:(Game*)game;
+ (void) play:(int)type;
+ (void) play:(int)type withPan:(float)pan;

+ (void) play:(int)type withVolume:(float)volume;

@end
