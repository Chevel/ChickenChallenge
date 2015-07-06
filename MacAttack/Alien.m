//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import "Namespace.XniGame.h"



@interface Alien()


@property double age;
@property double onscreenTime;


@property NSTimeInterval startTime;
@property NSTimeInterval currentTime;


@end




@implementation Alien




- (id)init
{
    self = [super init];
    if (self) {
        
        self.worth = 10;
        
        self.size = 0.5;
        self.width = 256 * self.size;
        self.height = 256 * self.size;
        
        self.hitArea = CGRectMake(self.position.x-((self.width*self.size)/2), self.position.y-((self.height*self.size)/2), self.width, self.height);
        
        _age = 0.0;
        _startTime = 0.0;
        _currentTime = [[NSDate date] timeIntervalSince1970];
        

    }
    
    return self;
}
- (void) setScreenTime{
    _onscreenTime = 0.5;
}

- (void) kill{
    [super kill];
    [SoundEngine play:0 withVolume:0.8];
}

- (void) moveCloser{
    // aliens appear and disappear
    [self reincarnation];
}

- (void) reincarnation{
    
    if([self timedout] || [self dead]){
        // RANDOM SPAWN POINT OUTSIDE OF SCREEN
        int x,y;
        Boolean insideScreen = true;
        while( insideScreen )
        {
            x = (120) + (arc4random() % ((int)[[UIScreen mainScreen] bounds].size.width-240));
            
            y = (120) + (arc4random() % ((int)[[UIScreen mainScreen] bounds].size.height-240));
            
            
            CGPoint spawnPoint = CGPointMake(x, y);
            CGRect screen = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
            CGRect eggArea = CGRectMake( ([[UIScreen mainScreen] bounds].size.width/2)-100, ([[UIScreen mainScreen] bounds].size.height/2)-50, 200, 100);
            
            // ALIEN MUST NOT BE OUTSIDE OF SCREEN or INSIDE OF EGG AREA
            insideScreen = CGRectContainsPoint( screen,spawnPoint ) || CGRectContainsPoint( eggArea,spawnPoint );
            
            // WE WANT UFOs TO SPAWN INSIDE OF SCREEN
            insideScreen = !insideScreen;
            
        }
        
        
        
        [self.position setX:x];
        [self.position setY:y];
        
        [self setDead:NO];
        [self setRespawn:NO];
        [self setZombie:NO];
        
        _startTime = [[NSDate date] timeIntervalSince1970];
    }
    
}

- (BOOL) timedout{
    return (_age >= _onscreenTime);
}









- (void)updateWithGameTime:(GameTime *)gameTime{
    
    [super updateWithGameTime:gameTime];

    
    _currentTime = [[NSDate date] timeIntervalSince1970];
    _age = fabs(_startTime - _currentTime);
}



@end
