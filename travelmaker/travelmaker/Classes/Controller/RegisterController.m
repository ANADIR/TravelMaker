//
//  RegisterController.m
//  Travel Maker
//
//  Created by developer on 12/7/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterEmailController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface RegisterController ()

@end

@implementation RegisterController


#define CELLPHONE_MAXLENGTH 10
#define PHONE_PADDING_WIDTH 20

@synthesize txtCellPhone;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [txtCellPhone setDelegate:self];
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

- (IBAction)clickFacebook:(UIButton *)sender
{
    if ([self checkValidation] == YES)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Please wait...";

        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        
        [login logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {

            [hud hide:YES];
            if (error)
            {
                [self showAlert:@"Error" Message:@"Failed on logging in facekbook." ButtonName:@"Ok"];
            }
            else
            {
                if(result.token)   // This means if There is current access token.
                {
                    // Token created successfully and you are ready to get profile info
                    [self getFacebookProfileInfos];
                }

            }
        }];
    }
    else
    {
        [self showAlert:@"error" Message:@"The phone number must be total 10 digits." ButtonName:@"Ok"];
    }
}

-(void)getFacebookProfileInfos {
    
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:nil];
    
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Getting User information...";

    [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        
        [hud hide:YES];
        
        if(result)
        {
            if ([result objectForKey:@"email"]) {
                
                NSLog(@"Email: %@",[result objectForKey:@"email"]);
                
            }
            if ([result objectForKey:@"first_name"]) {
                
                NSLog(@"First Name : %@",[result objectForKey:@"first_name"]);
                
            }
            if ([result objectForKey:@"id"]) {
                
                NSLog(@"User id : %@",[result objectForKey:@"id"]);
                
            }
            
        }
        
    }];
    
    [connection start];
}

- (IBAction)clickEmail:(UIButton *)sender
{
    if ([self checkValidation] == YES)
    {
        RegisterEmailController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"registerEmailVC"];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        [self showAlert:@"error" Message:@"The phone number must be total 10 digits." ButtonName:@"Ok"];
    }
}

- (BOOL)checkValidation
{
    int length = [[txtCellPhone text] length];
    
    if (length < CELLPHONE_MAXLENGTH)
        return NO;
    
    return YES;
}

-(void) showAlert:(NSString *)title Message:(NSString *)message ButtonName:(NSString *)buttonname
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:buttonname
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= CELLPHONE_MAXLENGTH;
}

@end
