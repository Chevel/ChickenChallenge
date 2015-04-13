//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "Namespace.XniGame.classes.h"

#import "Retronator.Xni.Framework.h"


@protocol ITouchable;


@interface Enemy : GameComponent <IKillable, IMovable, ITouchable>{

    BOOL respawn;
    
    float width,height;
    
    int worth;
    float size;
    float speed;
    Boolean dead;
    
    Vector2 *position;
    float rotation;
    Rectangle *inputArea;
	BOOL grabbed;
    
    
    
	Scene *scene;
    
    Rectangle *outsideOf;
    
    TouchPanel *touchPanel;
    
    
	Matrix *inverseView;
    
    // ZOMBIE DATA
    BOOL zombie;
    float deadTime;
    NSTimeInterval timeOfDeath;
    NSTimeInterval nowTime;
    
    
    CGRect hitArea;
}


@property CGRect hitArea;

@property float width,height;

@property float deadTime;
@property NSTimeInterval nowTime, timeOfDeath;
@property BOOL zombie;


@property BOOL respawn, startAnimation;
@property Boolean dead;
@property int worth;
@property float speed;



- (void) updateWithGameTime:(GameTime *)gameTime;

- (void) reincarnation;

- (void) kill;

- (void) setCamera:(Matrix *)camera;

- (BOOL) isDead;
- (BOOL) isZombie;



@end
