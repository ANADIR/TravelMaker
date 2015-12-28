//
//  LoginController.m
//  Travel Maker
//
//  Created by developer on 12/4/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "LoginController.h"
#import "MFSideMenu.h"
#import "TrafficController.h"
#import "MenuController.h"
#import "AppDelegate.h"


@interface LoginController ()

@end

@implementation LoginController

@synthesize vwEmail, vwPasswd;
@synthesize txtEmail, txtPasswd;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIGraphicsBeginImageContext(vwEmail.frame.size);
    [[UIImage imageNamed:@"FieldEmail"] drawInRect:vwEmail.bounds];
    UIImage *imgEmail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [vwEmail setBackgroundColor:[UIColor colorWithPatternImage:imgEmail]];
    
    UIGraphicsBeginImageContext(vwPasswd.frame.size);
    [[UIImage imageNamed:@"FieldPassword"] drawInRect:vwPasswd.bounds];
    UIImage *imgPasswd = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [vwPasswd setBackgroundColor:[UIColor colorWithPatternImage:imgPasswd]];
    
    // TODO for release
    [txtEmail setText:@"test@gmail.com"];
    [txtPasswd setText:@"12345678"];
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

- (IBAction)clickBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickFacebook:(id)sender
{
    // TODO
}

- (IBAction)clickEnter:(id)sender
{
    NSString *email = [txtEmail text];
    if ([Common checkEmailValidation:email] == NO)
    {
        [Common showAlert:@"error" Message:@"Please input a valid email address." ButtonName:@"Ok"];
        return;
    }
    
    NSString *passwd = [txtPasswd text];
    if ([Common checkPasswordValidation:passwd] == NO)
    {
        [Common showAlert:@"error" Message:@"Password is no less than 6 characters." ButtonName:@"Ok"];
        return;
    }

    NSString * loginUrl = @"http://travelmakerdata.co.nf/server/index.php?action=login_user";
    loginUrl = [NSString stringWithFormat:@"%@&email=%@",loginUrl, email];
    loginUrl = [NSString stringWithFormat:@"%@&password=%@",loginUrl, passwd];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [DCDefines getHttpAsyncResponse:loginUrl :^(NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        NSData *responseData = data;
        if (responseData == nil) {
            return;
        }
        NSString *string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"result string: %@", string);
        
        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        NSString * status = [jsonDict objectForKey:@"status"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([status isEqualToString:@"logged OK"] == NO) {
                [Common showAlert:@"Error" Message:@"Failed on logging in." ButtonName:@"Ok"];
            }
            else
            {
                //
                NSString *user_id = [jsonDict objectForKey:@"user_id"];
                NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
                [preferences setObject:user_id forKey:@"user_id"];

                
                AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                
                TrafficController *trafficController = [self.storyboard instantiateViewControllerWithIdentifier:@"trafficVC"];
                MenuController *menuController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
                
                MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                                containerWithCenterViewController:trafficController
                                                                leftMenuViewController:menuController
                                                                rightMenuViewController:nil];
                
                [trafficController setMenuController:container];
                
                delegate.window.rootViewController = container;
                [delegate.window makeKeyAndVisible];

            }
        });
    }];
    
}

- (IBAction)clickReminder:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Forgot Password"
                                                     message:@"Please input your registration email."
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"Ok", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeEmailAddress;
    
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // cancel
    }
    else
    {
        // Ok
        UITextField * alertTextField = [alertView textFieldAtIndex:0];
        NSString *email = [alertTextField text];
        if ([Common checkEmailValidation:email] == NO)
        {
            [Common showAlert:@"error" Message:@"Please input a valid email address." ButtonName:@"Ok"];
            return;
        }
        
        NSString * reminderUrl = @"http://travelmakerdata.co.nf/server/index.php?action=email_password";
        reminderUrl = [NSString stringWithFormat:@"%@&email=%@",reminderUrl, email];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [DCDefines getHttpAsyncResponse:reminderUrl :^(NSData *data, NSError *connectionError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            
            NSData *responseData = data;
            if (responseData == nil) {
                return;
            }
            NSString *string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            NSLog(@"result string: %@", string);
            
            NSError *error;
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
            NSString * status = [jsonDict objectForKey:@"status"];
            dispatch_async(dispatch_get_main_queue(), ^{
                if([status isEqualToString:@"email sent"] == NO) {
                    [Common showAlert:@"Error" Message:@"No existent email." ButtonName:@"Ok"];
                }
                else
                    [Common showAlert:@"Success" Message:@"Sent email." ButtonName:@"Ok"];
            });
        }];

        
    }
}
@end
