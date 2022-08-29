//
//  AppDelegate.m
//  GitTest
//
//  Created by Qianyinhulian on 2022/8/26.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self numsCount];
    
    [self numsCount:@[@3,@2,@4] target:6];
    
    [self addNums:@[@9,@9,@9,@9,@9,@9,@9] nums1:@[@9,@9,@9,@9]];
    
    
    NSInteger maxLength = [self getStr:@"abcabcbb"];
    NSLog(@"maxLength%ld",maxLength);
    
    [self checkStr:@"abdfhabcojdsnagjsu"];
    
    double zws = [self findZWS:@[@1,@2] nums2:@[@3,@4]];
    
   NSNumber *zwsErFen = [self findZWSwithErFen:@[@1,@2] nums2:@[@3,@4]];
    NSLog(@"hhh%f erfen%@",zws,zwsErFen);
    
    return YES;
}

- (NSNumber *)findZWSwithErFen:(NSArray *)nums1 nums2:(NSArray *)nums2{
    NSInteger m = nums1.count;
    NSInteger n = nums2.count;
    if ((m+n)%2==0) {
        return @([[self findKth:nums1 nums2:nums2 zwsNum:(m+n)/2] integerValue]+[[self findKth:nums1 nums2:nums2 zwsNum:(m+n)/2+1] integerValue]);
        
    }else{
        return [self findKth:nums1 nums2:nums2 zwsNum:(m+n)/2+1];
    }
}

- (NSNumber *)findKth:(NSArray *)nums1 nums2:(NSArray *)nums2 zwsNum:(NSInteger)k{
    NSInteger m = nums1.count;
    NSInteger n = nums2.count;
    NSInteger index1 = 0,index2 = 0;
    while (1) {
        //边界情况
        if (index1 == m)  return nums2[index2+k-1];
        if (index2 == n) return nums1[index1+k-1];
        if (k==1) {
            if (nums1[index1]>nums2[index2]) {
                return nums1[index1];
            }else{
                return nums2[index2];
            }
        }
        //正常情况  下一个比较值坐标
        NSInteger nextIndex1 = (index1+k/2-1>m-1)?m-1:index1+k/2-1;
        NSInteger nextIndex2 = (index2+k/2-1>n-1)?n-1:index2+k/2-1;
        if (nums1[nextIndex1]>nums2[nextIndex2]) {
            k -= (nextIndex2-index2+1);
            index2 = nextIndex2+1;
        }else{
            k -= (nextIndex1-index1+1);
            index1 = nextIndex1+1;
        }
    }
}


