//
//  TutorialController.m
//  Travel Maker
//
//  Created by developer on 12/4/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "TutorialController.h"

@implementation TutorialController

@synthesize imgTutorial;
@synthesize lblTutorial;

int current_tutorial;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft ];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight ];
    [self.view addGestureRecognizer:swipeRight];
    
    current_tutorial = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)swipedRight:(UISwipeGestureRecognizer *)recognizer
{
    if (current_tutorial == 1)
        return;
    
    current_tutorial --;
    [self updateTutorialView:current_tutorial];
}

- (IBAction)swipedLeft:(UISwipeGestureRecognizer *)recognizer
{
    if (current_tutorial == 3)
        return;
    
    current_tutorial ++;
    [self updateTutorialView:current_tutorial];
}

- (void)updateTutorialView:(int) tutorial
{
    UIImage *newImage = nil;
    NSString *newText = nil;
    
    switch (tutorial)
    {
        case 1:
            newImage = [UIImage imageNamed:@"Tutorial01"];
            newText = @"טקסט עבור המסך הראשון";
            break;
        case 2:
            newImage = [UIImage imageNamed:@"Tutorial02"];
            newText = @"טקסט עבור המסך השני";
            break;
        case 3:
            newImage = [UIImage imageNamed:@"Tutorial03"];
            newText = @"טקסט עבור המסך השני";
            break;
        default:
            newImage = [UIImage imageNamed:@"Tutorial01"];
            newText = @"טקסט עבור המסך הראשון";
            break;
    }
    
    [UIView transitionWithView:self.view
                      duration:.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        imgTutorial.image = newImage;
                    } completion:nil];
    
    [lblTutorial setText:newText];
}
@end
