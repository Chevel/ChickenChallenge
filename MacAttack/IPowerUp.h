//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

@protocol IPowerUp

#import "PowerUpType.h"


// VARIABLES
@property BOOL activated;
@property BOOL visible;
@property (nonatomic) PowerUpType type;



// METHODS

- (void) activate;

- (void) reincarnation;

- (void) updateWithGameTime:(GameTime *)gameTime;



@end
