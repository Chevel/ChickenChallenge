//
//  SoundEngine.m
//  friHockey
//
//  Created by Matej Jan on 15.12.10. 
//  Modified by snowman
//  Copyright 2010 Retronator. All rights reserved.
//

#import "SoundEngine.h"

#import "Namespace.XniGame.h"

#import "Retronator.Xni.Framework.Content.h"


SoundEngine *instance;


@implementation SoundEngine

+ (void) initializeWithGame:(Game*)game {
	instance = [[SoundEngine alloc] initWithGame:game];
	[game.components addComponent:instance];
}

- (void) initialize {
	soundEffects[0] = [self.game.content load:@"Chicken"];
	soundEffects[1] = [self.game.content load:@"powerUp"];
    soundEffects[2] = [self.game.content load:@"Horse"];
    soundEffects[3] = [self.game.content load:@"stage1"];
    soundEffects[4] = [self.game.content load:@"stage2"];
    soundEffects[5] = [self.game.content load:@"Rooster"];
    soundEffects[6] = [self.game.content load:@"ChickenTaunt"];
}





+ (void) play:(int)type {
	[SoundEngine play:type withPan:0];
}


- (void) play:(int)type withPan:(float)pan {
	[soundEffects[type] playWithVolume:0.7 pitch:0 pan:pan];
}
+ (void) play:(int)type withPan:(float)pan {
	[instance play:type withPan:pan];
}


- (void) play:(int)type withVolume:(float)volume {
	[soundEffects[type] playWithVolume:volume pitch:0 pan:0];
}
+ (void) play:(int)type withVolume:(float)volume {
	[instance play:type withVolume:volume];
}


@end
