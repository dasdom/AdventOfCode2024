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

    [self.contentView.button addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView updateWithDay:self.day];
}

// MARK: - Actions
- (void)run:(UIButton *)sender {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:self.day.inputDataFileName withExtension:@"txt"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:fileURL];
    NSString *fileContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray<NSString *> *lines = [fileContent componentsSeparatedByString:@"\n"];

    NSMutableArray<NSNumber *> *firstList = [[NSMutableArray alloc] initWithCapacity:lines.count];
    NSMutableArray<NSNumber *> *secondList = [[NSMutableArray alloc] initWithCapacity:lines.count];

    for (NSString *line in lines) {
        if ([line isEqualToString:@""]) {
            continue;
        }
        NSArray<NSString *> *lineComponents = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

        NSInteger firstNumber = lineComponents.firstObject.integerValue;
        [firstList addObject:@(firstNumber)];

        NSInteger secondNumber = lineComponents.lastObject.integerValue;
        [secondList addObject:@(secondNumber)];
    }

    [firstList sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];

    [secondList sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];

    NSInteger sumOne = [self answerOneFromListOne:[firstList copy] listTwo:[secondList copy]];
    NSInteger sumTwo = [self answerTwoFromListOne:[firstList copy] listTwo:[secondList copy]];

    self.contentView.resultLabel.text = [NSString stringWithFormat:@"Answer 1: %ld\nAnswer 2: %ld", sumOne, sumTwo];
}

- (NSInteger)answerOneFromListOne:(NSArray<NSString *> *)listOne listTwo:(NSArray<NSString *> *)listTwo {
    NSInteger sum = 0;
    for (NSInteger i = 0; i<listOne.count; i++) {
        NSInteger firstInteger = [listOne[i] integerValue];
        NSInteger secondInteger = [listTwo[i] integerValue];

        sum += labs(firstInteger - secondInteger);
    }
    return sum;
}

- (NSInteger)answerTwoFromListOne:(NSArray<NSString *> *)listOne listTwo:(NSArray<NSString *> *)listTwo {
    NSInteger sum = 0;
    for (NSNumber *numberOne in listOne) {
        NSInteger appearancesCount = 0;
        for (NSNumber *numberTwo in listTwo) {
            if ([numberTwo isEqualToNumber:numberOne]) {
                appearancesCount += 1;
            }
        }
        sum += [numberOne integerValue] * appearancesCount;
    }
    return sum;
}

@end
