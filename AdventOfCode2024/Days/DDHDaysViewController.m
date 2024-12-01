//  Created by Dominik Hauser on 01.12.24.
//
//


#import "DDHDaysViewController.h"
#import "DDHDaysView.h"
#import "DDHDayCell.h"
#import "DDHDay.h"

@interface DDHDaysViewController ()
@property (nonatomic, weak) DDHDaysView *contentView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UITableViewDiffableDataSource *dataSource;
@property (nonatomic, strong) NSArray<DDHDay *> *days;
@end

@implementation DDHDaysViewController

- (void)loadView {
    self.view = [[DDHDaysView alloc] init];
}

- (DDHDaysView *)contentView {
    return (DDHDaysView *)self.view;
}

- (UITableView *)tableView {
    return self.contentView.tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Advent Of Code 2024";

    [self.tableView registerClass:[DDHDayCell class] forCellReuseIdentifier:[DDHDayCell identifier]];

    _dataSource = [[UITableViewDiffableDataSource alloc] initWithTableView:self.tableView cellProvider:^UITableViewCell * _Nullable(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, NSNumber *  _Nonnull itemIdentifier) {
        DDHDayCell *cell = [tableView dequeueReusableCellWithIdentifier:[DDHDayCell identifier]];
        NSUInteger index = [self.days indexOfObjectPassingTest:^BOOL(DDHDay * _Nonnull day, NSUInteger idx, BOOL * _Nonnull stop) {
            return day.dayNumber = [itemIdentifier integerValue];
        }];
        DDHDay *day = self.days[index];
        [cell updateWithDay:day];
        return cell;
    }];

    [self updateWithDays:@[
        [[DDHDay alloc] initWithDayNumber:1 inputDataFileName:@"day_1"],
    ]];
}

- (void)updateWithDays:(NSArray<DDHDay *> *)days {
    self.days = days;

    NSMutableArray<NSNumber *> *itemIdentifiers = [[NSMutableArray alloc] initWithCapacity:[days count]];
    for (DDHDay *day in days) {
        [itemIdentifiers addObject:@(day.dayNumber)];
    }

    NSDiffableDataSourceSnapshot *snapshot = [[NSDiffableDataSourceSnapshot alloc] init];
    [snapshot appendSectionsWithIdentifiers:@[@"Main"]];
    [snapshot appendItemsWithIdentifiers:itemIdentifiers];
    [self.dataSource applySnapshot:snapshot animatingDifferences:YES];
}

@end
