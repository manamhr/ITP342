//
//  ViewController.m
//  HW2
//
//  Created by Mana Mehraein on 1/29/18.
//  Copyright © 2018 Mana Mehraein. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextFrield;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (strong, nonatomic) NSString *announcement; // if we make them here we can use them on the entire class


@end

@implementation ViewController
- (IBAction)DoodleButton:(id)sender {
    [self.nameTextFrield resignFirstResponder]; // by clicking tap the keyboard goes away
    //local variables
    self.announcement = @"I am a cute mini Golden Doodle";
    NSString *message;

    NSString *name=[self.nameTextFrield text];
    
    if (name.length > 0)
    {
 
        message= [NSString stringWithFormat: @"%@, %@! ", self.announcement, name];
    }
    else
    {
        message = self.announcement;
    }
    // get info from textField
    self.messageLabel.text=message;
}
- (IBAction)FBulldogButton:(id)sender {
    [self.nameTextFrield resignFirstResponder]; // by clicking tap the keyboard goes away
    //local variables
    self.announcement = @"I am a bored French Bulldog";
    NSString *message;
    
    NSString *name=[self.nameTextFrield text];
    
    if (name.length > 0)
    {
        
        message= [NSString stringWithFormat: @"%@, %@! ", self.announcement, name];
    }
    else
    {
        message = self.announcement;
    }
    // get info from textField
    self.messageLabel.text=message;
}
- (IBAction)ResetButton:(id)sender {
    
    [self.nameTextFrield resignFirstResponder];
    //self.announcement = @" ";
    self.messageLabel.text = @"";
    self.nameTextFrield.text = @"";
}
- (IBAction)KeyboardDone:(id)sender {
    [self.nameTextFrield resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
