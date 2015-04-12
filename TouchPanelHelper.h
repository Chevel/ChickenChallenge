//
//  TouchPanelHelper.h
//  Artificial I
//
//  Created by Matej Jan on 1.12.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.Input.Touch.h"
#import "Retronator.Xni.Framework.h" 
#import "Namespace.XniGame.classes.h"

@interface TouchPanelHelper : GameComponent {

    
	Matrix *inverseView;
    
    Rectangle *inputArea;
    
    
}

+ (TouchCollection*) getState;


@property (nonatomic) int displayHeight;
@property (nonatomic) int displayWidth;

@end
