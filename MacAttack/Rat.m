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

        worth = 1;
        
        size = 0.5;
        width = 256 * size;
        height = 256 * size;
       
        hitArea = CGRectMake(position.x-width, position.y-height, width, height);  
    }
    
    return self;
}

- (void) kill{
    [super kill];
    [SoundEngine play:0 withVolume:1];
}

- (void) moveCloser{
    
    int A = 5; // 7
    
    if(position.x > (screenWidth/2)){
        position.x -= speed - A * cos(arc4random());
    }
    if(self.position.x < (screenWidth/2)){
        position.x += speed + A * cos(arc4random());
    }
    
    if(position.y < (screenHeight/2) ){
        position.y += speed + A * cos(arc4random());
    }
    if(self.position.y > (screenHeight/2)){
        position.y -= speed - A * cos(arc4random());
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
        float R = screenHeight/2 + 200;
        
        x = R * cos( angle ) + screenWidth/2;
        y = R * sin( angle ) + screenHeight/2;
        
        // DONT SPAWN INSIDE OF SCREEN
        CGPoint spawnPoint = CGPointMake(x, y);
        CGRect screen = CGRectMake(0, 0, screenWidth, screenHeight);
        
        insideScreen = CGRectContainsPoint( screen,spawnPoint );
    }
    
    

    
    position.x = x;
    position.y = y;
    
    
    dead = false;
    zombie = NO;

    
}





@end
