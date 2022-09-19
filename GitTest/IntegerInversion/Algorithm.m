//
//  Algorithm.m
//  GitTest
//
//  Created by Qianyinhulian on 2022/9/2.
//字符串转换整数

#import "Algorithm.h"

@implementation Algorithm
- (NSInteger)changeStrToInteger:(NSString *)str{
//    请你来实现一个 myAtoi(string s) 函数，使其能将字符串转换成一个 32 位有符号整数（类似 C/C++ 中的 atoi 函数）。
//
//    函数 myAtoi(string s) 的算法如下：
//
//    读入字符串并丢弃无用的前导空格
//    检查下一个字符（假设还未到字符末尾）为正还是负号，读取该字符（如果有）。 确定最终结果是负数还是正数。 如果两者都不存在，则假定结果为正。
//    读入下一个字符，直到到达下一个非数字字符或到达输入的结尾。字符串的其余部分将被忽略。
//    将前面步骤读入的这些数字转换为整数（即，"123" -> 123， "0032" -> 32）。如果没有读入数字，则整数为 0 。必要时更改符号（从步骤 2 开始）。
//    如果整数数超过 32 位有符号整数范围 [−231,  231 − 1] ，需要截断这个整数，使其保持在这个范围内。具体来说，小于 −231 的整数应该被固定为 −231 ，大于 231 − 1 的整数应该被固定为 231 − 1 。
//    返回整数作为最终结果。
//    注意：
//
//    本题中的空白字符只包括空格字符 ' ' 。
//    除前导空格或数字后的其余字符串外，请勿忽略 任何其他字符。

    if (str == nil && str.length==0) {
        return 0;
    }
    if (str.length == 1) {
        if ([[str substringWithRange:NSMakeRange(0, 1)] integerValue]>=0&&[[str substringWithRange:NSMakeRange(0, 1)] integerValue]<10) {
            return [str characterAtIndex:0]-48;
        }else return 0;
    }
    
    //删除前导空格
    str = [self removeBlanks:str];
    if (str.length == 0) {
        return 0;
    }
    long n=0;
    NSInteger flag = -1;
    if ([[str substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"-"]) {
        flag =0;
        str = [str stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    }else if ([[str substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"]){
        flag = 1;
        str = [str stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    }
    for (NSInteger i=0; i<str.length; i++) {
        if ([[str substringWithRange:NSMakeRange(i, 1)] integerValue]>=0&&[[str substringWithRange:NSMakeRange(i, 1)] integerValue]<10) {
            n = n*10+[str characterAtIndex:i]-48;
            if (n>=NSIntegerMax) {
                break;;
            }
        }else break;;
    }
    
    if (flag ==0) {
        n = -n;
    }
    if (n>=NSIntegerMax) {
        return NSIntegerMax;
    }
    if (n<=NSIntegerMin) {
        return  NSIntegerMin;
    }
    return  n;
}
- (NSString *)removeBlanks:(NSString *)str{
    NSInteger i=0;
    NSInteger flag = 0;
    while (true) {
        if (flag == 1) {
            break;
        }
        if (i == str.length) {
            return  @"";
        }
        if ([[str substringWithRange:NSMakeRange(i, 1)] isEqualToString:@" "]) {
            i++;
        }else flag = 1;
    }
    return [str substringFromIndex:i];
}
- (BOOL)isPalindrome:(NSInteger)x{
    BOOL isPalindrome = false;
    if (x<0||(x%10==0&&x!=0)) {
        return  isPalindrome;
    }
    
    NSInteger reverNum = 0;
    while (x>reverNum) {
        NSInteger ys = x%10;
        x = x/10;
        reverNum = reverNum*10+ys;
    }
    
    
    isPalindrome = (x==reverNum||x== reverNum/10);
    
    return isPalindrome;
}
- (BOOL)isMatch:(NSString *)s str2:(NSString *)p{
//    给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。
//
//    '.' 匹配任意单个字符
//    '*' 匹配零个或多个前面的那一个元素
//    所谓匹配，是要涵盖 整个 字符串 s的，而不是部分字符串。
    
    NSInteger sm= s.length;
    NSInteger pn = p.length;
    
    NSMutableArray *dp = [[NSMutableArray alloc]init];
    for (NSInteger i=0; i<sm; i++) {
        NSMutableArray *pnArr = [[NSMutableArray alloc]init];
        for (NSInteger j=0; j<pn; j++) {
            [pnArr addObject:[NSNumber numberWithBool:NO]];
        }
        [dp addObject:pnArr];
    }
    dp[0][0] = [NSNumber numberWithBool:YES];
    
    for (NSInteger i=0; i<sm; i++) {
        for (NSInteger j=1; j<pn; j++) {
            //特殊情况
            if ([[p substringWithRange:NSMakeRange(j -1, 1)]  isEqual: @"*"]) {
                dp[i][j] = dp[i][j-2];
            }else{
                if (i!=0 &&[self matches:[s substringWithRange:NSMakeRange(i-1, 1)] str:[p substringWithRange:NSMakeRange(j-1, 1)]]) {
                    dp[i][j]=dp[i-1][j-1];
                }
            }
        }
        
    }

    NSNumber *num = dp[sm-1][pn-1];
    BOOL isMatch = [num boolValue];
    
    return  isMatch;
}
- (BOOL)matches:(NSString *)sa str:(NSString *)pa{
    
    if ([pa isEqual:@"."]) {
        return YES;
    }
    return [pa isEqual:sa];
}
- (NSInteger)maxArea:(NSArray *)height size:(NSInteger)heightSize{
    NSInteger sum = 0;
    NSInteger i=0,j=height.count-1;
    NSInteger area;
    while (i<j) {
        area = MIN([height[i] integerValue], [height[j] integerValue])*(j-i);
        NSLog(@"area %ld",(long)area);
        sum = MAX(sum, area);
        if (height[i]<height[j]) {
            i++;
        }else j--;
    }
    return sum;
}
- (NSString *)intToRoman:(NSInteger)num{
    NSArray *nums = @[@1,@5,@10,@50,@100,@500,@1000];
    NSArray *romans = @[@"I",@"V",@"X",@"L",@"C",@"D",@"M"];
    NSMutableArray *digitStr = [[NSMutableArray alloc]initWithCapacity:nums.count];
//    NSScanner *sc = [NSScanner scannerWithString:romans];
//    NSInteger digit = [sc scanInteger:1];
    NSInteger digit = num ;
    for (NSInteger i=nums.count-1; i>=0; i--) {
        
        
        NSInteger alnum = [nums[i] integerValue];
        
//        [digitStr insertObject:@(digit / alnum) atIndex:0];
        [digitStr addObject:@(digit / alnum)];

        digit = digit % alnum;
        
    }
    
//    for (NSInteger k = nums.count-1; k>=0; k--) {
//        if ([digitStr[k]  integerValue]==1&&k>=1&&[digitStr[k-1] integerValue]==4) {
//            NSLog(@"%@%@",romans[k-1],romans[k+1]);
//            k = k-1;
//        }else if ([digitStr[k] integerValue]==4){
//            NSLog(@"%@%@",romans[k],romans[k+1]);
//        }else{
//            for (NSInteger l=0; l<[digitStr[k] integerValue]; l++) {
//                NSLog(@"---%@",romans[k]);
//            }
//
//        }
//    }
    NSInteger acount = nums.count-1;
    for (NSInteger k = 0; k<=acount; k++) {
        if ([digitStr[k]  integerValue]==1&&k>=1&&[digitStr[k+1] integerValue]==4) {
            NSLog(@"%@%@",romans[acount -(k+1)],romans[acount -(k-1)]);
            k = k+1;
        }else if ([digitStr[k] integerValue]==4){
            NSLog(@"%@%@",romans[acount -k],romans[acount -(k-1)]);
        }else{
            for (NSInteger l=0; l<[digitStr[k] integerValue]; l++) {
                NSLog(@"---%@",romans[acount - k]);
            }
            
        }
    }
    
    return @"";
}
- (NSInteger)romanToInt:(NSString *)str{
    NSArray *romans = @[@"I",@"V",@"X",@"L",@"C",@"D",@"M"];

    NSArray *nums = @[@1,@5,@10,@50,@100,@500,@1000];
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    for (NSInteger i=0; i<str.length-1; i++) {
        NSString *cstr = [str substringWithRange:NSMakeRange(i, 1)];
        for (NSInteger j=0; j<romans.count; j++) {
            if ([cstr isEqualToString:romans[j]]) {
                [resultArr addObject:nums[j]];
            }
        }
    }
    
    for (NSString *numStr in resultArr) {
        NSLog(@"result?? %@",numStr);
    }
    NSInteger resultNum = 0;
    for (NSInteger i=0; i<resultArr.count; i++) {
        if (i+1<resultArr.count&&[resultArr[i] integerValue]<[resultArr[i+1] integerValue]) {
            resultNum = resultNum - [resultArr[i] integerValue];
        }else{
            resultNum = resultNum + [resultArr[i] integerValue];
        }
    }
    
    return resultNum;
}
- (NSString *)longestCommonPrefix:(NSArray *)arr{
    if (arr.count == 0) {
        return @"";
    }
    NSMutableString *res = [NSMutableString string];
    NSString *firstStr = arr.firstObject;
    NSInteger lengths = firstStr.length;
    for (NSInteger i=1; i<arr.count; i++) {
        NSString *str = arr[i];
        if (str.length < lengths) {
            lengths = str.length;
        }
    }
    
    if (lengths == 0) {
        return @"";
    }
    
    for (NSInteger i=0; i<lengths; i++) {
        NSString *charStr = [arr[0] substringWithRange:NSMakeRange(i, 1)];
        NSInteger j=1;
        while (j<arr.count) {
            if (charStr==[arr[j] substringWithRange:NSMakeRange(i, 1)]) {
                j++;
                continue;
            }else{
                return  res;
            }
        }
        if (j==arr.count) {
            [res appendFormat:@"%@",charStr];
        }
    }
    
    return  res;
}
- (NSString *)smartLongestCommonPrefix:(NSArray *)arr{
    
    if (arr.count == 0) {
        return @"";
    }
    
    NSString *res = arr.firstObject;
    for (NSInteger i=1; i<arr.count; i++) {
        while (![arr[i] containsString:res]) {
            res = [res substringWithRange:NSMakeRange(0, res.length-1)];
            if (res.length == 0) {
                return @"";
            }
                
        }
    }
    return res;
}
- (NSArray *)threeSum:(NSArray *)arr{
    NSArray *resultArr;
    resultArr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    
    NSMutableArray *hhh = [[NSMutableArray alloc]init];
    for (NSInteger i=0; i<resultArr.count; i++) {
        if ([resultArr[i] integerValue]>0) {//当前数>0，跳出循环
            break;
        }
        //相邻两数相等 跳下一循环
        if (i>0&&resultArr[i]==resultArr[i-1]) {
            continue;
        }
        NSInteger target = 0 - [resultArr[i] integerValue];
        NSInteger j = i+1;
        NSInteger k = resultArr.count -1;
        
        while (j<k) {
            if ([resultArr[j] integerValue]+[resultArr[k] integerValue]==target) {
//                NSMutableArray *newNum = [[NSMutableArray alloc]init];
//                [newNum addObject:resultArr[i]];
//                [newNum addObject:resultArr[j]];
//                [newNum addObject:resultArr[k]];
                [hhh addObject:@[resultArr[i],resultArr[j],resultArr[k]]];
                

                
                while (j<k && resultArr[j]==resultArr[j+1]) {
                    j = j+1;
                }
                while (j<k && resultArr[k]==resultArr[k-1]) {
                    k = k-1;
                }
                
                j = j+1;
                k = k-1;
            }else if ([resultArr[j] integerValue]+[resultArr[k] integerValue]<target){
                j = j+1;
            }else{
                k = k-1;
            }
        }
    }
    return  hhh;
}
- (NSInteger)threeSumClosest:(NSArray *)arr target:(NSInteger)target{
    
    NSArray *sortArr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSInteger sum = 0;
    NSInteger arrCount = sortArr.count;
    NSInteger min_dis = 10000;
    for (NSInteger i=0; i<arrCount; i++) {
        NSInteger a=[sortArr[i] integerValue];
        NSInteger l = i+1;
        NSInteger r = arrCount-1;
        while (l<r) {
            NSInteger b = [sortArr[l] integerValue];
            NSInteger c = [sortArr[r] integerValue];
            NSInteger d = target-a-b-c;
            if (d>0) {//三数和比目标小
                l++;
                if (labs(d)<min_dis) {
                    sum = a+b+c;
                    min_dis = labs(d);
                }
            }else if (d<0){//三数和比目标大
                r--;
                if (labs(d)<min_dis) {
                    sum = a+b+c;
                    min_dis = labs(d);
                }
            }else{//三数和刚好等于目标值
                return  target;
            }
        }
        
    }
    return sum;
}
- (NSArray *)letterCombination:(NSString *)digits{
 
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"abc" forKey:@"2"];
    [dic setValue:@"def" forKey:@"3"];
    [dic setValue:@"ghi" forKey:@"4"];
    [dic setValue:@"jkl" forKey:@"5"];
    [dic setValue:@"mno" forKey:@"6"];
    [dic setValue:@"pqrs" forKey:@"7"];
    [dic setValue:@"tuv" forKey:@"8"];
    [dic setValue:@"wxyz" forKey:@"9"];
    
    NSMutableArray *pinletters=[[NSMutableArray alloc]init];
    
    
    
    for (NSInteger i=0; i<digits.length; i++) {
        NSString *keyNum = [digits substringWithRange:NSMakeRange(i, 1)];
        [pinletters addObject:[dic objectForKey:keyNum]];
        
    }
    
//    NSMutableArray *result=[[NSMutableArray alloc]init];
    NSMutableArray *combinations = [[NSMutableArray alloc]init];
    NSMutableString *combination = [NSMutableString string];
    if (digits.length != 0) {
        [self backtrack:combinations dic:dic digits:digits numIndex:0 com:combination];
    }
    NSLog(@"pLetters:%@",pinletters);
    return  combinations;
}//回溯
- (void)backtrack:(NSMutableArray *)combinations dic:(NSMutableDictionary *)dic digits:(NSString *)digits numIndex:(NSInteger)index com:(NSMutableString *)combination{
    if (index == digits.length) {
        
        [combinations addObject:[NSString stringWithFormat:@"%@", combination]];
    }else{
        NSString *digit = [digits substringWithRange:NSMakeRange(index, 1)];
        NSString *letters = [dic objectForKey:digit];
        NSInteger lettercount = letters.length;
        
        for (NSInteger i=0; i<lettercount; i++) {
            [combination appendFormat:@"%@",[letters substringWithRange:NSMakeRange(i, 1)]];
            [self backtrack:combinations dic:dic digits:digits numIndex:index+1 com:combination];
            [combination deleteCharactersInRange:NSMakeRange(index, 1)];
            
        }
    }
}
@end
