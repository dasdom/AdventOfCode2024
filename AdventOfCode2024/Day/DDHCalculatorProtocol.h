//  Created by Dominik Hauser on 02.12.24.
//  
//

#ifndef DDHCalculatorProtocol_h
#define DDHCalculatorProtocol_h

@class NSArray;
@class NSString;

@protocol DDHCalculatorProtocol <NSObject>
- (NSArray<NSString *> *)answerFromLines:(NSArray<NSString *> *)lines;
@end

#endif /* DDHCalculatorProtocol_h */
