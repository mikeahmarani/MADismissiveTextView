//
//  MADismissiveTextView.m
//  Sample
//
//  Created by Mike Ahmarani on 12-02-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MADismissiveTextView.h"

@interface MADismissiveTextView ()

@property (nonatomic, retain) UIView *keyboard;
@property (nonatomic, retain) UIPanGestureRecognizer *panGesture;
@property (nonatomic, readwrite) float originalKeyboardY; 

- (void)keyboardWillShow;
- (void)keyboardDidShow;
- (void)panning:(UIPanGestureRecognizer *)pan;

@end

@implementation MADismissiveTextView

@synthesize keyboard, panGesture, originalKeyboardY, keyboardDelegate;

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.editable = YES;
        self.inputAccessoryView = [[UIView alloc] init];
 
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panning:)];
        self.panGesture.delegate = self;
        [[[UIApplication sharedApplication] keyWindow] addGestureRecognizer:self.panGesture];                
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:@"UIKeyboardWillShowNotification" object:nil];                
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:@"UIKeyboardDidShowNotification" object:nil];
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)keyboardWillShow{
    self.keyboard.hidden = NO;
}

- (void)keyboardDidShow{
    self.keyboard = self.inputAccessoryView.superview;
    if(self.delegate){
        [self.keyboardDelegate keyboardDidAppear];
    }
}

- (void)panning:(UIPanGestureRecognizer *)pan{
    if(self.keyboard && !self.keyboard.hidden){
        UIWindow *panWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        CGPoint location = [pan locationInView:panWindow];
        CGPoint velocity = [pan velocityInView:panWindow];
        
        if(pan.state == UIGestureRecognizerStateBegan){
            self.originalKeyboardY = self.keyboard.frame.origin.y;
        }else if(pan.state == UIGestureRecognizerStateEnded){
            if(velocity.y > 0 && self.keyboard.frame.origin.y > self.originalKeyboardY){
                self.panGesture.enabled = NO;
                if(self.delegate){                
                    [self.keyboardDelegate keyboardWillGetDismissed];
                }
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self.keyboard.frame = CGRectMake(0, 480, self.keyboard.frame.size.width, self.keyboard.frame.size.height);
                }completion:^(BOOL finished){
                    self.panGesture.enabled = YES;
                    self.keyboard.hidden = YES;
                    self.keyboard.frame = CGRectMake(0, self.originalKeyboardY, self.keyboard.frame.size.width, self.keyboard.frame.size.height);
                    [self resignFirstResponder];                          
                }];
            }else{
                self.panGesture.enabled = NO;
                if(self.delegate){
                    [self.keyboardDelegate keyboardWillSnapBack];
                }
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self.keyboard.frame = CGRectMake(0, self.originalKeyboardY, self.keyboard.frame.size.width, self.keyboard.frame.size.height);
                } completion:^(BOOL finished){
                    self.panGesture.enabled = YES;
                }];
            }
        }else{
            if(location.y > self.keyboard.frame.origin.y || self.keyboard.frame.origin.y != self.originalKeyboardY){
                float newKeyboardY = self.originalKeyboardY + (location.y-self.originalKeyboardY);
                newKeyboardY = newKeyboardY < self.originalKeyboardY ? self.originalKeyboardY:newKeyboardY;
                newKeyboardY = newKeyboardY > 480 ? 480:newKeyboardY;
            
                self.keyboard.frame = CGRectMake(0, newKeyboardY, self.keyboard.frame.size.width, self.keyboard.frame.size.height);
                if(self.delegate){
                    [self.keyboardDelegate keyboardDidScroll:CGPointMake(0, newKeyboardY)];
                }
            }
        }
    }
}

@end
