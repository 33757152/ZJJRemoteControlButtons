//
//  ZJJButtonsView.m
//  ZJJRemoteControlButtons
//
//  Created by admin on 2021/5/31.
//

#define TOP_TAG    1000
#define LEFT_TAG   2000
#define RIGHT_TAG  3000
#define BOTTOM_TAG 4000

#import "ZJJButtonsView.h"
#import "ZJJSectorView.h"

@interface ZJJButtonsView () <ZJJSectorResponseDelegate>

@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
/// 视图宽高
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;
/// 上部按钮
@property (nonatomic, strong) ZJJSectorView *topBtnView;
/// 左部按钮
@property (nonatomic, strong) ZJJSectorView *leftBtnView;
/// 下面
@property (nonatomic, strong) ZJJSectorView *bottomBtnView;
/// 右边
@property (nonatomic, strong) ZJJSectorView *rightBtnView;

@end

@implementation ZJJButtonsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewWidth = frame.size.width;
        self.viewHeight = frame.size.height;
        CGFloat d = MIN(_viewWidth, _viewHeight);
        if (d > 0) {
            [self createAllControlButtons];
        }
    }
    return self;
}

// MARK: - 创建五个按钮
- (void)createAllControlButtons {
    // 中间的圆形按钮
    self.bezierPath = [UIBezierPath bezierPath];
    [_bezierPath addArcWithCenter:CGPointMake(_viewWidth/2, _viewHeight/2) radius:_viewHeight/4 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [_bezierPath stroke];
    
    self.shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = self.bounds;
    _shapeLayer.fillColor = [[UIColor magentaColor] CGColor];
    _shapeLayer.shadowColor = [[UIColor magentaColor] CGColor];
    _shapeLayer.path = _bezierPath.CGPath;
    [self.layer addSublayer:_shapeLayer];
    
//     创建label
    UILabel *label = [[UILabel alloc] init];
    label.center = CGPointMake(_viewWidth/2, _viewHeight/2);
    label.bounds = CGRectMake(0, 0, _viewWidth/2, _viewHeight/2);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.text = @"中间";
    [self addSubview:label];
    // 上边
    self.topBtnView = [[ZJJSectorView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight/2) title:@"上面" normalColor:UIColor.greenColor selectedColor:UIColor.blackColor titleColor:UIColor.blackColor];
    _topBtnView.tag = TOP_TAG;
    _topBtnView.delegate = self;
    [self addSubview:_topBtnView];
    // 左边
    self.leftBtnView = [[ZJJSectorView alloc] initWithFrame:CGRectMake(-_viewHeight/4, _viewHeight/4, _viewWidth, _viewHeight/2) title:@"左面" normalColor:UIColor.cyanColor selectedColor:UIColor.blackColor titleColor:UIColor.blackColor];
    _leftBtnView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    _leftBtnView.tag = LEFT_TAG;
    _leftBtnView.delegate = self;
    [self addSubview:_leftBtnView];
    // 下面
    self.bottomBtnView = [[ZJJSectorView alloc] initWithFrame:CGRectMake(0, _viewHeight/2, _viewWidth, _viewHeight/2) title:@"下面" normalColor:UIColor.yellowColor selectedColor:UIColor.blackColor titleColor:UIColor.blackColor];
    _bottomBtnView.transform = CGAffineTransformMakeRotation(-M_PI);
    _bottomBtnView.tag = BOTTOM_TAG;
    _bottomBtnView.delegate = self;
    [self addSubview:_bottomBtnView];
    // 右边
    self.rightBtnView = [[ZJJSectorView alloc] initWithFrame:CGRectMake(_viewHeight/4, _viewHeight/4, _viewWidth, _viewHeight/2) title:@"右面" normalColor:UIColor.lightGrayColor selectedColor:UIColor.blackColor titleColor:UIColor.blackColor];
    _rightBtnView.transform = CGAffineTransformMakeRotation(-3*M_PI/2);
    _rightBtnView.tag = RIGHT_TAG;
    _rightBtnView.delegate = self;
    [self addSubview:_rightBtnView];
}

- (void)sectorButtonResponseClickView:(ZJJSectorView *)view {
    if (view.tag == TOP_TAG) {
        [self.delegate topButtonClicked];
    } else if (view.tag == LEFT_TAG) {
        [self.delegate leftButtonClicked];
    } else if (view.tag == RIGHT_TAG) {
        [self.delegate rightButtonClicked];
    } else if (view.tag == BOTTOM_TAG) {
        [self.delegate bottomButtonClicked];
    } else {}
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self.bezierPath containsPoint:point]) {
        static int i = 0;
        if (i == 0) {
            if ([self.delegate respondsToSelector:@selector(centerButtonClicked)]) {
                [self.delegate centerButtonClicked];
            }
            i ++;
        } else {
            i = 0;
        }
        self.shapeLayer.fillColor = UIColor.redColor.CGColor;
        self.shapeLayer.strokeColor = UIColor.redColor.CGColor;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.shapeLayer.fillColor = UIColor.magentaColor.CGColor;
            self.shapeLayer.strokeColor = UIColor.magentaColor.CGColor;
        });
    }
    return [super hitTest:point withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
