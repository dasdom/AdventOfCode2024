//  Created by Dominik Hauser on 01.12.24.
//  
//


#import "DDHAppCoordinator.h"
#import <UIKit/UIKit.h>
#import "DDHDaysViewController.h"
#import "DDHDayOneViewController.h"

@interface DDHAppCoordinator () <DDHDaysViewControllerProtocol>
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation DDHAppCoordinator

- (instancetype)init {
    if (self = [super init]) {
        _navigationController = [[UINavigationController alloc] init];
    }
    return self;
}

- (UIViewController *)start {
    DDHDaysViewController *next = [[DDHDaysViewController alloc] initWithDelegate:self];
    [self.navigationController pushViewController:next animated:NO];
    return self.navigationController;
}

// MARK: - DDHDaysViewControllerDelegate
- (void)viewController:(UIViewController *)viewController didSelectDay:(DDHDay *)day {
    DDHDayOneViewController *next = [[DDHDayOneViewController alloc] initWithDay:day];
    [self.navigationController pushViewController:next animated:YES];
}

@end
