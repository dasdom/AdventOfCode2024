//  Created by Dominik Hauser on 05.12.24.
//  
//


#import "DDHCalculatorDay04.h"
#import <UIKit/UIKit.h>

@implementation DDHCalculatorDay04
- (NSArray<NSString *> *)answerFromLines:(NSArray<NSString *> *)lines {

    NSString *answerOne = [self answerOneFromLines:lines];
    NSString *answerTwo = [self answerTwoFromLines:lines];
    return @[answerOne, answerTwo];
}

- (NSString *)answerOneFromLines:(NSArray<NSString *> *)lines {
    NSMutableArray<NSArray<NSString *> *> *grid = [[NSMutableArray alloc] init];

    NSMutableArray<NSValue *> *positionsOfX = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i<[lines count]; i++) {
        NSMutableArray<NSString *> *xArray = [[NSMutableArray alloc] init];
        NSString *line = lines[i];
        if ([line isEqualToString:@""]) {
            continue;
        }
        for (NSInteger j = 0; j<line.length; j++) {
            NSRange characterRange = NSMakeRange(j, 1);
            NSString *characterString = [line substringWithRange:characterRange];
            if ([characterString isEqualToString:@"X"]) {
                CGPoint positionPoint = CGPointMake(j, i);
                [positionsOfX addObject:[NSValue valueWithCGPoint:positionPoint]];
            }
            [xArray addObject:characterString];
        }
        [grid addObject:xArray];
    }

    NSInteger numberOfXMAS = 0;
    NSArray<NSString *> *searchCharacters = @[@"M", @"A", @"S"];
    for (NSValue *xPositionValue in positionsOfX) {
        CGPoint positionOfX = [xPositionValue CGPointValue];

        // up
        for (NSInteger i = 0; i<[searchCharacters count]; i++) {
            NSString *searchCharacter = searchCharacters[i];

            NSInteger nextX = positionOfX.x;
            NSInteger nextY = positionOfX.y - i - 1;
            if (nextY < 0) {
                break;
            } else if (NO == [grid[nextY][nextX] isEqualToString:searchCharacter]) {
                break;
            } else if ([searchCharacter isEqualToString:@"S"]) {
                numberOfXMAS += 1;
            }
        }

        // up left
        for (NSInteger i = 0; i<[searchCharacters count]; i++) {
            NSString *searchCharacter = searchCharacters[i];

            NSInteger nextX = positionOfX.x - 1 - i;
            NSInteger nextY = positionOfX.y - i - 1;
            if (nextY < 0 || nextX < 0) {
                break;
            } else if (NO == [grid[nextY][nextX] isEqualToString:searchCharacter]) {
                break;
            } else if ([searchCharacter isEqualToString:@"S"]) {
                numberOfXMAS += 1;
            }
        }

        // left
        for (NSInteger i = 0; i<[searchCharacters count]; i++) {
            NSString *searchCharacter = searchCharacters[i];

            NSInteger nextX = positionOfX.x - 1 - i;
            NSInteger nextY = positionOfX.y;
            if (nextX < 0) {
                break;
            } else if (NO == [grid[nextY][nextX] isEqualToString:searchCharacter]) {
                break;
            } else if ([searchCharacter isEqualToString:@"S"]) {
                numberOfXMAS += 1;
            }
        }

        // left down
        for (NSInteger i = 0; i<[searchCharacters count]; i++) {
            NSString *searchCharacter = searchCharacters[i];

            NSInteger nextX = positionOfX.x - 1 - i;
            NSInteger nextY = positionOfX.y + i + 1;
            if (nextX < 0 || [grid count] <= nextY) {
                break;
            } else if (NO == [grid[nextY][nextX] isEqualToString:searchCharacter]) {
                break;
            } else if ([searchCharacter isEqualToString:@"S"]) {
                numberOfXMAS += 1;
            }
        }

        // down
        for (NSInteger i = 0; i<[searchCharacters count]; i++) {
            NSString *searchCharacter = searchCharacters[i];

            NSInteger nextX = positionOfX.x;
            NSInteger nextY = positionOfX.y + i + 1;
            if ([grid count] <= nextY) {
                break;
            } else if (NO == [grid[nextY][nextX] isEqualToString:searchCharacter]) {
                break;
            } else if ([searchCharacter isEqualToString:@"S"]) {
                numberOfXMAS += 1;
            }
        }

        // down right
        for (NSInteger i = 0; i<[searchCharacters count]; i++) {
            NSString *searchCharacter = searchCharacters[i];

            NSInteger nextX = positionOfX.x + 1 + i;
            NSInteger nextY = positionOfX.y + i + 1;
            if ([grid count] <= nextY || [grid[nextY] count] <= nextX) {
                break;
            } else if (NO == [grid[nextY][nextX] isEqualToString:searchCharacter]) {
                break;
            } else if ([searchCharacter isEqualToString:@"S"]) {
                numberOfXMAS += 1;
            }
        }

        // right
        for (NSInteger i = 0; i<[searchCharacters count]; i++) {
            NSString *searchCharacter = searchCharacters[i];

            NSInteger nextX = positionOfX.x + 1 + i;
            NSInteger nextY = positionOfX.y;
            if ([grid[nextY] count] <= nextX) {
                break;
            } else if (NO == [grid[nextY][nextX] isEqualToString:searchCharacter]) {
                break;
            } else if ([searchCharacter isEqualToString:@"S"]) {
                numberOfXMAS += 1;
            }
        }

        // right up
        for (NSInteger i = 0; i<[searchCharacters count]; i++) {
            NSString *searchCharacter = searchCharacters[i];

            NSInteger nextX = positionOfX.x + 1 + i;
            NSInteger nextY = positionOfX.y - i - 1;
            if (nextY < 0 || [grid[nextY] count] <= nextX) {
                break;
            } else if (NO == [grid[nextY][nextX] isEqualToString:searchCharacter]) {
                break;
            } else if ([searchCharacter isEqualToString:@"S"]) {
                numberOfXMAS += 1;
            }
        }
    }
    return [NSString stringWithFormat:@"%ld", numberOfXMAS];
}

