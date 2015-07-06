//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//



#import "Namespace.XniGame.h"
#import "math.h"


#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 57.29577951f) // PI * 180
//#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )


@implementation Rat


- (id)init
{
    self = [super init];
    if (self) {

        self.worth = 1;
        
        self.size = 0.5;
        self.width = 256 * self.size;
        self.height = 256 * self.size;
       
        self.hitArea = CGRectMake(self.position.x - self.width, self.position.y - self.height, self.width, self.height);
    }
    
    return self;
}

- (void) kill{
    [super kill];
    [SoundEngine play:0 withVolume:1];
}

- (void) moveCloser{
    
    int A = 5; // 7
    
    if(self.position.x > ( [[UIScreen mainScreen] bounds].size.width/2)){
        self.position.x -= self.speed - A * cos(arc4random());
    }
    if(self.position.x < ( [[UIScreen mainScreen] bounds].size.width/2)){
        self.position.x += self.speed + A * cos(arc4random());
    }
    
    if(self.position.y < ( [[UIScreen mainScreen] bounds].size.height/2) ){
        self.position.y += self.speed + A * cos(arc4random());
    }
    if(self.position.y > ( [[UIScreen mainScreen] bounds].size.height/2)){
        self.position.y -= self.speed - A * cos(arc4random());
    }
    
    //  NSLog(@" ROTATION = %f ", rotation);
    
    [self updateRotation];
    
}


- (void) reincarnation{
    
    
    // RANDOM SPAWN POINT OUTSIDE OF SCREEN
    int x,y;
    Boolean insideScreen = true;
    while(insideScreen)
    {
        srand(time(NULL));
        float angle = (random() % (int)(2*M_PI));
        float R =  [[UIScreen mainScreen] bounds].size.height/2 + 200;
        
        x = R * cos( angle ) +  [[UIScreen mainScreen] bounds].size.width/2;
        y = R * sin( angle ) +  [[UIScreen mainScreen] bounds].size.height/2;
        
        // DONT SPAWN INSIDE OF SCREEN
        CGPoint spawnPoint = CGPointMake(x, y);
        CGRect screen = CGRectMake(0, 0,  [[UIScreen mainScreen] bounds].size.width,  [[UIScreen mainScreen] bounds].size.height);
        
        insideScreen = CGRectContainsPoint( screen,spawnPoint );
    }
    
    
    
    [self.position setX:x];
    [self.position setY:y];
    
    [self setDead: NO];
    [self setZombie:NO];
    
}





@end
