//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import "Namespace.XniGame.h"
#import "math.h"


#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 57.29577951f) // PI * 180
//#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )


@implementation Unicorn


- (id)init
{
    self = [super init];
    if (self) {

        self.worth = 3;
        
        self.size = 0.4;
        self.width = 256 * self.size;
        self.height = 256 * self.size;
        
        self.hitArea = CGRectMake(self.position.x-self.width, self.position.y-self.height, self.width, self.height);
    }
    
    return self;
}

- (void) kill{
    [super kill];
    
    [SoundEngine play:2 withPan:0];
}

- (void) moveCloser{
    


    float xScale = 50;
    float yScale = 2;

    self.position.x += 2;  
    
    float sinus = yScale * sin( (float)self.position.x/xScale );  

    /*
    NSLog(@" -------------------------- ");
    NSLog(@" UNICORN INFO ");
    NSLog(@" X = %f",self.position.x);
    NSLog(@" Y = %f",self.position.y);
    NSLog(@" SIN = %f", sinus );
     */
    newPositionY = self.position.y+sinus;
    
    [self updateRotation];
    
    self.position.y+=sinus;
    
}

- (void) reincarnation{
    
    // RANDOM SPAWN OUTSIDE OF SCREEN
    int x,y;
    Boolean insideScreen = true;
    while(insideScreen)
    {
        x = (120 + (arc4random() % 400) ) * -1;
        y = (125) + (arc4random() % ((int)screenHeight)-125);
        

        CGPoint spawnPoint = CGPointMake(x, y);
        CGRect screen = CGRectMake(0, 0, screenWidth, screenHeight);
        
        insideScreen = CGRectContainsPoint( screen,spawnPoint );
    }
    
    [self.position setX:x];
    [self.position setY:y];
    
    [self setDead:NO];
    [self setRespawn:NO];
    [self setZombie:NO];
}

- (void) updateRotation{
    
    float distX = self.position.x - (self.position.x+3);
    float distY = self.position.y - (newPositionY);
    float rotate=0;
    
    rotate = (float)atan2( distY, distX );
    
    self.rotation = rotate - (M_PI);
    
}






- (void) updateWithGameTime:(GameTime *)gameTime{
    
    [super updateWithGameTime:gameTime];
    
    
    // we kill enemies elsewhere, otherwise this would cause infinite respawn
    if(!self.respawn && self.position.x >  [[UIScreen mainScreen] bounds].size.width){
        [self setRespawn:true];
    }
    
    
}

@end
