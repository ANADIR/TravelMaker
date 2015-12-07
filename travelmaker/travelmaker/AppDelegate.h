//
//  AppDelegate.h
//  Agombi
//
//  Created by Filip on 10/2/15.
//  Copyright (c) 2015 Filip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/CloudMessaging.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, GGLInstanceIDDelegate, GCMReceiverDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, readonly, strong) NSString *registrationKey;
@property(nonatomic, readonly, strong) NSString *messageKey;
@property(nonatomic, readonly, strong) NSString *pushGotKey;
@property(nonatomic, readonly, strong) NSString *gcmSenderID;
@property(nonatomic, readonly, strong) NSDictionary *registrationOptions;

@property(nonatomic, strong) NSString* registrationToken;

@end

