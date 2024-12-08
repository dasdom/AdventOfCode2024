//  Created by Dominik Hauser on 07.12.24.
//  
//


#import <Foundation/Foundation.h>
#import "DDHGuardDirection.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHGuardState : NSObject
@property (assign) CGPoint position;
@property (assign) DDHGuardDirection direction;
- (instancetype)initWithPosition:(CGPoint)position direction:(DDHGuardDirection)direction;
- (BOOL)samePositionAs:(DDHGuardState *)other;
@end

NS_ASSUME_NONNULL_END
