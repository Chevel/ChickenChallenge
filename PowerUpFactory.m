//
//  PowerUpFactory.m
//  Breakout
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//


#import "Namespace.XniGame.h"
#import "PowerUpType.h"

@implementation PowerUpFactory

static Class powerUpClasses[PowerUpTypes];
static int frequency[PowerUpTypes];
static int totalFrequency;
static PowerUpType randomTypeLookup[100];

+ (void) initialize {
	powerUpClasses[PowerUpTypeGoldenEgg] = [GoldenEggPowerUp class];
	powerUpClasses[PowerUpTypeSlow] = [SlowedPowerUp class];
    powerUpClasses[PowerUpTypeDeath] = [DeadPowerUp class];
    
	frequency[PowerUpTypeGoldenEgg] = 1;
	frequency[PowerUpTypeSlow] = 1;
    frequency[PowerUpTypeDeath] = 2;
    
	totalFrequency = 0;
	for (int i = 0; i < PowerUpTypes; i++) {
		for (int j = 0; j < frequency[i]; j++) {
			randomTypeLookup[totalFrequency] = i;
			totalFrequency++;
		}
	}
}

+ (PowerUp*) createPowerUp:(PowerUpType)type {
	return [[powerUpClasses[type] alloc] init];
}

+ (PowerUp*) createRandomPowerUp {
	int index = [Random intLessThan:totalFrequency];
	PowerUpType type = randomTypeLookup[index];
	return [PowerUpFactory createPowerUp:type];
}

@end
