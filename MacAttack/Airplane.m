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

        worth = 5;
        
        size = 0.4;
        width = 256 * size;
        height = 256 * size;
        
        hitArea = CGRectMake(position.x-(width/2), position.y-(height/2), width, height/2);
    }
    
    return self;
}


- (void) kill{
    [super kill];
    [SoundEngine play:0 withVolume:0.8];
}

- (void) moveCloser{
    self.position.x += speed * 1.6;
    self.position.y += 0.8;
    
}

- (void) reincarnation{
    
    
    // RANDOM SPAWN OUTSIDE OF SCREEN
    int x,y;
    Boolean insideScreen = true;
    while(insideScreen)
    {
        x = (120) + (arc4random() % (400)) * -1;
        y = (0) + (arc4random() % ((int)screenHeight));
        
        CGPoint spawnPoint = CGPointMake(x, y);
        CGRect screen = CGRectMake(0, 0, screenWidth, screenHeight);
        
        insideScreen = CGRectContainsPoint( screen,spawnPoint );
        
    }
    
    
    position.x = x;
    position.y = y;
    

    dead = false;
    respawn = false;
    zombie = NO;
    
}







- (void)updateWithGameTime:(GameTime *)gameTime{

    [super updateWithGameTime:gameTime];
    
    
    
    hitArea.origin.x = position.x-(width/2);
    hitArea.origin.y = position.y-(height/2);

    
    // we kill enemies elsewhere, otherwise this would cause infinite respawn
    if(!respawn && position.x > screenWidth+200){
        [self setRespawn:true];
    }
    
}



@end
