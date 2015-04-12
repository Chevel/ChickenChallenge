//
//  DeathPowerUp.m
//  Breakout
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "PowerUpType.h"
#import "Namespace.XniGame.h"

@implementation DeadPowerUp


// ON EVERY POWERUP CREATION, CHILDS INIT (LIKE THIS) IS CALLED FIRST
- (id) init
{
	self = [super initWithType:PowerUpTypeDeath duration:5];
	if (self != nil) {
		
        
	}
	return self;
}

@synthesize reset;

- (void) activate {
	[super activate];
    
	activated = true;
	dead = false;
	visible = false;
	
    
    
}

- (void) deactivate {
    [super deactivate];
    
    activated = false;
	dead = true;
	visible = false;
    
    reset = true;
}



- (void) updateWithGameTime:(GameTime*)gameTime{
    
    [super updateWithGameTime:gameTime];
    
    reset = false;
    
	if (lifetime) {
		[lifetime updateWithGameTime:gameTime];
		if (!lifetime.isAlive) {
			lifetime = nil;
			//[self deactivate]; //deactives + kills
            
		}
	}
    
    
    // CHECK FOR TOUCH
    TouchCollection *touches = [TouchPanel getState];
    Vector2 *touchPosition;
	BOOL touchesInInputArea = NO;
    
	for (TouchLocation *touch in touches)
    {
        
        if(inverseView==nil){
            NSLog(@"INV.VIEW NOT INIT - SLOWED POWERUP");
        }
        Vector2* touchInScene = [Vector2 transform:touch.position with:inverseView];
        
        
		if ([inputArea containsVector:touchInScene] && visible)
        {
            touchesInInputArea = YES;
            touchPosition = touchInScene;
            
		}
	}
    
	if (touchesInInputArea)
    {
        //touchesInInputArea = NO;
        
        if([self containsVector:touchPosition])
        {
            
            // DATA FROM GameHud->BACK BUTTON
            Rectangle* _pauseButton = [[Rectangle alloc] initWithX:0
                                                                 y:screenHeight-256
                                                             width:256
                                                            height:256];
			if( ![_pauseButton containsVector:touchPosition] )
            {
                [self activate];
            }
        
            
            if (duration) {
                lifetime = [[Lifetime alloc] initWithStart:0 duration:duration];
            }
            
            
        }
    }
    
    /*
     NSLog(@"-----------------");
     NSLog(@" ACTIVATED = %s", activated ? "TRUE" : "FALSE");
     NSLog(@" DEAD = %s", dead ? "TRUE" : "FALSE");
     NSLog(@" VISIBLE = %s", visible ? "TRUE" : "FALSE");
     NSLog(@" X = %f", position.x);
     NSLog(@" Y = %f", position.y);
     NSLog(@"-----------------");
     */
    
    
}

@end
