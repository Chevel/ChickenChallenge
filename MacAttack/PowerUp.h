//
//  PowerUp.h
//  MacAttack
//
//  Created by snowman on 11/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Namespace.XniGame.classes.h"

#import "Retronator.Xni.Framework.h"


#import "PowerUpType.h"
#import "Lifetime.h"

@interface PowerUp : GameComponent <ILifetime, IKillable, IMovable, IPowerUp, ITouchable>{
    
    
    Vector2 *position;
    
    float size;
	float width;
	float height;
    
	PowerUpType type;
    
	NSTimeInterval duration; // how long the powerup stays active
    Lifetime *lifetime;
    
	Boolean activated;
    Boolean visible;
    Boolean dead;

	id<IScene> scene;
    
    Rectangle *inputArea;
    
	Matrix *inverseView;
    
    CGRect hitArea;
}

- (PowerUpType) getType;

- (id) initWithType:(PowerUpType)theType;
- (id) initWithType:(PowerUpType)theType duration:(NSTimeInterval)theDuration;
- (void) setCamera:(Matrix *)camera;
- (void) deactivate;
- (void) updateWithGameTime:(GameTime *)gameTime;


@property CGRect hitArea;

@property (nonatomic,readonly) PowerUpType type;
@property (nonatomic,readonly) float width, height;
@property (nonatomic) Lifetime *lifetime;

@property Boolean activated;
@property Boolean visible;
@property Boolean dead;




@end
