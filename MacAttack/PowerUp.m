//
//  PowerUp.m
//  MacAttack
//
//  Created by snowman on 11/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "Namespace.XniGame.h"
#import "Namespace.XniGame.classes.h"


@implementation PowerUp



- (id) initWithType:(PowerUpType)theType duration:(NSTimeInterval)theDuration;{

        TouchPanel *touchPanel = [TouchPanel getInstance];
        inputArea = [[Rectangle alloc] initWithX:0
                                               y:0
                                           width:touchPanel.displayWidth
                                          height:touchPanel.displayHeight
                     ];
        
        activated = false;
        dead = false;
        visible = true;
        
        [self spawn];
    
        size = 0.6;
		width = 128 * size;
		height = 256 * size;
    
		type = theType;
		duration = theDuration;
    
        hitArea = CGRectMake(position.x-width/2, position.y-height/2, width, height);
    
	
	return self;
}



@synthesize position, size, width, height, type, lifetime, rotation, dead, visible, activated, hitArea;


- (BOOL) containsVector:(Vector2 *) touchPoz {
	/*
	NSLog(@"--------------");
	NSLog(@" TOUCH = %f,%f ", touchPoz.x, touchPoz.y);
	NSLog(@" POSITION = %f,%f ", position.x, position.y);
	NSLog(@" AREA_X = %f,%f ", position.x-128,position.x+128);
	NSLog(@" AREA_Y = %f,%f ", position.y-128,position.y+128);
	NSLog(@"--------------");
    */
    
    
    CGPoint touch = CGPointMake(touchPoz.x,touchPoz.y);


    return CGRectContainsPoint( hitArea,touch );
    
}

- (void) kill{
    self.activated = false;
    self.dead = true;
    self.visible = false;
}

- (BOOL) isDead{
    return dead;
}

- (BOOL) isActivated{
    return activated;
}

- (void) moveCloser{
   self.position.y += 1.7;  // 1 = OK
}

- (BOOL) outOfBounds{
    if(self.position.y > screenHeight+height){
        return true;
    }
    return false;
}

- (void) spawn{
    int x = width + (random() % ((int)screenWidth)-width);
    int y = (5 + (random() % 50)) * -1;

    
    // DONT SPAWN AT EGG LOCATION
    if( x >= screenWidth/2 - 64 &&
        x <= screenWidth/2 + 64
    ){
        x += 128;
    }
    
    position = [[Vector2 alloc] initWithX:x y:y];
}

- (void) activate{
  [SoundEngine play:1 withPan:0.2];
    
}
- (void) deactivate{
    
}

- (void) setCamera:(Matrix *)camera {
	inverseView = [Matrix invert:camera];
}


- (PowerUpType) getType{
    return self.type;
}





- (void) updateWithGameTime:(GameTime*)gameTime{
    
    
    hitArea.origin.x = position.x - (width/2);
    hitArea.origin.y = position.y - (height/2);
    
    // OUT OF SCREEN = DEAD
    if( [self outOfBounds] ){
        [self kill];
    }
    
    
}

@end
