//  Created by Dominik Hauser on 02.12.24.
//  
//


#import "DDHCalculatorDayTwo.h"

typedef NS_ENUM(NSUInteger, DDHReportType) {
    DDHReportTypeUnknown,
    DDHReportTypeIncreasing,
    DDHReportTypeDecreasing,
//    DDHReportTypeDampedIncreasing,
//    DDHReportTypeDampedDecreasing,
//    DDHReportTypeDampedUnknown,
    DDHReportTypeUnsafe,
};

@implementation DDHCalculatorDayTwo
- (NSArray<NSNumber *> *)answerFromLines:(NSArray<NSString *> *)lines {

    NSInteger numberOfSafeReportsWithoutDamping = 0;
    NSInteger numberOfSafeReportsWithDamping = 0;
    for (NSString *line in lines) {
        if ([line isEqualToString:@""]) {
            continue;
        }
        NSArray<NSString *> *components = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

//        NSLog(@"components: %@", components);
        DDHReportType reportTypeWithoutDamping = [self reportTypeForReport:components withDamping:NO];
        DDHReportType reportTypeWithDamping = [self reportTypeForReport:components withDamping:YES];

//        NSLog(@"reportType: %ld", reportType);
        if (reportTypeWithoutDamping != DDHReportTypeUnsafe && reportTypeWithoutDamping != DDHReportTypeUnknown) {
            numberOfSafeReportsWithoutDamping += 1;
        }

        if (reportTypeWithDamping != DDHReportTypeUnsafe && reportTypeWithDamping != DDHReportTypeUnknown) {
            numberOfSafeReportsWithDamping += 1;
        }

//        NSLog(@"numberOfSafeReports: %ld", numberOfSafeReports);
    }

    return @[@(numberOfSafeReportsWithoutDamping), @(numberOfSafeReportsWithDamping)];
}

- (DDHReportType)reportTypeForReport:(NSArray<NSString *> *)report withDamping:(BOOL)withDamping {
//    NSLog(@"with damping: %@", withDamping ? @"YES" : @"NO");
    DDHReportType reportType = DDHReportTypeUnknown;
    NSInteger previousInput = [report.firstObject integerValue];
    for (NSInteger i = 1; i < [report count]; i++) {
        NSInteger currentInput = [report[i] integerValue];

        NSInteger step = currentInput - previousInput;

        //            NSLog(@"step: %ld", step);
        if (step == 0 || labs(step) > 3) {
            reportType = DDHReportTypeUnsafe;
            if (NO == withDamping) {
                break;
            }
        }

        switch (reportType) {
            case DDHReportTypeUnknown:
                reportType = (step < 0) ? DDHReportTypeDecreasing : DDHReportTypeIncreasing;
                break;
            case DDHReportTypeIncreasing:
                if (step < 0) {
                    reportType = DDHReportTypeUnsafe;
                }
                break;
            case DDHReportTypeDecreasing:
                if (step > 0) {
                    reportType = DDHReportTypeUnsafe;
                }
                break;
            default:
                break;
        }

        if (withDamping) {
            NSInteger indexToRemove = 0;
            while (reportType == DDHReportTypeUnsafe) {
                if (indexToRemove > [report count] - 1) {
                    break;
                }
//                NSLog(@"index to remove: %ld", indexToRemove);
                NSMutableArray *mutableReport = [report mutableCopy];
                [mutableReport removeObjectAtIndex:indexToRemove];
                reportType = [self reportTypeForReport:mutableReport withDamping:NO];
                indexToRemove += 1;
            }
        } else if (reportType == DDHReportTypeUnsafe) {
            break;
        }
        previousInput = currentInput;
    }
//    NSLog(@"report: %@", report);
//    NSLog(@"reportType: %ld", reportType);
    return reportType;
}

@end
