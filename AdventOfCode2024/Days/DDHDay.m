//  Created by Dominik Hauser on 01.12.24.
//  
//


#import "DDHDay.h"

@implementation DDHDay
- (instancetype)initWithDayNumber:(NSInteger)dayNumber inputDataFileName:(NSString *)inputDataFileName {
    if (self = [super init]) {
        _dayNumber = dayNumber;
        _inputDataFileName = inputDataFileName;
    }
    return self;
}
@end
