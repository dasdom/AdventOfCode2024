//  Created by Dominik Hauser on 08.12.24.
//  
//


#import "DDHCalculatorDay07.h"

@implementation DDHCalculatorDay07

- (NSArray<NSNumber *> *)answerFromLines:(NSArray<NSString *> *)lines {
    NSNumber *answerOne = [self answerOneFromLines:lines];
    NSNumber *answerTwo = [self answerTwoFromLines:lines];

    return @[answerOne, answerTwo];
}

- (NSNumber *)answerOneFromLines:(NSArray<NSString *> *)lines {

    NSInteger sum = 0;
    for (NSString *line in lines) {
        NSArray<NSString *> *structureComponents = [line componentsSeparatedByString:@": "];
        if ([structureComponents count] < 2) {
            continue;
        }
        NSInteger testResult = [structureComponents[0] integerValue];

        NSArray<NSString *> *calculationComponents = [structureComponents[1] componentsSeparatedByString:@" "];

        NSInteger numberOfCombinations = powl(2, [calculationComponents count] - 1);
        for (NSInteger i = 0; i<numberOfCombinations; i++) {
            NSInteger result = [calculationComponents[0] integerValue];
            for (NSInteger j = 1; j<[calculationComponents count]; j++) {

                NSInteger combination = j - 1;

                BOOL useTimes = i & (1 << combination);

                NSInteger component = [calculationComponents[j] integerValue];
                if (useTimes) {
                    result *= component;
                } else {
                    result += component;
                }

            }

            if (result == testResult) {
                NSLog(@"true line: %@", line);
                sum += testResult;
                break;
            }
        }
    }

    return @(sum);
}

- (NSNumber *)answerTwoFromLines:(NSArray<NSString *> *)lines {

    NSInteger sum = 0;
    NSInteger counter = 0;
    NSInteger numberOfLines = [lines count];
    for (NSString *line in lines) {
        NSLog(@"%ld/%ld (%ld)", counter, numberOfLines, counter * 100 / numberOfLines);
        counter++;
//        NSLog(@"line: %@", line);
        NSArray<NSString *> *structureComponents = [line componentsSeparatedByString:@": "];
        if ([structureComponents count] < 2) {
            continue;
        }
        NSInteger testResult = [structureComponents[0] integerValue];

        NSArray<NSString *> *calculationComponents = [structureComponents[1] componentsSeparatedByString:@" "];

        NSInteger numberOfOperators = [calculationComponents count] - 1;
//        for (NSInteger k = 0; k<numberOfOperators; k++) {
//
//            NSMutableArray<NSString *> *combinedCalculationComponents = [[NSMutableArray alloc] init];
//            for (NSInteger m = 0; m<[calculationComponents count]; m++) {
//                if (k == m) {
//                    NSString *combinedComponent = [NSString stringWithFormat:@"%@%@", calculationComponents[m], calculationComponents[m+1]];
//                    [combinedCalculationComponents addObject:combinedComponent];
//                    m++;
//                } else {
//                    [combinedCalculationComponents addObject:calculationComponents[m]];
//                }
//            }

//            NSLog(@"combinedCalculationComponents %@", combinedCalculationComponents);

        NSInteger numberOfCombinations = powl(2, numberOfOperators);
        BOOL resultFound = NO;
        for (NSInteger b = 0; b<numberOfCombinations; b++) {
            for (NSInteger i = 0; i<numberOfCombinations; i++) {
                NSInteger result = [calculationComponents[0] integerValue];
                for (NSInteger j = 1; j<[calculationComponents count]; j++) {
                    @autoreleasepool {

                        NSInteger combination = j - 1;

                        BOOL useTimes = i & (1 << combination);
                        BOOL useConcat = b & (1 << combination);

                        NSInteger component = [calculationComponents[j] integerValue];
                        if (useConcat) {
                            NSString *intermediateResult = [NSString stringWithFormat:@"%ld%@", result, calculationComponents[j]];
                            //                        NSLog(@"intermediateResult: %@", intermediateResult);
                            //                        NSLog(@"result: %ld", result);
                            result = [intermediateResult integerValue];
                        } else if (useTimes) {
                            //                        NSLog(@"%ld * %ld", result, component);
                            result *= component;
                            //                        NSLog(@"= %ld", result);
                        } else {
                            //                        NSLog(@"%ld + %ld", result, component);
                            result += component;
                            //                        NSLog(@"= %ld", result);
                        }
                    }

                }

                if (result == testResult) {
                    NSLog(@"concat true line: %@", line);
                    sum += testResult;
                    resultFound = YES;
                    break;
                }
            }

            if (resultFound) {
                break;
            }
        }
//        }
    }

    return @(sum);
}

@end
