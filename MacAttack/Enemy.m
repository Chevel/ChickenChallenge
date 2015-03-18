//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import "Namespace.XniGame.h"
#import "math.h"


#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((float)(__ANGLE__) * 57.29577951f) // PI * 180
//#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )


@implementation Enemy

- (id)init
{
    self = [super init];
    if (self) {
        position = [[Vector2 alloc] init];
        rotation = 0;
        
        dead = FALSE;
        zombie = false;
        worth = 1;
        
        size = 1; // gets overriden in child
		width = 256 * size;
		height = 256 * size;
        
        hitArea = CGRectMake(position.x-width, position.y-height, width, height);
        
        respawn = false;
    }
    
    
    touchPanel = [TouchPanel getInstance];
    
    inputArea = [[Rectangle alloc] initWithX:0
                                           y:0
                                       width:touchPanel.displayWidth
                                      height:touchPanel.displayHeight
                 ];
    
    
    
    return self;
}



@synthesize position, rotation, dead, speed, size, worth,zombie, deadTime, timeOfDeath, width, height, hitArea, respawn, nowTime;
    

- (BOOL) isDead{
    return dead;
}

- (void) updateRotation{
    
    
    float distX = self.position.x - (screenWidth/2); 
    float distY = self.position.y - (screenHeight/2); 
    float rotate=0;
    
    rotate = (float)atan2(distY, distX);
    
    rotation = rotate - (M_PI);
    
    
    
}

- (void) kill{
    dead = TRUE;
    timeOfDeath = [[NSDate date] timeIntervalSince1970];
}

- (void) setCamera:(Matrix *)camera {
    inverseView = [Matrix invert:camera];
}

- (BOOL) containsVector:(Vector2 *) touchPoz {

    
    float enemyPointX = self.position.x;
    float enemyPointY = self.position.y;
    
    CGFloat dx = (enemyPointX) - touchPoz.x;
    CGFloat dy = (enemyPointY) - touchPoz.y;
    float dist = sqrt(dx*dx + dy*dy );
    
    return (dist < 50);
}

- (BOOL) isZombie{
    return zombie;
}




- (void) updateWithGameTime:(GameTime *)gameTime{
    
    
    // GOT MOLESTED
    TouchCollection *touches = [TouchPanel getState];
    Vector2 *touchPosition;
    BOOL touchesInInputArea = NO;
    
    
    for (TouchLocation *touch in touches)
    {
        
        if(inverseView==nil){
            NSLog(@"INVERSE VIEW NOT INITIALIZED");
        }
        Vector2* touchInScene = [Vector2 transform:touch.position with:inverseView];
        
        if ([inputArea containsVector:touchInScene])
        {
            touchesInInputArea = YES;
            touchPosition = touchInScene;
        }
    }
    
    if (touchesInInputArea)
    {
        
        if([self containsVector:touchPosition] && ![self isDead] && ![self isZombie] ){
            
           // NSLog(@" KILL ");
            
            [self kill];
            
        }
    }
    
    
    
    hitArea.origin.x = position.x - width/2;
    hitArea.origin.y = position.y - height/2;
    
    
    //NSLog(@"X=%f, Y=%f\n", hitArea.origin.x, hitArea.origin.y);
    
    nowTime = [[NSDate date] timeIntervalSince1970];
    
    deadTime = fabsf(timeOfDeath-nowTime);
    

}




//IMPLEMENTED IN CHILD METHODS
/*
- (void) moveCloser{}
- (void) reincarnation{}
- (BOOL) atCenter{}
*/



@end
