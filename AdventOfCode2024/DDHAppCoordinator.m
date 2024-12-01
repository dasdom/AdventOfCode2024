//  Created by Dominik Hauser on 01.12.24.
//  
//


#import "DDHAppCoordinator.h"
#import <UIKit/UIKit.h>
#import "DDHDaysViewController.h"

@interface DDHAppCoordinator ()
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
    DDHDaysViewController *next = [[DDHDaysViewController alloc] init];
    [self.navigationController pushViewController:next animated:NO];
    return self.navigationController;
}

@end
