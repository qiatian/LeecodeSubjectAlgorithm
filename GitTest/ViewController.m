//
//  ViewController.m
//  GitTest
//
//  Created by Qianyinhulian on 2022/8/26.
//

#import "ViewController.h"
#import "Algorithm.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Algorithm *ar = [[Algorithm alloc]init];
    NSLog(@"hhhhhh%ld",(long)[ar changeStrToInteger:@"  -42"]);
}


@end
