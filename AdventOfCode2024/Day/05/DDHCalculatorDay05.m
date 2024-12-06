//  Created by Dominik Hauser on 06.12.24.
//  
//


#import "DDHCalculatorDay05.h"

@implementation DDHCalculatorDay05
- (NSArray<NSNumber *> *)answerFromLines:(NSArray<NSString *> *)lines {

    NSNumber *answerOne = [self answerForOneFromLines:lines];
    NSNumber *answerTwo = [self answerForTwoFromLines:lines];

    return @[answerOne, answerTwo];
}

- (NSNumber *)answerForOneFromLines:(NSArray<NSString *> *)lines {

    NSMutableArray<NSArray<NSString *> *> *rules = [[NSMutableArray alloc] init];

//    NSMutableArray<NSArray<NSString *> *> *updates = [[NSMutableArray alloc] init];

    NSInteger sum = 0;

    BOOL rulesBlock = YES;
    for (NSString *line in lines) {
        if ([line isEqualToString:@""]) {
            rulesBlock = NO;
        }

        if (rulesBlock) {
            NSArray<NSString *> *ruleComponents = [line componentsSeparatedByString:@"|"];
            if ([ruleComponents count] == 2) {
                [rules addObject:ruleComponents];
            }
        } else {
            NSArray<NSString *> *updatePages = [line componentsSeparatedByString:@","];

//            NSLog(@"line: %@", line);
            if ([line isEqualToString:@""]) {
                continue;
            }

            BOOL allRulesFulfilled = YES;
            for (NSArray<NSString *> *rule in rules) {
                NSString *formerPageString = rule.firstObject;
                NSString *laterPageString = rule.lastObject;

                NSUInteger indexOfFormerPage = [updatePages indexOfObjectPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    return [obj isEqualToString:formerPageString];
                }];
                NSUInteger indexOfLaterPage = [updatePages indexOfObjectPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    return [obj isEqualToString:laterPageString];
                }];

                if (indexOfFormerPage != NSNotFound &&
                    indexOfLaterPage != NSNotFound) {
//                    NSLog(@"rule: %@", rule);
//                    NSLog(@"%ld, %ld", indexOfFormerPage, indexOfLaterPage);
                    if (indexOfFormerPage > indexOfLaterPage) {
                        allRulesFulfilled = NO;
                        break;
                    }
                } else {
                    continue;
                }
            }

            if (allRulesFulfilled) {
//                [updates addObject:updatePages];
                NSUInteger middleIndex = [updatePages count]/2;
                sum += [updatePages[middleIndex] integerValue];
            }
        }
    }

    return @(sum);
}

- (NSNumber *)answerForTwoFromLines:(NSArray<NSString *> *)lines {

    NSMutableArray<NSArray<NSString *> *> *rules = [[NSMutableArray alloc] init];

    NSInteger sum = 0;

    BOOL rulesBlock = YES;
    for (NSString *line in lines) {
        if ([line isEqualToString:@""]) {
            rulesBlock = NO;
        }

        if (rulesBlock) {
            NSArray<NSString *> *ruleComponents = [line componentsSeparatedByString:@"|"];
            if ([ruleComponents count] == 2) {
                [rules addObject:ruleComponents];
            }
        } else {
            NSMutableArray<NSString *> *updatePages = [[line componentsSeparatedByString:@","] mutableCopy];

            //            NSLog(@"line: %@", line);
            if ([line isEqualToString:@""]) {
                continue;
            }

            BOOL allRulesFulfilled = YES;
            for (NSArray<NSString *> *rule in rules) {
                NSString *formerPageString = rule.firstObject;
                NSString *laterPageString = rule.lastObject;

                NSUInteger indexOfFormerPage = [updatePages indexOfObjectPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    return [obj isEqualToString:formerPageString];
                }];
                NSUInteger indexOfLaterPage = [updatePages indexOfObjectPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    return [obj isEqualToString:laterPageString];
                }];

                if (indexOfFormerPage != NSNotFound &&
                    indexOfLaterPage != NSNotFound) {
                    //                    NSLog(@"rule: %@", rule);
                    //                    NSLog(@"%ld, %ld", indexOfFormerPage, indexOfLaterPage);
                    if (indexOfFormerPage > indexOfLaterPage) {
                        allRulesFulfilled = NO;
                        break;
                    }
                } else {
                    continue;
                }
            }

            if (NO == allRulesFulfilled) {
                BOOL updateIndex = NO;
                for (NSUInteger i = 0; i<[updatePages count]; i += updateIndex ? 1 : 0) {
                    updateIndex = YES;
                    for (NSArray<NSString *> *rule in rules) {
                        NSString *formerPageString = rule.firstObject;
                        NSString *laterPageString = rule.lastObject;
                        NSString *currentPage = updatePages[i];

                        if (NO == [rule containsObject:currentPage]) {
                            continue;
                        }

                        NSUInteger indexOfFormerPage = [updatePages indexOfObjectPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            return [obj isEqualToString:formerPageString];
                        }];
                        NSUInteger indexOfLaterPage = [updatePages indexOfObjectPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            return [obj isEqualToString:laterPageString];
                        }];

                        if (indexOfFormerPage != NSNotFound &&
                            indexOfLaterPage != NSNotFound) {
                            //                    NSLog(@"rule: %@", rule);
                            //                    NSLog(@"%ld, %ld", indexOfFormerPage, indexOfLaterPage);
                            if (indexOfFormerPage > indexOfLaterPage) {
                                NSString *formerPage = updatePages[indexOfFormerPage];
                                updatePages[indexOfFormerPage] = updatePages[indexOfLaterPage];
                                updatePages[indexOfLaterPage] = formerPage;
                                updateIndex = NO;
                            }
                        } else {
                            continue;
                        }
                    }
                }

                NSUInteger middleIndex = [updatePages count]/2;
                sum += [updatePages[middleIndex] integerValue];
            }
        }
    }

    return @(sum);
}


@end
