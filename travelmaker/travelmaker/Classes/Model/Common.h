//
//  Common.h
//  Travel Maker
//
//  Created by developer on 12/8/15.
//  Copyright © 2015 developer. All rights reserved.
//

#ifndef Common_h
#define Common_h

#import <UIKit/UIKit.h>

@interface Common : NSObject

#define CELLPHONE_MAXLENGTH 10
#define PASSWORD_MINENGTH   6


+ (BOOL)checkEmailValidation:(NSString *)email;
+ (BOOL)checkPasswordValidation:(NSString *)password;
+ (BOOL)checkPhoneValidation:(NSString *)phone;
+ (void)showAlert:(NSString *)title Message:(NSString *)message ButtonName:(NSString *)buttonname;


@end

#endif /* Common_h */
