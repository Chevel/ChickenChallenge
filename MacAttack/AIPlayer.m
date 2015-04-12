//
//  HumanPlayer.m
//  XniGame
//
//  Created by snowman on 11/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Namespace.XniGame.h"

#import "Retronator.Xni.Framework.Input.Touch.h"



@implementation AIPlayer


- (id) initWithGame:(Game *)theGame rat:(Rat *)theRat
{
    
    self = [super initWithGame:theGame];
    
    if(self != nil){
        rat = theRat;
        
        TouchPanel *touchPanel = [TouchPanel getInstance];
        int screenHeight = touchPanel.displayHeight;
        int screenWidth = touchPanel.displayWidth;
        inputArea = [[Rectangle alloc] initWithX:0 y:0 width:screenWidth height:screenHeight];
    }
    
    return self;
}




//tukej rabim updateWithGameTime da vsebuje scene
- (void) updateWithGameTime:(GameTime *)gameTime scene:(Scene *)theScene{
      
    //PREMIKI
    TouchCollection *touches = [TouchPanel getState];
    Vector2 *touchPosition;
	BOOL touchesInInputArea = NO;
    
	for (TouchLocation *touch in touches)
    {
		if ([inputArea containsVector:touch.position])
        {
            touchesInInputArea = YES;
            touchPosition = touch.position;
            
		}
	}
    
    
    
    NSLog(@"UPDATE RAT KLICK");
    
    
	if (touchesInInputArea)
    {
        touchesInInputArea = NO; 
        
        for(id<NSObject>item in theScene)
        {
            id<IKillable>itemWithLife = nil;
            
            if([item conformsToProtocol:@protocol(IKillable)] )
            {
                itemWithLife = (id<IKillable>)item;
                
                if([itemWithLife containsVector:touchPosition]){
                    
                    
                    
                    //ce kliknemo na itemWithLife, potem life--
                    [itemWithLife minusLife];
                    
                    
                    //NSLog(@"itemWithLife_life: %d | dead: %s", itemWithLife.life, ([itemWithLife isDead] ? "true" : "false"));
                    
                }
                
                
                
            }
        }
    }
	
}





- (void) dealloc{
	[inputArea release];
	[super dealloc];
}



@end
