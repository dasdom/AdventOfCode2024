//  Created by Dominik Hauser on 01.12.24.
//  
//


#import "DDHDayOneView.h"
#import "DDHDay.h"

@interface DDHDayOneView ()
@property (nonatomic, strong) UILabel *inputFileNameLabel;
@end

@implementation DDHDayOneView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        _inputFileNameLabel = [[UILabel alloc] init];

        UIButtonConfiguration *buttonConfig = [UIButtonConfiguration plainButtonConfiguration];
        buttonConfig.title = @"Run";
        _button = [UIButton buttonWithConfiguration:buttonConfig primaryAction:nil];

        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_inputFileNameLabel, _button]];
        stackView.translatesAutoresizingMaskIntoConstraints = NO;
        stackView.axis = UILayoutConstraintAxisVertical;

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
