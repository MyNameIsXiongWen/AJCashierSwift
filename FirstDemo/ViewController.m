//
//  ViewController.m
//  FirstDemo
//
//  Created by jiazhuo1 on 2018/3/19.
//  Copyright © 2018年 JIAZHUO. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#define  DegreesToRadians(degrees)  ((3.14159265359 * degrees)/ 180)

@interface ViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) JSContext *context;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createPath];
    [self creatWebView];
    [self loadUrl];
}

- (void)creatWebView {
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
}

- (void)loadUrl {
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *currentUrl = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSLog(@"currenturl---%@",currentUrl);
    NSString *currentTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"currentTitle---%@",currentTitle);
}


- (void)createPath {
//    UIBezierPath *apath = [UIBezierPath bezierPath];
//    apath.lineWidth = 1;
//    [apath moveToPoint:CGPointMake(100, 0)];
//    [apath addLineToPoint:CGPointMake(150, 50)];
//    [apath addLineToPoint:CGPointMake(100, 100)];
//    [apath addLineToPoint:CGPointMake(50, 100)];
//    [apath addLineToPoint:CGPointMake(50, 50)];
//    [apath addLineToPoint:CGPointMake(50, 0)];
//    [apath closePath];
//    [[UIColor greenColor] setStroke];
//    [apath stroke];
    
    // 1. 随便画一个路径出来.
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(10, 10)];
    [path addLineToPoint: CGPointMake(80, 40)];
    [path addLineToPoint: CGPointMake( 40, 80)];
    [path addLineToPoint: CGPointMake(40, 40)];
    path.lineWidth = 3;
    // 2. 为这条路径制作一个反转路径
    UIBezierPath *reversingPath = [path bezierPathByReversingPath];
    reversingPath.lineWidth = 3;
    // 3. 为了避免两条路径混淆在一起, 我们为第一条路径做一个位移
    CGAffineTransform transform = CGAffineTransformMakeTranslation(200, 0);
    [path applyTransform: transform];
    // 设置虚线
    CGFloat dashLineConfig[] = {8.0, 4.0, 16.0, 8.0};
    [path setLineDash:dashLineConfig count:4 phase:0];
    // 4. 设置颜色, 并绘制路径
    [AJCASH_RED_COLOR set];
    [path stroke];
    [AJCASH_GREEN_COLOR set];
    [reversingPath stroke];
}

- (UIBezierPath *)createArcPath {
    UIBezierPath *apath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:30 startAngle:0 endAngle:DegreesToRadians(135) clockwise:YES];
    return apath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
