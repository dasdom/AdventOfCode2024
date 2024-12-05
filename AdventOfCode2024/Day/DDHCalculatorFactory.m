//  Created by Dominik Hauser on 02.12.24.
//  
//


#import "DDHCalculatorFactory.h"
#import "DDHCalculatorDayOne.h"
#import "DDHCalculatorDayTwo.h"
#import "DDHCalculatorDayThree.h"
#import "DDHCalculatorDay04.h"

@implementation DDHCalculatorFactory
+ (id<DDHCalculatorProtocol>)calculatorForDayNumber:(NSInteger)dayNumber {
    id<DDHCalculatorProtocol> calculator;
    switch (dayNumber) {
        case 1:
            calculator = [[DDHCalculatorDayOne alloc] init];
            break;
        case 2:
            calculator = [[DDHCalculatorDayTwo alloc] init];
            break;
        case 3:
            calculator = [[DDHCalculatorDayThree alloc] init];
        case 4:
            calculator = [[DDHCalculatorDay04 alloc] init];
        default:
            break;
    }
    return calculator;
}
@end
