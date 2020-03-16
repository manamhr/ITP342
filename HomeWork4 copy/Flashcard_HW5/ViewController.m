//
//  ViewController.m
//  Flashcard_HW5
//
//  Created by Mana Mehraein on 3/13/18.
//  Copyright © 2018 Mana Mehraein. All rights reserved.
//

#import "ViewController.h"
#import "FlashcardsModel.h"
#import "Flashcard.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
//create the model out here
@property (strong, nonatomic) FlashcardsModel* model;


@end

@implementation ViewController

-(void) viewWillAppear:(BOOL)animated{
    
    if (self.model == 0)
    {
        NSLog(@"No more flashcard!");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _model = [FlashcardsModel sharedModel];
    Flashcard* toDisplay = _model.randomFlashcard;
    self.textLabel.text = toDisplay.question;
    
    
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector (singleTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector (doubleTapped:)];
    doubleTap.numberOfTapsRequired=2;
    [self.view addGestureRecognizer:doubleTap];
    // Only recognize single taps if they're not the first of two
    [singleTap requireGestureRecognizerToFail: doubleTap];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self
        action:@selector(left:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(right:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    
}

-(void) singleTapped: (UITapGestureRecognizer *) recognizer {
    //self.msgLabel.text=@"Signle Tap";
    //  [self fadeInLabel:@"Hello World"]; out to do innout
    Flashcard* toDisplay = _model.randomFlashcard;
    self.textLabel.text = toDisplay.question;
    [self fadeInLabel: toDisplay.question];
    self.textLabel.textColor=[UIColor blackColor];

}


-(void) doubleTapped: (UITapGestureRecognizer *) answer {
    //self.msgLabel.text=@"Double Tap";
    //[self fadeOutLabel];
    
    // use animation
    Flashcard* curr=  [_model flashcardAtIndex:_model.currentIndex];
    self.textLabel.text=curr.answer; // get current index card and set the text to that value
    [self fadeInLabel: curr.answer];
    self.textLabel.textColor=[UIColor whiteColor];

}

-(void) left: (UISwipeGestureRecognizer *) gest{

    Flashcard* lefted=[self.model nextFlashcard];
    // do animation and show the question
    self.textLabel.text=lefted.question;
    [self fadeInLabel: lefted.question];
    self.textLabel.textColor=[UIColor blackColor];
    
   // [self fadeOutLabel];
    
    
}
//
-(void) right: (UISwipeGestureRecognizer *) gesturee {
    self.textLabel.textColor=[UIColor blackColor];
    Flashcard* righted=[_model prevFlashcard ];
    //do animation fade in fade out
    self.textLabel.text=righted.question;
    [self fadeInLabel: righted.question];
   
}


- (void) fadeInLabel:(NSString *) msg {
    // Alpha = 0 means the text is transparent
    self.textLabel.alpha = 0;
    self.textLabel.text = msg;
    [UIView animateWithDuration:1.0 animations:^{
        // Fade in the text of the label
        self.textLabel.alpha = 1;
    }];
}

-(void) fadeOutLabel{
    self.textLabel.alpha=1;
    
    [UIView animateWithDuration:1.0 animations:^{
        // Fade in the text of the label
        self.textLabel.alpha = 0;
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
