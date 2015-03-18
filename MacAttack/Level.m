//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//



#import "Namespace.XniGame.h"





/*
 LEVEL SHOULD HAVE
 -> SCENE (that holds enemies,powerups...)
 
 for updating game world
 */
@implementation Level



- (id)initWithGame:(Game *)theGame
{
    
    self = [super initWithGame:theGame]; 
    if (self != nil) {
        scene = [[Scene alloc] initWithGame:self.game];
    }
    return self;
}

@synthesize scene, difficulty;

- (void) initialize {
	[super initialize];
    

}




// Override this in children implementations.
- (void) reset {

}

- (void) setCamerasOnObjects:(Matrix *)theCamera {
    for(id item in scene){
        if([item conformsToProtocol:@protocol(ITouchable)] )
            [item setCamera:theCamera];
    }
}




@end
