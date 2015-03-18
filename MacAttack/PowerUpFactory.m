//
//  PowerUpFactory.m
//  Breakout
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "PowerUpFactory.h"

#import "Retronator.Breakout.h"

@implementation PowerUpFactory

static Class powerUpClasses[PowerUpTypes];
static int frequency[PowerUpTypes];
static int totalFrequency;
static PowerUpType randomTypeLookup[100];

+ (void) initialize {
	powerUpClasses[PowerUpTypeExpand] = [ExpandPowerUp class];
	powerUpClasses[PowerUpTypeShrink] = [ShrinkPowerUp class];
	powerUpClasses[PowerUpTypeMagnet] = [MagnetPowerUp class];
	powerUpClasses[PowerUpTypeDeath] = [DeathPowerUp class];
	powerUpClasses[PowerUpTypeBreakthrough] = [BreakthroughPowerUp class];
	powerUpClasses[PowerUpTypeMultiBall] = [MultiBallPowerUp class];
	
	frequency[PowerUpTypeExpand] = 3;
	frequency[PowerUpTypeShrink] = 3;
	frequency[PowerUpTypeMagnet] = 2;
	frequency[PowerUpTypeDeath] = 2;
	frequency[PowerUpTypeBreakthrough] = 1;
	frequency[PowerUpTypeMultiBall] = 1;
	
	totalFrequency = 0;
	for (int i = 0; i < PowerUpTypes; i++) {
		for (int j = 0; j < frequency[i]; j++) {
			randomTypeLookup[totalFrequency] = i;
			totalFrequency++;
		}
	}
}

+ (PowerUp*) createPowerUp:(PowerUpType)type {
	return [[[powerUpClasses[type] alloc] init] autorelease];
}

+ (PowerUp*) createRandomPowerUp {
	int index = [Random intLessThan:totalFrequency];
	PowerUpType type = randomTypeLookup[index];
	return [PowerUpFactory createPowerUp:type];
}

@end
