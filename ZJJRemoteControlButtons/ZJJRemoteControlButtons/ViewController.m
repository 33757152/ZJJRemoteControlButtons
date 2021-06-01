//
//  ViewController.m
//  ZJJRemoteControlButtons
//
//  Created by admin on 2021/5/31.
//

#import "ViewController.h"
#import "ZJJButtonsView.h"

@interface ViewController () <ZJJButtonsViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZJJButtonsView *button = [[ZJJButtonsView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 100, 200, 200)];
    button.delegate = self;
    [self.view addSubview:button];
}

- (void)topButtonClicked {
    NSLog(@"点击了--上面");
}

- (void)leftButtonClicked {
    NSLog(@"点击了--左面");

}

- (void)rightButtonClicked {
    NSLog(@"点击了--右面");

}

- (void)bottomButtonClicked {
    NSLog(@"点击了--下面");
}

- (void)centerButtonClicked {
    NSLog(@"点击了--中心");
}

@end
