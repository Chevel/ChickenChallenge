//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "Namespace.XniGame.classes.h"

#import "Retronator.Xni.Framework.h"


//@protocol ITouchable;


@interface Enemy : GameComponent <IKillable, IMovable, ITouchable>

@property BOOL dead;
@property BOOL zombie;
@property float width;
@property float deadTime;
@property BOOL respawn;

// for child implementations
@property float speed;
@property int worth;
@property float height;
@property CGRect hitArea;


@property (nonatomic) Vector2 *position;
@property float rotation;
@property float size;


- (void) updateWithGameTime:(GameTime *)gameTime;

- (void) kill;

- (void) setCamera:(Matrix *)camera;




@end
