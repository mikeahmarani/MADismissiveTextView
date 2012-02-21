//
//  ViewController.m
//  Sample
//
//  Created by Mike Ahmarani on 12-02-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, retain) UIScrollView  *scrollView;

@end

@implementation ViewController

@synthesize scrollView = _scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 416)];
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.contentSize = CGSizeMake(320, 1000);
        self.scrollView.bounces = YES;
        [self.view addSubview:self.scrollView];
        
        UILabel *lorem = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 1000)];
        lorem.backgroundColor = [UIColor clearColor];
        lorem.numberOfLines = 0;
        lorem.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam a lorem at velit egestas pulvinar. Duis vel tempus augue. Morbi in odio mi, a ultrices mi. Nullam adipiscing neque aliquam lacus aliquet tincidunt. Nunc quis ante eu nisl blandit rutrum. Aenean cursus justo vitae turpis ultrices sit amet sagittis urna luctus. Curabitur eleifend tristique libero, a hendrerit sapien convallis at. Sed sit amet orci ultrices metus porttitor bibendum consequat ac tellus. Etiam justo nisl, placerat quis sollicitudin ut, lobortis adipiscing lectus. Ut aliquam pellentesque orci id auctor. Etiam viverra ipsum nec urna semper rhoncus. Duis mollis dui in urna semper ut rutrum metus pellentesque.\n\nUt lobortis augue egestas ante pulvinar dictum. Nullam consequat, enim ac adipiscing dapibus, diam libero bibendum urna, sit amet venenatis enim purus ut lacus. Quisque molestie faucibus arcu, vel molestie est semper vel. Morbi leo orci, interdum et vulputate malesuada, lobortis tempus libero. Suspendisse malesuada dapibus dolor vitae iaculis. Suspendisse dignissim ligula id magna condimentum rhoncus. Vestibulum non suscipit quam. Fusce nec est nibh, eu suscipit ante. Mauris ac massa urna, at volutpat turpis. Quisque et neque ac lacus sagittis rhoncus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi lorem massa, pulvinar sit amet aliquet sit amet, luctus non libero. Maecenas condimentum, massa vel auctor cursus, nisl mauris sagittis ipsum, convallis ullamcorper nisl ipsum ac lectus. Vestibulum vestibulum pretium convallis. Aliquam laoreet porttitor dictum. Aliquam porta, nulla at placerat malesuada, diam magna laoreet dui, at ullamcorper dolor nisi at dui.\n\nSed suscipit tellus nec nulla tempor imperdiet. Aliquam volutpat semper purus, sed pellentesque libero lacinia ac. Maecenas dapibus nulla tempus est gravida feugiat. Mauris augue elit, consequat non cursus eget, aliquam quis felis. Donec rutrum luctus lacinia. Mauris eu risus tellus, at ullamcorper velit. Pellentesque nulla libero, cursus nec commodo sit amet, posuere ac mauris. Vivamus venenatis sem ac lectus adipiscing sit amet porttitor arcu lobortis. Aenean faucibus, eros vel sagittis accumsan, elit felis tincidunt ligula, eu rutrum massa est vel lectus. Vivamus malesuada convallis enim, non mattis nulla dapibus in. Pellentesque faucibus, diam ut bibendum consectetur, lorem nunc porta est, dignissim egestas velit velit laoreet odio. Integer commodo eleifend risus suscipit volutpat. Morbi sodales malesuada consectetur.";
        [self.scrollView addSubview:lorem];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    MADismissiveTextView *textView = [[MADismissiveTextView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    textView.keyboardDelegate = self;
    textView.font = [UIFont fontWithName:@"HelveticaNeue" size:22];
    textView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:textView];    
}

#pragma mark -
#pragma mark MADismissiveKeyboardDelegate

- (void)keyboardDidAppear{
    self.scrollView.frame = CGRectMake(0, 44, 320, 200);
}

- (void)keyboardDidScroll:(CGPoint)keyboardOrigin{
    self.scrollView.frame = CGRectMake(0, 44, 320, keyboardOrigin.y-64);
}

- (void)keyboardWillGetDismissed{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.scrollView.frame = CGRectMake(0, 44, 320, 416);         
    }completion:nil];
}

- (void)keyboardWillSnapBack{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.scrollView.frame = CGRectMake(0, 44, 320, 200);         
    }completion:nil];
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
