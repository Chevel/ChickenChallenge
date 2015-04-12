//
//  DeathPowerUp.h
//  Breakout
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PowerUp.h"

@interface DeadPowerUp : PowerUp {
	
    BOOL reset;
    
}

@property BOOL reset;


@end
