//  Created by Dominik Hauser on 01.12.24.
//  
//


#import "DDHDayCell.h"
#import "DDHDay.h"

@implementation DDHDayCell

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

- (void)updateWithDay:(DDHDay *)day {
    self.textLabel.text = [NSString stringWithFormat:@"Day %ld", day.dayNumber];
}

@end
