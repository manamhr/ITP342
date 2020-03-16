//
//  AddViewController.m
//  Flashcard_HW5
//   
//  Created by Mana Mehraein on 4/12/18.
//  Copyright © 2018 Mana Mehraein. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *textTF;
@property (weak, nonatomic) IBOutlet UITextView *qTF;
@property (weak, nonatomic) IBOutlet UITextField *ansTF;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.saveButton.enabled= false;
    self.navItem.title =self.textTitle;
    self.qTF.delegate=self;
    self.ansTF.delegate=self;
    self.ansTF.placeholder=self.ansHolder;
    self.textTF.text= @"Please enter to add your question and answer...";

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
        [self.ansTF resignFirstResponder];
    
    return YES;
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    //NSString *changedString = [textField.text
                               //stringByReplacingCharactersInRange:range withString:string];

        [self enableSaveButton: self.qTF.text
                        answer: self.ansTF.text
                          ];


    return YES;
}
-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    [self enableSaveButton: self.qTF.text
                    answer: self.ansTF.text
     ];

    return YES;
}

- (void)enableSaveButton: (NSString *) question
                  answer: (NSString *) answer

                                        {
    
    self.saveButton.enabled = (question.length > 0 &&
                               answer.length > 0);
}

- (IBAction)cancelButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
   
}
- (IBAction)saveButtonTouched:(id)sender {
    //if (self.addBlock){
//    NSString *q = self.qTF.text;
//    NSString *a = self.ansTF.text;
    self.addBlock(self.qTF.text, self.ansTF.text);  // fav?
   // }
    
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


@end
