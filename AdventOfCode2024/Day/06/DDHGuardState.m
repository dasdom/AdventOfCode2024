//  Created by Dominik Hauser on 07.12.24.
//  
//


#import "DDHGuardState.h"

@implementation DDHGuardState

- (instancetype)initWithPosition:(CGPoint)position direction:(DDHGuardDirection)direction {
    if (self = [super init]) {
        _position = position;
        _direction = direction;
    }
    return self;
}

- (BOOL)isEqual:(DDHGuardState *)other {
    if (self.position.x != other.position.x) {
        return NO;
    } else if (self.position.y != other.position.y) {
        return NO;
    } else if (self.direction != other.direction) {
        return NO;
    }
    return YES;
}

- (BOOL)samePositionAs:(DDHGuardState *)other {
    if (self.position.x != other.position.x) {
        return NO;
    } else if (self.position.y != other.position.y) {
        return NO;
    }
    return YES;
}

@end