- (NSString *)answerTwoFromLines:(NSArray<NSString *> *)lines {
    NSMutableArray<NSArray<NSString *> *> *grid = [[NSMutableArray alloc] init];

    NSMutableArray<NSValue *> *positionsOfA = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i<[lines count]; i++) {
        NSMutableArray<NSString *> *xArray = [[NSMutableArray alloc] init];
        NSString *line = lines[i];
        if ([line isEqualToString:@""]) {
            continue;
        }
        for (NSInteger j = 0; j<line.length; j++) {
            NSRange characterRange = NSMakeRange(j, 1);
            NSString *characterString = [line substringWithRange:characterRange];
            if ([characterString isEqualToString:@"A"]) {
                CGPoint positionPoint = CGPointMake(j, i);
                [positionsOfA addObject:[NSValue valueWithCGPoint:positionPoint]];
            }
            [xArray addObject:characterString];
        }
        [grid addObject:xArray];
    }

    NSInteger numberOfXMAS = 0;
    for (NSValue *aPositionValue in positionsOfA) {
        CGPoint positionOfA = [aPositionValue CGPointValue];

        NSInteger top = positionOfA.y - 1;
        NSInteger left = positionOfA.x - 1;
        NSInteger bottom = positionOfA.y + 1;
        NSInteger right = positionOfA.x + 1;

        if (top < 0 || left < 0 || bottom >= [grid count] || right >= [grid[0] count]) {
            continue;
        }

        if (([grid[top][left] isEqualToString:@"M"] && [grid[bottom][right] isEqualToString:@"S"]) ||
            ([grid[top][left] isEqualToString:@"S"] && [grid[bottom][right] isEqualToString:@"M"])) {
            if (([grid[bottom][left] isEqualToString:@"M"] && [grid[top][right] isEqualToString:@"S"]) ||
                ([grid[bottom][left] isEqualToString:@"S"] && [grid[top][right] isEqualToString:@"M"])) {
                numberOfXMAS += 1;
            } else {
                continue;
            }
        }
    }
    return [NSString stringWithFormat:@"%ld", numberOfXMAS];
}

@end
