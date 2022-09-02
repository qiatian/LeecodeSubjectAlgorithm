//
//  IntegerInversion.m
//  GitTest
//
//  Created by Qianyinhulian on 2022/9/2.
//

#import "IntegerInversion.h"

@implementation IntegerInversion
- (NSInteger)reverse:(NSInteger)num{
    
    NSInteger result = 0;
    
    while (num!=0) {
        NSInteger temp = num % 10;
        num/=10;
        
        result = temp * 10 + result;
    }
    
    return result;
}
@end
