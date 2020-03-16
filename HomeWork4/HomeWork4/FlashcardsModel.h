//
//  FlashcardsModel.h
//  HomeWork4
//
//  Created by Mana Mehraein on 3/13/18.
//  Copyright © 2018 Mana Mehraein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Flashcard.h"

@interface FlashcardsModel : NSObject

@property (readonly) NSUInteger currentIndex; // which is an unsigned integer of the current index of the flashcard that is being displayed.

// Creating the model
+ (instancetype) sharedModel;
// Accessing number of flashcards in model
- (NSUInteger) numberOfFlashcards;
// Accessing a flashcard – sets currentIndex appropriately
- (Flashcard *) randomFlashcard;
- (Flashcard *) flashcardAtIndex: (NSUInteger) index;
- (Flashcard *) nextFlashcard;
- (Flashcard *) prevFlashcard;
// Inserting a flashcard
- (void) insertWithQuestion: (NSString *) question
                     answer: (NSString *) ans
                   favorite: (BOOL) fav;
- (void) insertWithQuestion: (NSString *) question answer: (NSString *) ans
                   favorite: (BOOL) fav
                    atIndex: (NSUInteger) index;
// Removing a flashcard
- (void) removeFlashcard;
- (void) removeFlashcardAtIndex: (NSUInteger) index;
// Favorite/unfavorite the current flashcard
- (void) toggleFavorite;
// Getting the favorite flashcards
- (NSArray *) favoriteFlashcards;

@end
