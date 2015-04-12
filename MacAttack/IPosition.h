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




@protocol IPosition


@property (nonatomic, retain) Vector2 *position;
@property (nonatomic, retain) Rectangle *state;

@property float rotation;
@property int life;




@end