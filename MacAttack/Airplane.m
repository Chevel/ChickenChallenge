//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


//#import "Rat.H"

#import "Namespace.XniGame.h"
#import "math.h"




@implementation Airplane




- (id)init
{
    self = [super init];
    if (self) {

        self.worth = 5;
        
        self.size = 0.4;
        self.width = 256 * self.size;
        self.height = 256 * self.size;
        
        self.hitArea = CGRectMake(self.position.x-(self.width/2), self.position.y-(self.height/2), self.width, self.height/2);
    }
    
    return self;
}


- (void) kill{
    [super kill];
    [SoundEngine play:0 withVolume:0.8];
}

- (void) moveCloser{
    self.position.x += self.speed * 1.6;
    self.position.y += 0.8;
    
}

- (void) reincarnation{
    
    
    // RANDOM SPAWN OUTSIDE OF SCREEN
    int x,y;
    Boolean insideScreen = true;
    while(insideScreen)
    {
        x = (120) + (arc4random() % (400)) * -1;
        y = (0) + (arc4random() % ((int)[[UIScreen mainScreen] bounds].size.height));
        
        CGPoint spawnPoint = CGPointMake(x, y);
        CGRect screen = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        
        insideScreen = CGRectContainsPoint( screen,spawnPoint );
        
    }
    
    
    [self.position setX:x];
    [self.position setY:y];
    
    [self setDead:NO];
    [self setRespawn:NO];
    [self setZombie:NO];
}







- (void)updateWithGameTime:(GameTime *)gameTime{

    [super updateWithGameTime:gameTime];
    
    
//    self.hitArea.origin.x = self.position.x-(self.width/2);
//    self.hitArea.origin.y = self.position.y-(self.height/2);

    
    // we kill enemies elsewhere, otherwise this would cause infinite respawn
    if(!self.respawn && self.position.x > [[UIScreen mainScreen] bounds].size.width+200){
        [self setRespawn:true];
    }
    
}



@end
