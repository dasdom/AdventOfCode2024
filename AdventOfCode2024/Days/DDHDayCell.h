//  Created by Dominik Hauser on 01.12.24.
//  
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DDHDay;

@interface DDHDayCell : UITableViewCell
+ (NSString *)identifier;
- (void)updateWithDay:(DDHDay *)day;
@end

NS_ASSUME_NONNULL_END
