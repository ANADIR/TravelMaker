//
//  SuperViewController.m
//  Travel Maker
//
//  Created by developer on 12/4/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "SuperViewController.h"


@interface SuperViewController ()

@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setKeyBoard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setKeyBoard
{
    [[IQKeyboardManager sharedManager] setOverrideKeyboardAppearance:NO];
    [[IQKeyboardManager sharedManager] setKeyboardAppearance:UIKeyboardAppearanceDefault];
    // [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    [returnKeyHandler setLastTextFieldReturnKeyType:UIReturnKeyDone];
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];
    [[IQKeyboardManager sharedManager] keyboardDistanceFromTextField];
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
