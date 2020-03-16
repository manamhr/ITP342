//
//  AddViewController.h
//  Flashcard_HW5
//
//  Created by Mana Mehraein on 4/12/18.
//  Copyright © 2018 Mana Mehraein. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddFlashcard) (NSString* question, NSString* answer );

@interface AddViewController : UIViewController

@property(copy, nonatomic) AddFlashcard addBlock;
@property(strong, nonatomic) NSString* textTitle;
@property(strong, nonatomic) NSString* qTitle;
@property(strong, nonatomic) NSString* ansHolder;

@end
