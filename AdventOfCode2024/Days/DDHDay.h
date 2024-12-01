//  Created by Dominik Hauser on 01.12.24.
//  
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDHDay : NSObject
@property (assign) NSInteger dayNumber;
@property (nonatomic, strong) NSString *inputDataFileName;
- (instancetype)initWithDayNumber:(NSInteger)dayNumber inputDataFileName:(NSString *)inputDataFileName;
@end

NS_ASSUME_NONNULL_END
