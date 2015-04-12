//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Namespace.XniGame.classes.h"


#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Input.Touch.h"


@protocol IKillable




// VARIABLES
@property (nonatomic, retain) Vector2 *position;
@property Boolean dead;
@property int life;




// METHODS
- (BOOL) containsVector:(Vector2 *) touchPoz;

- (BOOL) isDead;

- (BOOL) isZombie;

- (void) updateWithGameTime:(GameTime *)gameTime;



@end
