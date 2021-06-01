//
//  ZJJSectorView.m
//  ZJJRemoteControlButtons
//
//  Created by admin on 2021/5/31.
//

#import "ZJJSectorView.h"

@interface ZJJSectorView ()

@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
/// 文字
@property (nonatomic, copy) NSString *title;
/// 默认状态下的背景颜色
@property (nonatomic, strong) UIColor *normalColor;
/// 选中状态下的背景颜色
@property (nonatomic, strong) UIColor *selectedBGColor;
/// 字体颜色
@property (nonatomic, strong) UIColor *titleColor;

@end

@implementation ZJJSectorView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor titleColor:(UIColor *)titleColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.title = title;
        self.normalColor = normalColor;
        self.selectedBGColor = selectedColor;
        self.titleColor = titleColor;
        [self customView];
    }
    return self;
}

- (void)customView {
    // Drawing code
    // 圆心
    CGPoint circlePoint = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    // 左上
    CGPoint left1 = CGPointMake(circlePoint.x - circlePoint.y/sqrt(2), circlePoint.y - circlePoint.y/sqrt(2));
    // 左下
    CGPoint left2 = CGPointMake(circlePoint.x - circlePoint.y/sqrt(2)/2, circlePoint.y - circlePoint.y/sqrt(2)/2);
    // 右上
    //CGPoint right1 = CGPointMake(circlePoint.x + circlePoint.y/sqrt(2), circlePoint.y - circlePoint.y/sqrt(2));
    // 右下
    CGPoint right2 = CGPointMake(circlePoint.x + circlePoint.y/sqrt(2)/2, circlePoint.y - circlePoint.y/sqrt(2)/2);
    // 初始化贝塞尔曲线
    self.bezierPath = [UIBezierPath bezierPath];
    [self.bezierPath moveToPoint:left1];
    [self.bezierPath addArcWithCenter:circlePoint radius:circlePoint.y startAngle:M_PI*5/4 endAngle:M_PI*7/4 clockwise:YES];
    [self.bezierPath addLineToPoint:right2];
    [self.bezierPath addArcWithCenter:circlePoint radius:circlePoint.y/2 startAngle:M_PI*7/4 endAngle:M_PI*5/4 clockwise:NO];
    [self.bezierPath addLineToPoint:left1];
    [self.bezierPath stroke];
    // 初始化layer
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.bounds;
    self.shapeLayer.lineWidth = 1;
    self.shapeLayer.fillColor = _normalColor.CGColor;
    self.shapeLayer.strokeColor = _normalColor.CGColor;
    self.shapeLayer.path = _bezierPath.CGPath;
    [self.layer addSublayer:self.shapeLayer];
    // 创建label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left2.x, 0, right2.x - left2.x, circlePoint.y/2)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = _titleColor;
    label.text = _title;
    [self addSubview:label];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self.bezierPath containsPoint:point]) {
        static int i = 0;
        if (i == 0) {
            if ([self.delegate respondsToSelector:@selector(sectorButtonResponseClickView:)]) {
                [self.delegate sectorButtonResponseClickView:self];
            }
            i ++;
        } else {
            i = 0;
        }
        self.shapeLayer.fillColor = self.selectedBGColor.CGColor;
        self.shapeLayer.strokeColor = self.selectedBGColor.CGColor;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.shapeLayer.fillColor = self.normalColor.CGColor;
            self.shapeLayer.strokeColor = self.normalColor.CGColor;
        });
    }
    return nil;
}

@end

