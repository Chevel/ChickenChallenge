//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "Namespace.XniGame.h"
#import <Foundation/Foundation.h>




#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((float)(__ANGLE__) * 57.29577951f) // PI * 180


@implementation Level1


- (id) initWithGame:(Game *)theGame
{
    
    self = [super initWithGame:theGame];
    
	if (self != nil) {
        numOfEnemies = 8;
        
        srandom(time(NULL));
        
        [self skySTAGE];
    }
    
    return self;
}

@synthesize rat1, rat2, rat3, rat4, rat5, rat6, rat7, rat8;
@synthesize u1, u2, u3, u4, u5, u6;
@synthesize a1, a2, a3, a4, a5, a6;
@synthesize p1, p2;
@synthesize ufo1, ufo2;



- (void) updateLVL:(int)stage{
    
    switch(stage){
        case 1: [self rainbowSTAGE];
            //NSLog(@" RAINBOW STAGE ");
            break;
            
        case 2: [self cloudsSTAGE];
            //NSLog(@" CLOUD STAGE ");
            break;
            
        case 3: [self spaceSTAGE];
            //NSLog(@" SPACE STAGE ");
            break;
    
    }
    
    
}

// INITIAL STAGE
-(void) skySTAGE{
    
    
    // CREATE ENEMIES
    
    rat1 = [[Rat alloc] init];
    rat2 = [[Rat alloc] init];
    rat3 = [[Rat alloc] init];
    rat4 = [[Rat alloc] init];
    rat5 = [[Rat alloc] init];
    rat6 = [[Rat alloc] init];
    rat7 = [[Rat alloc] init];
    rat8 = [[Rat alloc] init];
    [scene addItem:rat1];
    [scene addItem:rat2];
    [scene addItem:rat3];
    [scene addItem:rat4];
    [scene addItem:rat5];
    [scene addItem:rat6];
    [scene addItem:rat7];
    [scene addItem:rat8];
    
    
    
    //
    // RANDOM SPAWN ENEMIES
    //
    for(int i=1; i <= numOfEnemies; i++){
        
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
        
        
        // SET THE RANDOM SPAWN POINT FOR EACH ENEMY
        switch(i){
            case 1:
                rat1.position.x = x;
                rat1.position.y = y;
                
                rat1.speed = difficulty;
                [rat1 updateRotation];
                break;
                
                
            case 2:
                rat2.position.x = x;
                rat2.position.y = y;
                
                rat2.speed = difficulty;
                [rat2 updateRotation];
                break;
                
                
            case 3:
                rat3.position.x = x;
                rat3.position.y = y;
                
                rat3.speed = difficulty;
                [rat3 updateRotation];
                break;
                
                
            case 4:
                rat4.position.x = x;
                rat4.position.y = y;
                
                rat4.speed = difficulty;
                [rat4 updateRotation];
                break;
                
            case 5:
                rat5.position.x = x;
                rat5.position.y = y;
                
                rat5.speed = difficulty;
                [rat5 updateRotation];
                break;
                
            case 6:
                rat6.position.x = x;
                rat6.position.y = y;
                
                rat6.speed = difficulty;
                [rat6 updateRotation];
                break;
                
            case 7:
                rat7.position.x = x;
                rat7.position.y = y;
                
                rat7.speed = difficulty;
                [rat7 updateRotation];
                break;
                
            case 8:
                rat8.position.x = x;
                rat8.position.y = y;
                
                rat8.speed = difficulty;
                [rat8 updateRotation];
                break;
        }
    }
    
    
    //
    // CREATE POWER-UPs
    //
    p1 = [PowerUpFactory createRandomPowerUp];
    p2 = [PowerUpFactory createRandomPowerUp];
    
    
    [scene addItem:p1];
    [scene addItem:p2];
    
    
}

