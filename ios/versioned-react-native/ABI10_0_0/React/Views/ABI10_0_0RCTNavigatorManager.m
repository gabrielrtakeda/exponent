/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "ABI10_0_0RCTNavigatorManager.h"

#import "ABI10_0_0RCTBridge.h"
#import "ABI10_0_0RCTConvert.h"
#import "ABI10_0_0RCTNavigator.h"
#import "ABI10_0_0RCTUIManager.h"
#import "UIView+ReactABI10_0_0.h"

@implementation ABI10_0_0RCTNavigatorManager

ABI10_0_0RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[ABI10_0_0RCTNavigator alloc] initWithBridge:self.bridge];
}

ABI10_0_0RCT_EXPORT_VIEW_PROPERTY(requestedTopOfStack, NSInteger)
ABI10_0_0RCT_EXPORT_VIEW_PROPERTY(onNavigationProgress, ABI10_0_0RCTDirectEventBlock)
ABI10_0_0RCT_EXPORT_VIEW_PROPERTY(onNavigationComplete, ABI10_0_0RCTBubblingEventBlock)
ABI10_0_0RCT_EXPORT_VIEW_PROPERTY(interactivePopGestureEnabled, BOOL)

// TODO: remove error callbacks
ABI10_0_0RCT_EXPORT_METHOD(requestSchedulingJavaScriptNavigation:(nonnull NSNumber *)ReactABI10_0_0Tag
                  errorCallback:(__unused ABI10_0_0RCTResponseSenderBlock)errorCallback
                  callback:(ABI10_0_0RCTResponseSenderBlock)callback)
{
  [self.bridge.uiManager addUIBlock:
   ^(__unused ABI10_0_0RCTUIManager *uiManager, NSDictionary<NSNumber *, ABI10_0_0RCTNavigator *> *viewRegistry){
    ABI10_0_0RCTNavigator *navigator = viewRegistry[ReactABI10_0_0Tag];
    if ([navigator isKindOfClass:[ABI10_0_0RCTNavigator class]]) {
      BOOL wasAcquired = [navigator requestSchedulingJavaScriptNavigation];
      callback(@[@(wasAcquired)]);
    } else {
      ABI10_0_0RCTLogError(@"Cannot set lock: %@ (tag #%@) is not an ABI10_0_0RCTNavigator", navigator, ReactABI10_0_0Tag);
    }
  }];
}

@end
