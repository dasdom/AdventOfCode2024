//  Created by Dominik Hauser on 01.12.24.
//  
//


#import "DDHDayView.h"
#import "DDHDay.h"

@interface DDHDayView ()
@property (nonatomic, strong) UILabel *inputFileNameLabel;
@end

@implementation DDHDayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        _inputFileNameLabel = [[UILabel alloc] init];
        _inputFileNameLabel.textAlignment = NSTextAlignmentCenter;

        UIButtonConfiguration *buttonConfig = [UIButtonConfiguration plainButtonConfiguration];
        buttonConfig.title = @"Run";
        _button = [UIButton buttonWithConfiguration:buttonConfig primaryAction:nil];

        _resultLabel = [[UILabel alloc] init];
        _resultLabel.textAlignment = NSTextAlignmentCenter;
        _resultLabel.numberOfLines = 0;

        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_inputFileNameLabel, _button, _resultLabel]];
        stackView.translatesAutoresizingMaskIntoConstraints = NO;
        stackView.axis = UILayoutConstraintAxisVertical;
        stackView.spacing = 10;

        self.backgroundColor = [UIColor systemBackgroundColor];

        [self addSubview:stackView];

        [NSLayoutConstraint activateConstraints:@[
            [stackView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor],
            [stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        ]];
    }
    return self;
}

- (void)updateWithDay:(DDHDay *)day {
    self.inputFileNameLabel.text = day.inputDataFileName;
}
@end
