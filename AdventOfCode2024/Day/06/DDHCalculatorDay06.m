//  Created by Dominik Hauser on 07.12.24.
//  
//


#import "DDHCalculatorDay06.h"
#import <UIKit/UIKit.h>
#import "DDHGuardDirection.h"
#import "DDHGuardState.h"

NSString * const DDHGuardDirectionMapRepresentation[] = {
    [DDHGuardDirectionUp] = @"^",
    [DDHGuardDirectionLeft] = @"<",
    [DDHGuardDirectionDown] = @"v",
    [DDHGuardDirectionRight] = @">"
};

@implementation DDHCalculatorDay06

- (NSArray<NSNumber *> *)answerFromLines:(NSArray<NSString *> *)lines {

    NSNumber *answerOne = [self answerOneFromLines:lines];
    NSNumber *answerTwo = [self answerTwoFromLines:lines];

    return @[answerOne, answerTwo];
}

- (NSNumber *)answerOneFromLines:(NSArray<NSString *> *)lines {

    NSMutableArray<NSMutableArray<NSString *> *> *map = [self mapFromLines:lines];

    return [self answerOneFromMap:map];
}

- (NSNumber *)answerOneFromMap:(NSMutableArray<NSMutableArray<NSString *> *> *)map {

    CGPoint guardPosition = CGPointZero;
    DDHGuardDirection guardDirection = DDHGuardDirectionUp;


    for (NSInteger i = 0; i<[map count]; i++) {
        for (NSInteger j = 0; j<[map[0] count]; j++) {
            NSString *characterString = map[i][j];
            if ([characterString isEqualToString:DDHGuardDirectionMapRepresentation[DDHGuardDirectionUp]]) {
                guardDirection = DDHGuardDirectionUp;
                guardPosition = CGPointMake(j, i);
            } else if ([characterString isEqualToString:DDHGuardDirectionMapRepresentation[DDHGuardDirectionLeft]]) {
                guardDirection = DDHGuardDirectionLeft;
                guardPosition = CGPointMake(j, i);
            } else if ([characterString isEqualToString:DDHGuardDirectionMapRepresentation[DDHGuardDirectionDown]]) {
                guardDirection = DDHGuardDirectionDown;
                guardPosition = CGPointMake(j, i);
            } else if ([characterString isEqualToString:DDHGuardDirectionMapRepresentation[DDHGuardDirectionRight]]) {
                guardDirection = DDHGuardDirectionRight;
                guardPosition = CGPointMake(j, i);
            }
        }
    }

    NSMutableArray<DDHGuardState *> *distinctPositions = [[NSMutableArray alloc] init];

    CGPoint nextPosition = guardPosition;
    NSInteger sum = 0;
    while ([self isNextPosition:nextPosition onMap:map]) {
        NSString *nextElement = [self elementAtPosition:nextPosition onMap:map];

        if ([nextElement isEqualToString:@"#"]) {
            switch (guardDirection) {
                case DDHGuardDirectionUp:
                    guardDirection = DDHGuardDirectionRight;
                    break;
                case DDHGuardDirectionLeft:
                    guardDirection = DDHGuardDirectionUp;
                    break;
                case DDHGuardDirectionDown:
                    guardDirection = DDHGuardDirectionLeft;
                    break;
                case DDHGuardDirectionRight:
                    guardDirection = DDHGuardDirectionDown;
                    break;
                default:
                    break;
            }
        } else {
            DDHGuardState *guardState = [[DDHGuardState alloc] initWithPosition:nextPosition direction:guardDirection];
            if ([distinctPositions containsObject:guardState]) {
                return nil;
            }
//            NSLog(@"guardPosition: %@", [NSValue valueWithCGPoint:guardPosition]);
            NSUInteger index = [distinctPositions indexOfObjectPassingTest:^BOOL(DDHGuardState * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                return [obj samePositionAs:guardState];
            }];
            if (index == NSNotFound) {
                sum += 1;
                [distinctPositions addObject:guardState];
            }
            guardPosition = nextPosition;
        }

        nextPosition = [self nextPositionForPosition:guardPosition direction:guardDirection];
    }

    return @(sum);
}