- (double)findZWS:(NSArray *)nums1 nums2:(NSArray *)nums2{
    NSInteger totalCount = nums1.count + nums2.count;
    if (totalCount == 0) return -1;
    //合并记录数组
    NSMutableArray *mergeArr = [[NSMutableArray alloc]initWithCapacity:0];
    NSInteger index1=0,index2=0,index0=0;//合并过程中对应数组的下标
    while (index1 < nums1.count || index2<nums2.count) {
        //将数组1中小于数组2中index2对应当前值的数全部合并
        while (index1<nums1.count&&(index2 == nums2.count||nums2[index2]>=nums1[index1])) {
            mergeArr[index0] = nums1[index1];
            index0 += 1;
            index1 += 1;
        }
        while (index2<nums2.count&&(index1 == nums1.count||nums1[index1]>=nums2[index2])) {
            mergeArr[index0] = nums2[index2];
            index0 += 1;
            index2 += 1;
        }
        //如果合并数据过半，则处理结束
        if (index0 > totalCount/2) break;
    }
    //根据总个数的奇偶性计算中位数
    if (totalCount % 2 == 0){
        return ([mergeArr[totalCount/2 - 1]doubleValue] + [mergeArr[totalCount/2]doubleValue])  /2 ;
    } else {
        return ([mergeArr[totalCount/2] doubleValue]);
    }
}
- (void)checkStr:(NSString *)str{
    
    NSMutableSet *set = [NSMutableSet new];
    long n = str.length;
    
    //ans:最长子串长度,j:右指针,i:左指针
    int ans = 0, i = 0, j = 0 ,index = 0;
    while (i<n && j<n) {
        //和上一个算法相反,判断不包含则添加更合理
        if (![set containsObject:[str substringWithRange:NSMakeRange(j,1)]]) {

            //右指针滑动
            [set addObject:[str substringWithRange:NSMakeRange(j++, 1)]];

            //取指针区间内最大值
            if (j - i > ans) {
                ans = j - i;
                index = i;
            }
            
        }else{
            //出现相同字符则删除前一个,并i++,左指针右偏移一
            [set removeObject:[str substringWithRange:NSMakeRange(i++, 1)]];
            
        }
        
    }
    NSLog(@"checkStr:%@",[str substringWithRange:NSMakeRange(index, ans)]);
}
- (NSInteger)getStr:(NSString *)str{

    
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    NSInteger maxLength = 0;
    NSInteger start = 0;
    for (NSInteger i=0; i<str.length; i++) {
        NSRange letterRange = NSMakeRange(i, 1);
        
        NSString *letter = [str substringWithRange:letterRange];
        
        if ([[resultDic allKeys]containsObject:letter]) {
            start = [[resultDic objectForKey:letter] integerValue] + 1;
        }
        
        NSInteger tempLength = i - start +1;
        
        if (tempLength >= maxLength) {
            maxLength = tempLength;
            
            NSLog(@"%@",[str substringWithRange:NSMakeRange(start, maxLength)]);
        }
        
        [resultDic setObject:@(i) forKey:letter];
    }
    
    return maxLength;
}
- (void)addNums:(NSArray *)nums nums1:(NSArray *)nums1{
    
    NSMutableArray *resultArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (NSInteger i=0; i<nums.count; i++) {
        
        NSInteger num1 = 0;
        if (i<nums1.count&&i<nums.count) {
            num1 = [nums[i] integerValue]+[nums1[i] integerValue];
        }else{
            num1 = [nums[i] integerValue]+ [resultArr[i] integerValue];
        }
        if (resultArr.count==0) {
            resultArr[i] = @(0);
        }
        
        if (num1>=10) {
            resultArr[i] = (num1>10)?@(num1-10 + [resultArr[i] integerValue]):@(0);
            resultArr[i+1] = @(1);
        }else{
            if (resultArr.count==0||nums.count>nums1.count) {
                resultArr[i] = @(0);
            }
            
            resultArr[i] = @(num1 + [resultArr[i] integerValue]);
            
        }
        NSLog(@"resultArr %@",resultArr[i]);
    }
    if (resultArr.count>nums.count) {
        NSLog(@"resultArr %@",resultArr[nums.count]);
    }
    
}
    
- (void)numsCount:(NSArray *)nums target:(NSInteger)target{
    
    
    
    NSInteger targetNum = 0;
    for (NSInteger i=0; i<nums.count; i++) {
        NSInteger num1 = [nums[i] integerValue];
        for (NSInteger j=1; j<nums.count; j++) {
            NSInteger num2 = [nums[j] integerValue];
            if (num1 + num2 == target && targetNum==0) {
                NSLog(@" test1 [%ld,%ld]",(long)i,(long)j);
                targetNum++;
            }
            
        }
    }
    
    for (NSInteger i=0; i<nums.count; i++){
        NSInteger num1 = [nums[i] integerValue];
        NSInteger num2 = [nums[i+1] integerValue];
        if (num1 + num2 == target) {
            NSLog(@" test2 [%ld,%ld]",(long)i,(long)(i+1));
            break;
        }
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:nums.count];
    for (NSInteger i=0; i<nums.count; i++){
        NSInteger num1 = [nums[i] integerValue];
        NSInteger restNum = target - num1;
        
        
        if ([[dic allKeys] containsObject:@(restNum)]) {
            NSLog(@"test3[%@,%ld]",[dic objectForKey:@(restNum)],(long)i);
        }else{
            [dic setObject:[NSNumber numberWithInteger:i] forKey:@(num1)];
        }
    }
    
}
- (void)numsCount{
    NSArray *nums = @[@2,@7,@11,@15];
    NSInteger target = 9;
    
    for (NSInteger i=0; i<nums.count; i++) {
        NSInteger num1 = [nums[i] integerValue];
        for (NSInteger j=1; j<nums.count; j++) {
            NSInteger num2 = [nums[j] integerValue];
            if (num1 + num2 == target) {
                NSLog(@" test [%ld,%ld]",(long)i,(long)j);
            }
        }
    }
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
