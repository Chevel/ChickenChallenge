//
//  DeathPowerUp.m
//  Breakout
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "PowerUpType.h"
#import "Namespace.XniGame.h"


@interface GoldenEggPowerUp()


@end



@implementation GoldenEggPowerUp


// ON EVERY POWERUP CREATION, CHILDS INIT (LIKE THIS) IS CALLED FIRST
- (id) init
{
	self = [super initWithType:PowerUpTypeGoldenEgg duration:5];
	if (self != nil) {
		
        _reset = nil;
	}
	return self;
}


- (void) activate {
	[super activate];
    
	self.activated = true;
	self.dead = false;
	self.visible = false;
	
    
    
}

- (void) deactivate {
    [super deactivate];
    
    self.activated = false;
	self.dead = true;
	self.visible = false;
    
    _reset = YES;
    
}



- (void) updateWithGameTime:(GameTime*)gameTime{
    
    [super updateWithGameTime:gameTime];
    
	if (self.lifetime) {
		[self.lifetime updateWithGameTime:gameTime];
		if (!self.lifetime.isAlive) {
			self.lifetime = nil;
			[self deactivate]; //deactives + kills
            
		}
	}
    
    
    // CHECK FOR TOUCH
    TouchCollection *touches = [TouchPanel getState];
    Vector2 *touchPosition;
	BOOL touchesInInputArea = NO;
    
	for (TouchLocation *touch in touches)
    {
        
        if(self.inverseView==nil){
            NSLog(@"INV.VIEW NOT INIT - GOLDEN_EGG");
        }
        Vector2* touchInScene = [Vector2 transform:touch.position with:self.inverseView];
        
        
		if ([self.inputArea containsVector:touchInScene] && self.visible)
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
			
            [self activate];
            
            
            if (self.duration) {
                self.lifetime = [[Lifetime alloc] initWithStart:0 duration:self.duration];
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