- (NSNumber *)answerTwoFromLines:(NSArray<NSString *> *)lines {

    NSMutableArray<NSMutableArray<NSString *> *> *map = [self mapFromLines:lines];

    CGPoint guardPosition = CGPointZero;
    DDHGuardDirection guardDirection = DDHGuardDirectionUp;

    for (NSInteger i = 0; i<[map count]; i++) {
        for (NSInteger j = 0; j<[map[0] count]; j++) {
            NSString *characterString = map[i][j];
            if ([characterString isEqualToString:DDHGuardDirectionMapRepresentation[DDHGuardDirectionUp]]) {
                guardDirection = DDHGuardDirectionUp;
                guardPosition = CGPointMake(j, i);
            } else if ([characterString isEqualToString:DDHGuardDirectionMapRepresentation[DDHGuardDirectionLeft]]) {
                guardDirection = DDHGuardDirectionLeft;
                guardPosition = CGPointMake(j, i);
            } else if ([characterString isEqualToString:DDHGuardDirectionMapRepresentation[DDHGuardDirectionDown]]) {
                guardDirection = DDHGuardDirectionDown;
                guardPosition = CGPointMake(j, i);
            } else if ([characterString isEqualToString:DDHGuardDirectionMapRepresentation[DDHGuardDirectionRight]]) {
                guardDirection = DDHGuardDirectionRight;
                guardPosition = CGPointMake(j, i);
            }
        }
    }

    NSInteger sum = 0;
    for (NSInteger i = 0; i<[map count]; i++) {
        for (NSInteger j = 0; j<[map[0] count]; j++) {
            if ([map[i][j] isEqualToString:@"#"]) {
                continue;
            }
            if (guardPosition.x == j && guardPosition.y == i) {
                continue;
            }

            NSLog(@"Testing position: %ld, %ld", j, i);
            map[i][j] = @"#";

            NSNumber *numberOfDistinctPositions = [self answerOneFromMap:map];
            if (nil == numberOfDistinctPositions) {
                sum += 1;
                NSLog(@"Loops found: %ld", sum);
            }

            map[i][j] = @".";
        }
    }

    return @(sum);
}

- (NSMutableArray<NSMutableArray<NSString *> *> *)mapFromLines:(NSArray<NSString *> *)lines {
    NSMutableArray<NSMutableArray<NSString *> *> *map = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i<[lines count]; i++) {
        NSMutableArray<NSString *> *xArray = [[NSMutableArray alloc] init];
        NSString *line = lines[i];
        if ([line isEqualToString:@""]) {
            continue;
        }
        for (NSInteger j = 0; j<line.length; j++) {
            NSRange characterRange = NSMakeRange(j, 1);
            NSString *characterString = [line substringWithRange:characterRange];
            [xArray addObject:characterString];
        }
        [map addObject:xArray];
    }
    return map;
}

- (BOOL)isNextPosition:(CGPoint)guardPosition onMap:(NSArray<NSArray<NSString *> *> *)map {
    if (guardPosition.x < 0 ||
        guardPosition.y < 0 ||
        guardPosition.x >= [map[0] count] ||
        guardPosition.y >= [map count]) {
        return NO;
    } else {
        return YES;
    }
}

- (NSString *)elementAtPosition:(CGPoint)position onMap:(NSArray<NSArray<NSString *> *> *)map {
    NSInteger nextX = position.x;
    NSInteger nextY = position.y;

    if ([self isNextPosition:position onMap:map]) {
        return map[nextY][nextX];
    } else {
        return nil;
    }
}

- (CGPoint)nextPositionForPosition:(CGPoint)position direction:(DDHGuardDirection)direction {
    CGPoint nextPosition = position;
    switch (direction) {
        case DDHGuardDirectionUp:
            nextPosition = CGPointMake(position.x, position.y - 1);
            break;
        case DDHGuardDirectionLeft:
            nextPosition = CGPointMake(position.x - 1, position.y);
            break;
        case DDHGuardDirectionDown:
            nextPosition = CGPointMake(position.x, position.y + 1);
            break;
        case DDHGuardDirectionRight:
            nextPosition = CGPointMake(position.x + 1, position.y);
            break;
    }
    return nextPosition;
}

@end
