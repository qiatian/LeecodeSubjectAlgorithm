//
//  IntegerInversion.m
//  GitTest
//
//  Created by Qianyinhulian on 2022/9/2.
//整数反转

#import "IntegerInversion.h"

@implementation IntegerInversion
- (NSInteger)reverse:(NSInteger)num{
    
    NSInteger result = 0;
    
    while (num!=0) {
        NSInteger temp = result*10 + num % 10 ;
        
        if (temp / 10 != result)
                        return 0;
        result = temp;
        num/=10;
        
        
    }
    
    return result;
}
@end
