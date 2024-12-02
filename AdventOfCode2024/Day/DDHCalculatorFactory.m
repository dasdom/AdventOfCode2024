//  Created by Dominik Hauser on 02.12.24.
//  
//


#import "DDHCalculatorFactory.h"
#import "DDHCalculatorDayOne.h"

@implementation DDHCalculatorFactory
+ (id<DDHCalculatorProtocol>)calculatorForDayNumber:(NSInteger)dayNumber {
    id<DDHCalculatorProtocol> calculator;
    switch (dayNumber) {
        case 1:
            calculator = [[DDHCalculatorDayOne alloc] init];
            break;

        default:
            break;
    }
    return calculator;
}
@end
