//
//  AnimatedSpriteFrame.m
//  Express
//
//  Created by Matej Jan on 27.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "AnimatedSpriteFrame.h"


@implementation AnimatedSpriteFrame

- (id) initWithSprite:(Sprite *)theSprite start:(NSTimeInterval)theStart
{
	self = [super init];
	if (self != nil) {
		sprite = theSprite;
		start = theStart;
	}
	return self;
}

+ (id) frameWithSprite:(Sprite *)theSprite start:(NSTimeInterval)theStart {
	return [[AnimatedSpriteFrame alloc] initWithSprite:theSprite start:theStart];
}

@synthesize sprite;
@synthesize start;




@end
