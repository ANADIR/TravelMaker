//
//  MenuController.m
//  Travel Maker
//
//  Created by developer on 12/8/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "MenuController.h"

@implementation MenuController

@synthesize vwAbout, vwContact, vwMessage, vwMyMessage, vwPrivacy, vwProfile, vwPush, vwShare;
@synthesize btnPush, btnLogout;
@synthesize imgAvatar;
@synthesize lblName;

BOOL bPushEnabled;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TODO
    bPushEnabled = NO;
    [btnPush setSelected:bPushEnabled];
    
    // Add tapGesture
    UITapGestureRecognizer *tapAbout = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAbout)];
    tapAbout.delegate = self;
    [vwAbout addGestureRecognizer:tapAbout];
    
    UITapGestureRecognizer *tapContact = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapContact)];
    tapContact.delegate = self;
    [vwContact addGestureRecognizer:tapContact];
    
    UITapGestureRecognizer *tapMessage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapMessage)];
    tapMessage.delegate = self;
    [vwMessage addGestureRecognizer:tapMessage];
    
    UITapGestureRecognizer *tapMyMessage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapMyMessage)];
    tapMyMessage.delegate = self;
    [vwMyMessage addGestureRecognizer:tapMyMessage];

    UITapGestureRecognizer *tapPrivacy = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPrivacy)];
    tapPrivacy.delegate = self;
    [vwPrivacy addGestureRecognizer:tapPrivacy];

    UITapGestureRecognizer *tapProfile = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapProfile)];
    tapProfile.delegate = self;
    [vwProfile addGestureRecognizer:tapProfile];

    UITapGestureRecognizer *tapPush = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPush)];
    tapPush.delegate = self;
    [vwPush addGestureRecognizer:tapPush];
    
    UITapGestureRecognizer *tapShare = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapShare)];
    tapShare.delegate = self;
    [vwShare addGestureRecognizer:tapShare];


    // make underline text
    NSArray * objects = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:NSUnderlineStyleSingle], nil];
    NSArray * keys = [[NSArray alloc] initWithObjects:NSUnderlineStyleAttributeName, nil];
    NSDictionary * linkAttributes = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:btnLogout.titleLabel.text attributes:linkAttributes];
    [btnLogout.titleLabel setAttributedText:attributedString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITapGestureRecognizer handler
- (void)handleTapAbout
{
    
}

- (void)handleTapContact
{
    
}

- (void)handleTapMessage
{
    
}

- (void)handleTapMyMessage
{
    
}

- (void)handleTapPrivacy
{
    
}

- (void)handleTapProfile
{
    
}

- (void)handleTapPush
{
    
}

- (void)handleTapShare
{
    
}


#pragma mark - IBAction
- (void)clickLogout:(id)sender
{
    
}

- (void)clickPush:(id)sender
{
    bPushEnabled = !bPushEnabled;
    [btnPush setSelected:bPushEnabled];
}

@end
