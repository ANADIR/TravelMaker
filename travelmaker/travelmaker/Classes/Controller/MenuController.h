//
//  MenuController.h
//  Travel Maker
//
//  Created by developer on 12/8/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "SuperViewController.h"

@interface MenuController : SuperViewController <UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UIView *vwMyMessage;
@property (nonatomic, weak) IBOutlet UIView *vwMessage;
@property (nonatomic, weak) IBOutlet UIView *vwProfile;
@property (nonatomic, weak) IBOutlet UIView *vwAbout;
@property (nonatomic, weak) IBOutlet UIView *vwContact;
@property (nonatomic, weak) IBOutlet UIView *vwShare;
@property (nonatomic, weak) IBOutlet UIView *vwPush;
@property (nonatomic, weak) IBOutlet UIView *vwPrivacy;

@property (nonatomic, weak) IBOutlet UIButton *btnPush;
@property (nonatomic, weak) IBOutlet UIImageView *imgAvatar;
@property (nonatomic, weak) IBOutlet UILabel *lblName;
@property (nonatomic, weak) IBOutlet UIButton *btnLogout;


- (IBAction)clickLogout:(id)sender;
- (IBAction)clickPush:(id)sender;

@end
