//
//  Flashcard.m
//  HomeWork4
//
//  Created by Mana Mehraein on 3/13/18.
//  Copyright © 2018 Mana Mehraein. All rights reserved.
//

#import "Flashcard.h"

@implementation Flashcard

- (instancetype) initWithQuestion: (NSString *) question
                           answer: (NSString *) ans{
    

        self = [super init];
        if (self) {
            _question=question;
            _answer=ans;
            _isFavorite = false;
            
        }
        return self;
    }
 

- (instancetype) initWithQuestion: (NSString *) question
                           answer: (NSString *) ans
                       isFavorite: (BOOL) isFav{
    
    self = [super init];
    if (self) {
        _question=question;
        _answer=ans;
        _isFavorite=isFav;
        
    }
    return self;
}
@end
