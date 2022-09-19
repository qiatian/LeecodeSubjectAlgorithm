//
//  ViewController.m
//  GitTest
//
//  Created by Qianyinhulian on 2022/8/26.
//

#import "ViewController.h"
#import "Algorithm.h"
#import "IntegerInversion/IntegerInversion.h"//"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Algorithm *ar = [[Algorithm alloc]init];
    NSLog(@"hhhhhh%ld",(long)[ar changeStrToInteger:@"  -42rrt"]);
    
    IntegerInversion *iiv = [[IntegerInversion alloc]init];
    NSLog(@"整数反转：%ld",[iiv reverse:12345]);
    
    NSLog(@"回文数字1:%d,回文数字2:%d",[ar isPalindrome:12321],[ar isPalindrome:1242]);
    BOOL isMatch = [ar isMatch:@"abc" str2:@".bc"];
    NSLog(@"正则表达式匹配：%d",isMatch);
    NSLog(@"盛最多水的容器：%ld",[ar maxArea:@[@1,@8,@6,@2,@5,@4,@8,@3,@7] size:0]);
    NSLog(@"intToRoman:%@",[ar intToRoman:3994]);
    NSLog(@"romanToInt:%ld",(long)[ar romanToInt:@"MMMCMXCIV"]);
    
    NSLog(@"longestCommonPrefix:%@",[ar longestCommonPrefix:@[@"flower",@"flow",@"flight"]]);
    
    NSLog(@"smartlongestCommonPrefix:%@",[ar smartLongestCommonPrefix:@[@"flower",@"flow",@"flight"]]);
    NSLog(@"sort：%@",[ar threeSum: @[@(-1),@0,@1,@2,@(-1),@(-4)]]);
    
    NSLog(@"sortclosest：%ld",(long)[ar threeSumClosest:@[@(-1),@2,@1,@(-4)] target:1]);
    
    NSLog(@"letterCombination:%@",[ar letterCombination:@"23"]);
    
}


@end
