//  Created by Dominik Hauser on 01.12.24.
//  
//


#import "DDHDayViewController.h"
#import "DDHDay.h"
#import "DDHDayView.h"
#import "DDHCalculatorFactory.h"

@interface DDHDayViewController ()
@property (nonatomic, strong) DDHDay *day;
@property (nonatomic, weak) DDHDayView *contentView;
@end

@implementation DDHDayViewController

- (instancetype)initWithDay:(DDHDay *)day {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _day = day;
    }
    return self;
}

- (DDHDayView *)contentView {
    return (DDHDayView *)self.view;
}

- (void)loadView {
    self.view = [[DDHDayView alloc] init];
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
    
    id<DDHCalculatorProtocol> calculator = [DDHCalculatorFactory calculatorForDayNumber:self.day.dayNumber];

    NSArray<NSString *> *results = [calculator answerFromLines:lines];

    self.contentView.resultLabel.text = [NSString stringWithFormat:@"Answer 1: %@\nAnswer 2: %@", results.firstObject, results.lastObject];
}

@end
