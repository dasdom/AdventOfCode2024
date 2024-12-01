//  Created by Dominik Hauser on 01.12.24.
//  
//


#import "DDHDayOneViewController.h"
#import "DDHDay.h"
#import "DDHDayOneView.h"

@interface DDHDayOneViewController ()
@property (nonatomic, strong) DDHDay *day;
@property (nonatomic, weak) DDHDayOneView *contentView;
@end

@implementation DDHDayOneViewController

- (instancetype)initWithDay:(DDHDay *)day {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _day = day;
    }
    return self;
}

- (DDHDayOneView *)contentView {
    return (DDHDayOneView *)self.view;
}

- (void)loadView {
    self.view = [[DDHDayOneView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.contentView updateWithDay:self.day];
}

@end
