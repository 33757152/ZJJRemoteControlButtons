//
//  ZJJButtonsView.h
//  ZJJRemoteControlButtons
//
//  Created by admin on 2021/5/31.
//

#import <UIKit/UIKit.h>

@protocol ZJJButtonsViewDelegate <NSObject>

- (void)topButtonClicked;

- (void)leftButtonClicked;

- (void)rightButtonClicked;

- (void)bottomButtonClicked;

- (void)centerButtonClicked;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ZJJButtonsView : UIView

@property (nonatomic, weak) id <ZJJButtonsViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
