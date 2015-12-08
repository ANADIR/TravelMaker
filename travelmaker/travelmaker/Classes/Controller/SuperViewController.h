//
//  SuperViewController.h
//  Travel Maker
//
//  Created by developer on 12/4/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQKeyboardManager.h>
#import <IQKeyboardReturnKeyHandler.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface SuperViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    IQKeyboardReturnKeyHandler *returnKeyHandler;
}

@end
