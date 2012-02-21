//
//  MADismissiveTextView.h
//  MADismissiveTextView
//
//  Created by Mike Ahmarani on 12-02-18.
//  Copyright (c) 2012 Mike Ahmarani. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MADismissiveKeyboardDelegate <NSObject>

@optional
- (void)keyboardDidShow;
- (void)keyboardDidScroll:(CGPoint)keyboardOrigin;
- (void)keyboardWillGetDismissed;
- (void)keyboardWillSnapBack;

@end

@interface MADismissiveTextView : UITextView

@property (nonatomic, assign) id <MADismissiveKeyboardDelegate> keyboardDelegate;
@property (nonatomic, retain) UIPanGestureRecognizer *dismissivePanGestureRecognizer;

@end
