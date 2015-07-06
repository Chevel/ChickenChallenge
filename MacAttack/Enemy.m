//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import "Namespace.XniGame.h"
#import "math.h"


#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((float)(__ANGLE__) * 57.29577951f) // PI * 180

@interface Enemy()

@property Rectangle *inputArea;
@property Matrix *inverseView;

@property NSTimeInterval nowTime, timeOfDeath;
@property BOOL startAnimation;

@end


@implementation Enemy



- (id)init
{
    self = [super init];
    if (self) {
        self.position = [[Vector2 alloc] init];
        self.rotation = 0;
        
        _dead = NO;
        _zombie = NO;
        _worth = 1;
        
        self.size = 1; // gets overriden in child
		_width = 256 * self.size;
		_height = 256 * self.size;
        
        _hitArea = CGRectMake(self.position.x - _width, self.position.y - _height, _width, _height);
        
        _respawn = NO;
    }
    
    
    
    _inputArea = [[Rectangle alloc] initWithX:0
                                           y:0
                                       width:[TouchPanel getInstance].displayWidth
                                      height:[TouchPanel getInstance].displayHeight
                 ];
    
    
    
    return self;
}



- (void) updateRotation{
    
    
    float distX = self.position.x - ([[UIScreen mainScreen] bounds].size.width/2);
    float distY = self.position.y - ([[UIScreen mainScreen] bounds].size.height/2);
    float rotate=0;
    
    rotate = (float)atan2(distY, distX);
    
    self.rotation = rotate - (M_PI);
    
    
    
}

- (void) kill{
    _dead = TRUE;
    _timeOfDeath = [[NSDate date] timeIntervalSince1970];
}

- (void) setCamera:(Matrix *)camera {
    _inverseView = [Matrix invert:camera];
}

- (BOOL) containsVector:(Vector2 *) touchPoz {

    
    float enemyPointX = self.position.x;
    float enemyPointY = self.position.y;
    
    CGFloat dx = (enemyPointX) - touchPoz.x;
    CGFloat dy = (enemyPointY) - touchPoz.y;
    float dist = sqrt(dx*dx + dy*dy );
    
    return (dist < 50);
}





- (void) updateWithGameTime:(GameTime *)gameTime{
    
    
    // GOT MOLESTED
    TouchCollection *touches = [TouchPanel getState];
    Vector2 *touchPosition;
    BOOL touchesInInputArea = NO;
    
    
    for (TouchLocation *touch in touches)
    {
        
        if(_inverseView==nil){
            NSLog(@"INVERSE VIEW NOT INITIALIZED");
        }
        Vector2* touchInScene = [Vector2 transform:touch.position with:_inverseView];
        
        if ([_inputArea containsVector:touchInScene])
        {
            touchesInInputArea = YES;
            touchPosition = touchInScene;
        }
    }
    
    if (touchesInInputArea)
    {
        
        if([self containsVector:touchPosition] && ![self dead] && ![self zombie] ){
            
           // NSLog(@" KILL ");
            
            [self kill];
            
        }
    }
    
    
    
    _hitArea.origin.x = self.position.x - _width/2;
    _hitArea.origin.y = self.position.y - _height/2;
    
    
    //NSLog(@"X=%f, Y=%f\n", hitArea.origin.x, hitArea.origin.y);
    
    _nowTime = [[NSDate date] timeIntervalSince1970];
    
    _deadTime = fabs(_timeOfDeath - _nowTime);
    

}




//IMPLEMENTED IN CHILD METHODS
/*
- (void) moveCloser{}
- (void) reincarnation{}
*/


@end
