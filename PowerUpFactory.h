//
//  PowerUpFactory.h
//  Breakout
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Namespace.XniGame.classes.h"

@interface PowerUpFactory : NSObject {

}

+ (PowerUp*) createPowerUp:(PowerUpType)type;

+ (PowerUp*) createRandomPowerUp;

@end
