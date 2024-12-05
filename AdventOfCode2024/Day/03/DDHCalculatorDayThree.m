//  Created by Dominik Hauser on 04.12.24.
//  
//


#import "DDHCalculatorDayThree.h"

@interface DDHCalculatorDayThree ()
@property NSNumberFormatter *numberFormatter;
@end

@implementation DDHCalculatorDayThree
- (NSArray<NSString *> *)answerFromLines:(NSArray<NSString *> *)lines {
    NSInteger sumWithIgnoringDisables = 0;
    NSInteger sum = 0;
    _numberFormatter = [[NSNumberFormatter alloc] init];
    _numberFormatter.maximumFractionDigits = 0;

    BOOL enabled = YES;
    for (NSString *line in lines) {
//        sumWithIgnoringDisables += [self sumForString:line countingAll:YES];
//        sum += [self sumForString:line countingAll:NO];

        NSScanner *scanner = [[NSScanner alloc] initWithString:line];
        NSString *instructionString;
        [scanner scanUpToString:@"mul(" intoString:&instructionString];

        enabled = [self enableFromString:instructionString currentValue:enabled];

        while ([scanner scanString:@"mul(" intoString:NULL]) {

            NSInteger firstFactor;
            NSInteger secondFactor;
            if ([scanner scanInteger:&firstFactor] &&
                [scanner scanString:@"," intoString:NULL] &&
                [scanner scanInteger:&secondFactor] &&
                [scanner scanString:@")" intoString:NULL]) {
                if (enabled) {
                    sum += firstFactor * secondFactor;
                }
                sumWithIgnoringDisables += firstFactor * secondFactor;
            }

            NSString *instructionString;
            [scanner scanUpToString:@"mul(" intoString:&instructionString];

            enabled = [self enableFromString:instructionString currentValue:enabled];
        }
    }
    return @[[NSString stringWithFormat:@"%ld", sumWithIgnoringDisables],
             [NSString stringWithFormat:@"%ld", sum]];
}

- (BOOL)enableFromString:(NSString *)string currentValue:(BOOL)currentValue {
    if ([string length] > 0) {
        BOOL enabled;
        NSLog(@"");
        NSRange rangeOfDont = [string rangeOfString:@"don't()" options:NSBackwardsSearch];
        NSRange rangeOfDo = [string rangeOfString:@"do()" options:NSBackwardsSearch];
        if (rangeOfDo.location != NSNotFound && rangeOfDont.location != NSNotFound) {
            if (rangeOfDo.location > rangeOfDont.location) {
                enabled = YES;
            } else {
                enabled = NO;
            }
        } else if ([string containsString:@"don't()"]) {
            enabled = NO;
        } else if ([string containsString:@"do()"]) {
            enabled = YES;
        } else {
            enabled = currentValue;
        }
        return enabled;
    } else {
        return currentValue;
    }
}
@end
