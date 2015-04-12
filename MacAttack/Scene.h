//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "Namespace.XniGame.classes.h"

#import "IScene.h"

@interface Scene : GameComponent <IScene>{

    NSMutableArray *items;
    
    
    
}

- (void) addItem:(id)item;


- (void) removeItem:(id)item;
- (void) clear;




@end
