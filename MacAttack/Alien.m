//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import "Namespace.XniGame.h"








@implementation Alien




- (id)init
{
    self = [super init];
    if (self) {
        
        worth = 10;
        
        size = 0.5;
        width = 256 * size;
        height = 256 * size;
        
        hitArea = CGRectMake(position.x-((width*size)/2), position.y-((height*size)/2), width, height);
        
        age = 0.0;
        startTime = 0.0;
        currentTime = [[NSDate date] timeIntervalSince1970];
        

    }
    
    return self;
}
- (void) setScreenTime{
    onscreenTime = 0.5;
}


@synthesize age, onscreenTime;


- (void) kill{
    [super kill];
    [SoundEngine play:0 withVolume:0.8];
}

- (void) moveCloser{
    // aliens appear and disappear
    [self reincarnation];
}

- (void) reincarnation{
    
    if([self timedout] || dead){
        // RANDOM SPAWN POINT OUTSIDE OF SCREEN
        int x,y;
        Boolean insideScreen = true;
        while( insideScreen )
        {
            x = (120) + (arc4random() % ((int)screenWidth-240));
            
            y = (120) + (arc4random() % ((int)screenHeight-240));
            
            
            CGPoint spawnPoint = CGPointMake(x, y);
            CGRect screen = CGRectMake(0, 0, screenWidth, screenHeight);
            CGRect eggArea = CGRectMake( (screenWidth/2)-100, (screenHeight/2)-50, 200, 100);
            
            // ALIEN MUST NOT BE OUTSIDE OF SCREEN or INSIDE OF EGG AREA
            insideScreen = CGRectContainsPoint( screen,spawnPoint ) || CGRectContainsPoint( eggArea,spawnPoint );
            
            // WE WANT UFOs TO SPAWN INSIDE OF SCREEN
            insideScreen = !insideScreen;
            
        }
        
        
        position.x = x;
        position.y = y;
        
        dead = false;
        respawn = false;
        zombie = NO;
        
        startTime = [[NSDate date] timeIntervalSince1970];
    }
    
}

- (BOOL) timedout{
    return (age >= onscreenTime);
}









- (void)updateWithGameTime:(GameTime *)gameTime{
    
    [super updateWithGameTime:gameTime];

    
    currentTime = [[NSDate date] timeIntervalSince1970];
    age = fabs(startTime-currentTime);
}



@end
