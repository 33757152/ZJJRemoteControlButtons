//
//  ZJJSectorView.h
//  ZJJRemoteControlButtons
//
//  Created by admin on 2021/5/31.
//
@class ZJJSectorView;

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZJJSectorResponseDelegate <NSObject>

- (void)sectorButtonResponseClickView:(ZJJSectorView *)view;

@end

@interface ZJJSectorView : UIView

/// 创建不规则图形按钮
/// @param frame 坐标
/// @param title 字体
/// @param selectedColor 选中状态下的背景颜色
/// @param titleColor 字体颜色
/// @param normalColor 默认背景颜色
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor titleColor:(UIColor *)titleColor;

@property (nonatomic, weak) id <ZJJSectorResponseDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
