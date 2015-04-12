//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "Rectangle+Extensions.h"


@implementation Rectangle (Extensions)

- (BOOL) containsVector:(Vector2*) value {
    
	return (value.x >= data.x &&
            value.x <= data.x + data.width &&
			value.y >= data.y &&
            value.y <= data.y + data.height
            );
}

@end
