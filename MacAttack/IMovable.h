//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Namespace.XniGame.classes.h"


@protocol IMovable


// VARIABLES
@property float rotation;
@property float size;


// METHODS
- (void) moveCloser;

- (BOOL) atCenter;

- (void) updateRotation;




@end
