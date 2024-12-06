//  Created by Dominik Hauser on 02.12.24.
//  
//


#import "DDHCalculatorDayOne.h"

@implementation DDHCalculatorDayOne
- (NSArray<NSNumber *> *)answerFromLines:(NSArray<NSString *> *)lines {
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

    return @[@(sumOne), @(sumTwo)];
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
