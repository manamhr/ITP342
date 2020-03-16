//
//  ViewController.m
//  HW3
//
//  Created by Mana Mehraein on 2/9/18.
//  Copyright © 2018 Mana Mehraein. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// class extension
// private outlets
@property (weak, nonatomic) IBOutlet UITextField *billPrice;
@property (weak, nonatomic) IBOutlet UILabel *billLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *taxSegControl;
@property (weak, nonatomic) IBOutlet UILabel *taxLabel;
@property (weak, nonatomic) IBOutlet UISwitch *taxSwitch;

@property (weak, nonatomic) IBOutlet UILabel *taxSwitchLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepperLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepperLabelLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowerTaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *calculatedStuffs;
@property (weak, nonatomic) IBOutlet UISlider *tipSlider;


// private properties
@property float tax;
@property float taxPercent;
@property float totalForTip;
@property float tip;
@property float totalWithTip;
@property float totalPerPerson;
@property int divide;
@property float bill;
@property BOOL includeTax;
@property float tipPercent;

//double taxPrice=8.00;
//    @property(strong,nonatomic) NSUInteger* totalForTip = [NSNumber numberWithDouble:8.00];
//


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void) setDefaults {
    // set all of the floats to
    //    self.tax=7.5;
    //    self.taxPercent=0.00;
    //    self.totalForTip=0.00;
    
    self.tip=0.00;
    self.totalWithTip=0.00;
    self.totalPerPerson=0.00;
    //    self.bill=0.00;
    //    self.includeTax=7.5;
    self.tipPercent=0.0;
    self.divide=1;
    //    self.tipSlider=0;
    //    [self CalculateStuff];
}


- (IBAction)KeyboardDone:(id)sender {
    [sender resignFirstResponder];
    [self setDefaults];
    [self CalculateStuff];
}
- (IBAction)taxSlider:(id)sender {
    self.includeTax = self.taxSwitch.isOn;
    [self CalculateStuff];}

- (IBAction)sliderChange:(UISlider*)sender {
    
    int numberAsInt = (int)(sender.value);
    NSString* labelStr=[NSString stringWithFormat: @"%i%%", numberAsInt];
    self.percentLabel.text=labelStr;
    self.tipPercent=numberAsInt;
    
    [self CalculateStuff];
    
}


- (IBAction)segmentedChange:(id)sender {
    
    
    [self CalculateStuff];
    
}




- (IBAction)stepperChanged:(id)sender {
    
    UIStepper* stepper=(UIStepper *) sender;
    int number2AsInt = (int) (stepper.value );
    self.stepperLabel.text=[NSString stringWithFormat:@"%i", number2AsInt];
    self.divide=number2AsInt;
    
    [self CalculateStuff];
    
}
- (IBAction)ClearAllButton:(id)sender {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Clear All Values"
                                                                             message:@"Are you sure you want to clear all values?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) { /* Do Nothing */ }];
    UIAlertAction *clearAllAction = [UIAlertAction actionWithTitle:@"Clear All" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"Clear All");
        [self clearAll]; // calling another method
        
    }];
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:clearAllAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void) clearAll {
    [self.billPrice resignFirstResponder];
    self.billPrice.text = @"";
    self.tipSlider.value=0;
    [self CalculateStuff];
    
//    self.stepperLabel.text = @"1";
    self.percentLabel.text = @"0%";
//    self.calculatedStuffs.text = @"";
//    self.lowerTaxLabel.text=@"";
    
}
- (void)CalculateStuff {
    
    NSString *title = [self.taxSegControl titleForSegmentAtIndex:self.taxSegControl.selectedSegmentIndex];
    //grabbing the string value
    
    self.taxPercent = [title floatValue];
    
    self.bill = [[self.billPrice text] floatValue]; // get the bill
    
    self.tax = self.bill * (self.taxPercent/100.0);
    
    if (self.includeTax)
        self.totalForTip= self.bill+ self.tax;
    else
        self.totalForTip=self.bill;
    
    
    self.tip=_totalForTip*(self.tipPercent/100.0);
    
    self.totalWithTip=self.bill+self.tax+self.tip;
    self.totalPerPerson=self.totalWithTip/self.divide;
    
    
    
    // create my messageString using info from IB components
    
    self.calculatedStuffs.text = [NSString stringWithFormat:
                                  @"$ %0.2f\n$ %0.2f\n$ %0.2f\n$ %0.2f\n$ %0.2f",
                                  self.tax,
                                  self.totalForTip,
                                  self.tip,
                                  self.totalWithTip,
                                  self.totalPerPerson];
    
    [self LowerTaxLabelStuff];
    
}


- (void)LowerTaxLabelStuff {
    
    
    // create my messageString using info from IB components
    
    self.lowerTaxLabel.text = [NSString stringWithFormat:
                               @"Tax\nTotal for tip\nTip\nTotal with tip\nTotal per person"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
