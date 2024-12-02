//  Created by Dominik Hauser on 02.12.24.
//  
//


#import <Foundation/Foundation.h>
#import "DDHCalculatorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHCalculatorFactory : NSObject
+ (id<DDHCalculatorProtocol>)calculatorForDayNumber:(NSInteger)dayNumber;
@end

NS_ASSUME_NONNULL_END