// STAGE = 1
-(void) rainbowSTAGE{
    
    //NSLog(@" RAINBOW STAGE ");
    
    
    //
    // CREATE INITIAL SETUP
    //
    
    // CREATE ENEMIES
    u1 = [[Unicorn alloc] init];
    u2 = [[Unicorn alloc] init];
    u3 = [[Unicorn alloc] init];
    u4 = [[Unicorn alloc] init];
    u5 = [[Unicorn alloc] init];
    u6 = [[Unicorn alloc] init];
    [scene addItem:u1];
    [scene addItem:u2];
    [scene addItem:u3];
    [scene addItem:u4];
    [scene addItem:u5];
    [scene addItem:u6];
    
    numOfEnemies = 6;
    for(int i=1; i<numOfEnemies; i++){
        
        // RANDOM SPAWN POINT OUTSIDE OF SCREEN
        int x,y;
        Boolean insideScreen = true;
        while(insideScreen)
        {
            x = (120 + (arc4random() % 800)) * -1;
            y = (250) + (arc4random() % ((int)screenHeight));
            
            
            // DONT SPAWN INSIDE OF SCREEN
            CGPoint spawnPoint = CGPointMake(x, y);
            CGRect screen = CGRectMake(0, 0, screenWidth, screenHeight);
            
            insideScreen = CGRectContainsPoint( screen,spawnPoint );
        }
        
        
        
        // SET THE RANDOM SPAWN POINT FOR EACH ENEMY
        switch(i){
            case 1:
                u1.position.x = x;
                u1.position.y = y;
                
                u1.speed = difficulty;
                break;
                
            case 2:
                u2.position.x = x;
                u2.position.y = y;
                
                u2.speed = difficulty;
                break;
                
            case 3:
                u3.position.x = x;
                u3.position.y = y;
                
                u3.speed = difficulty;
                break;
                
            case 4:
                u4.position.x = x;
                u4.position.y = y;
                
                u4.speed = difficulty;
                break;
                
            case 5:
                u5.position.x = x;
                u5.position.y = y;
                
                u5.speed = difficulty;
                break;
                
            case 6:
                u6.position.x = x;
                u6.position.y = y;
                
                u6.speed = difficulty;
                break;
        }
        
    }

    
    
    
}

// STAGE = 2
-(void) cloudsSTAGE{
    
    //NSLog(@" CLOUD STAGE ");
 
    //
    // CREATE INITIAL SETUP
    //
    
    // CREATE ENEMIES
    a1 = [[Airplane alloc] init];
    a2 = [[Airplane alloc] init];
    a3 = [[Airplane alloc] init];
    a4 = [[Airplane alloc] init];
    [scene addItem:a1];
    [scene addItem:a2];
    [scene addItem:a3];
    [scene addItem:a4];
    
    
    numOfEnemies = 4;
    for(int i=1; i <= numOfEnemies; i++){
        
        // RANDOM SPAWN POINT OUTSIDE OF SCREEN
        int x,y;
        Boolean insideScreen = true;
        while(insideScreen)
        {
            x = (120 + (arc4random() % 400)) * -1;
            y = (0) + (arc4random() % ((int)screenHeight));
            
            // DONT SPAWN INSIDE OF SCREEN
            CGPoint spawnPoint = CGPointMake(x, y);
            CGRect screen = CGRectMake(0, 0, screenWidth, screenHeight);
            
            insideScreen = CGRectContainsPoint( screen,spawnPoint );
        }
        
        // SET THE RANDOM SPAWN POINT FOR EACH ENEMY
        switch(i){
            case 1:
                a1.position.x = x;
                a1.position.y = y;
                
                a1.speed = difficulty;
                break;
                
            case 2:
                a2.position.x = x;
                a2.position.y = y;
                
                a2.speed = difficulty;
                break;
                
            case 3:
                a3.position.x = x;
                a3.position.y = y;
                
                a3.speed = difficulty;
                break;
                
            case 4:
                a4.position.x = x;
                a4.position.y = y;
                
                a4.speed = difficulty;
                break;
                
            case 5:
                a5.position.x = x;
                a5.position.y = y;
                
                a5.speed = difficulty;
                break;
                
            case 6:
                a6.position.x = x;
                a6.position.y = y;
                
                a6.speed = difficulty;
                break;
        }
        
    }
    
    
}

// STAGE = 3
-(void) spaceSTAGE{
    
   // NSLog(@" RAINBOW STAGE ");
    
    
    //
    // CREATE INITIAL SETUP
    //
    
    // CREATE ENEMIES
    ufo1 = [[Alien alloc] init];
    ufo2 = [[Alien alloc] init];
    [scene addItem:ufo1];
    [scene addItem:ufo2];
    
    // SET ENEMIES
    numOfEnemies = 2;
    for(int i=0; i<numOfEnemies; i++){
        
        
        // RANDOM SPAWN POINT OUTSIDE OF SCREEN
        int x,y;
        Boolean insideScreen = true;
        while( insideScreen )
        {
            x = (120) + (arc4random() % ((int)screenWidth-240));
            y = (120) + (arc4random() % ((int)screenHeight-240));
            
            
            CGPoint spawnPoint = CGPointMake(x, y);
            CGRect screen = CGRectMake(0, 0, screenWidth, screenHeight);
            
            insideScreen = CGRectContainsPoint( screen,spawnPoint );
            
            // WE WANT UFOs TO SPAWN INSIDE OF SCREEN
            insideScreen = !insideScreen;
            
        }
        
        
        // SET THE RANDOM SPAWN POINT FOR EACH ENEMY
        switch(i){
            case 0:
                ufo1.position.x = x;
                ufo1.position.y = y;
    
                ufo1.speed = difficulty;
                [ufo1 setScreenTime];
                
                break;
            
            case 1:
                ufo2.position.x = x;
                ufo2.position.y = y;
                
                ufo2.speed = difficulty;
                [ufo2 setScreenTime];
                
                break;
        }
    }
}



@end
