//
//  ViewController.m
//  PTKPayment Example
//
//  Created by Alex MacCaw on 1/21/13.
//  Copyright (c) 2013 Stripe. All rights reserved.
//

#import "UpdateCardViewController.h"
#import "Stripe.h"
#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
#import <ParseUI/ParseUI.h>

@interface UpdateCardViewController()

@property IBOutlet PTKView* paymentView;

@property NSString *emailString;

@end

@implementation UpdateCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    self.title = @"Change Card";

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = saveButton;

    self.paymentView = [[PTKView alloc] initWithFrame:CGRectMake(15, 25, 290, 45)];
    self.paymentView.delegate = self;

    [self.view addSubview:self.paymentView];

    self.emailString = [[PFUser currentUser] username];
    NSLog(@"%@", self.emailString);
}


- (void) paymentView:(PTKView *)paymentView withCard:(PTKCard *)card isValid:(BOOL)valid
{
    self.navigationItem.rightBarButtonItem.enabled = valid;
}

- (IBAction)save:(id)sender
{
    STPCard *card = [[STPCard alloc] init];
    card.number = self.paymentView.card.number;
    card.expMonth = self.paymentView.card.expMonth;
    card.expYear = self.paymentView.card.expYear;
    card.cvc = self.paymentView.card.cvc;

    //Logs
    NSLog(@"Card last4: %@", card.last4);
    NSLog(@"Card expiry: %lu/%lu", (unsigned long)card.expMonth, (unsigned long)card.expYear);
    NSLog(@"Card cvc: %@", card.cvc);

    [[NSUserDefaults standardUserDefaults] setValue:card.last4 forKey:@"card.last4"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[STPAPIClient sharedClient] createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        if (error)
        {
            //TODO: handle error
        }
        else
        {
            [PFCloud callFunctionInBackground:@"createCustomer" withParameters:@{@"token": token.tokenId, @"customerName": PFUser.currentUser.username, @"email": self.emailString} block:^(id customer, NSError *error) {
                if (error != nil)
                {
                    NSLog(@"%@", error);
                }
                else
                {
                    NSLog(@"Successfully created customer");
                    //Save customer (via id) to defaults for future transactions
                    [[NSUserDefaults standardUserDefaults] setObject:customer[@"id"] forKey:@"customerId"];
                    [[NSUserDefaults standardUserDefaults] setValue:@"CreditCard" forKey:@"preferredPaymentType"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self dismissViewControllerAnimated:true completion:nil];
                }
            }];
        }
    }];
}

@end
