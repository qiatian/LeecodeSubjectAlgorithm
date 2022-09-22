//
//  Algorithm.h
//  GitTest
//
//  Created by Qianyinhulian on 2022/9/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Algorithm : NSObject
//转换字符串为整数
- (NSInteger)changeStrToInteger:(NSString *)str;
//回文数
- (BOOL)isPalindrome:(NSInteger)x;
//正则表达式匹配
- (BOOL)isMatch:(NSString *)s str2:(NSString *)p;
//盛最多水的容器
- (NSInteger)maxArea:(NSArray *)height size:(NSInteger)heightSize;
//整数转罗马数字
- (NSString *)intToRoman:(NSInteger)num;
//罗马数字转整数
- (NSInteger)romanToInt:(NSString *)str;
//最长公共前缀
- (NSString *)longestCommonPrefix:(NSArray *)arr;
- (NSString *)smartLongestCommonPrefix:(NSArray *)arr;
//三数之和
- (NSArray *)threeSum:(NSArray *)arr;
- (NSInteger)threeSumClosest:(NSArray *)arr target:(NSInteger)target;
//电话号码的字母组合
- (NSString *)letterCombination:(NSString *)digits;
@end

NS_ASSUME_NONNULL_END
