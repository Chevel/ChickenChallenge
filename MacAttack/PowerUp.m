//
//  PowerUp.m
//  MacAttack
//
//  Created by snowman on 11/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "Namespace.XniGame.h"
#import "Namespace.XniGame.classes.h"


@interface PowerUp()


@end



@implementation PowerUp



- (id) initWithType:(PowerUpType)theType duration:(NSTimeInterval)theDuration{

        TouchPanel *touchPanel = [TouchPanel getInstance];
        _inputArea = [[Rectangle alloc] initWithX:0
                                               y:0
                                           width:touchPanel.displayWidth
                                          height:touchPanel.displayHeight
                     ];
        
        self.activated = NO;
        self.dead = NO;
        self.visible = YES;
        
        [self spawn];
    
        self.size = 0.6;
		self.width = 128 * self.size;
		self.height = 256 * self.size;
    
		self.type = theType;
		_duration = theDuration;
    
        _hitArea = CGRectMake(self.position.x-self.width/2, self.position.y-self.height/2, self.width, self.height);
    
	
	return self;
}



//@synthesize position, size, width, height, type, lifetime, rotation, dead, visible, activated, hitArea;


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


    return CGRectContainsPoint( _hitArea,touch );
    
}

- (void) kill{
    self.activated = false;
    self.dead = true;
    self.visible = false;
}



- (void) moveCloser{
   self.position.y += 1.7;  // 1 = OK
}

- (BOOL) outOfBounds{
    if(self.position.y > screenHeight+_height){
        return true;
    }
    return false;
}

- (void) spawn{
    int x = _width + (random() % ((int)screenWidth)-_width);
    int y = (5 + (random() % 50)) * -1;

    
    // DONT SPAWN AT EGG LOCATION
    if( x >= screenWidth/2 - 64 &&
        x <= screenWidth/2 + 64
    ){
        x += 128;
    }
    
    self.position = [[Vector2 alloc] initWithX:x y:y];
}

- (void) activate{
  [SoundEngine play:1 withPan:0.2];
    
}
- (void) deactivate{
    
}

- (void) setCamera:(Matrix *)camera {
	_inverseView = [Matrix invert:camera];
}



- (void) updateWithGameTime:(GameTime*)gameTime{
    
    
    _hitArea.origin.x = self.position.x - (_width/2);
    _hitArea.origin.y = self.position.y - (_height/2);
    
    // OUT OF SCREEN = DEAD
    if( [self outOfBounds] ){
        [self kill];
    }
    
    
}

@end
