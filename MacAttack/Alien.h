//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Alien : Enemy {
    
    
    NSTimeInterval startTime;
    NSTimeInterval currentTime;

    double age;
    double onscreenTime;
}

@property double age;
@property double onscreenTime;

- (void) setScreenTime;

@end
