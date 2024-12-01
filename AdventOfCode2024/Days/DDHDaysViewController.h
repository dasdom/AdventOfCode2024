//  Created by Dominik Hauser on 01.12.24.
//  
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DDHDay;

@protocol DDHDaysViewControllerProtocol <NSObject>
- (void)viewController:(UIViewController *)viewController didSelectDay:(DDHDay *)day;
@end

@interface DDHDaysViewController : UIViewController
- (instancetype)initWithDelegate:(id<DDHDaysViewControllerProtocol>)delegate;
@end

NS_ASSUME_NONNULL_END
