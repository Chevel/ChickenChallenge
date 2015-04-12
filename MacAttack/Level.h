//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Namespace.XniGame.classes.h"

#import "Retronator.Xni.Framework.h"

@interface Level : GameComponent { 
    
    Scene *scene;
  
    float difficulty;
    
}


@property float difficulty;
@property (nonatomic, strong) Scene *scene;


- (void) reset;
- (void) setCamerasOnObjects:(Matrix *)camera;



@end
